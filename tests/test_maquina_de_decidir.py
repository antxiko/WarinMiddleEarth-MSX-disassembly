"""Lo que afirma la pagina "Como juega la maquina", comprobado sobre la cinta.

El documento dice cuatro cosas fuertes sobre el juego. Ninguna se ha escrito de
memoria: todas salen de los bytes de la cinta, y este
fichero las vuelve a comprobar para que no se queden obsoletas si algun dia
cambia el reparto de bloques.

1. Las dos redes de caminos tienen la forma que decimos -cuatro bytes por cruce,
   64 y 15 cruces- y sus salidas apuntan DENTRO de su propia tabla. Si no, el
   dibujo de `tools/render_redes.py` seria un garabato.
2. La red chica es un TROZO de la grande: cada uno de sus quince cruces esta,
   con la misma columna y la misma fila, en la de 64.
3. Los 24 personajes con nombre llevan 0xC500 = 0, que es la razon de que
   desaparezcan al primer golpe (el cero que 0x8F07 lee como "agotado").
4. La tabla de fichas de tropa tiene DIEZ fichas utiles y no dieciseis: los diez
   primeros tipos traen el mismo par de terrenos intransitables, y del 10 en
   adelante lo que hay ya es codigo.

Los bytes se leen de los LISTADOS (`src/war_medio.asm` y `src/war_alto.asm`),
que es lo que hay en el repositorio y lo que se publica; la cinta no se
distribuye. Como el listado reensambla byte a byte (`make verify`), leer de el
es leer de la cinta.
"""

import os
import re
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
MEDIO = os.path.join(RAIZ, "src", "war_medio.asm")
ALTO = os.path.join(RAIZ, "src", "war_alto.asm")

# `defb 06fh,040h,...	; 6bfb  ....` : detras de la direccion puede ir el
# volcado en ASCII que pone mkasm.py, asi que la linea no acaba ahi.
DEFB = re.compile(r"^\s*defb\s+([^;]+);\s*([0-9a-f]{4})")

RED_GRANDE, CUANTOS_GRANDE = 0x6BFB, 64
RED_CHICA, CUANTOS_CHICA = 0x6CFB, 15
FICHAS_DE_TROPA, FICHAS = 0x6D47, 10
PERSONAJES = 24                      # de Gandalf (0) a Saruman (0x17)


def _bytes_del_listado(ruta):
    """Todo `defb` del listado, indexado por la direccion de su comentario."""
    memoria = {}
    with open(ruta, encoding="utf-8") as f:
        for linea in f:
            m = DEFB.match(linea.rstrip())
            if not m:
                continue
            dire = int(m.group(2), 16)
            for i, valor in enumerate(m.group(1).split(",")):
                valor = valor.strip()
                if not valor.endswith("h"):
                    continue
                memoria[dire + i] = int(valor[:-1], 16)
    return memoria


class Memoria(dict):
    def tramo(self, a, n):
        faltan = [hex(d) for d in range(a, a + n) if d not in self]
        assert not faltan, "no estan en el listado: %s" % faltan[:4]
        return [self[d] for d in range(a, a + n)]


def _red(medio, base, cuantos):
    t = medio.tramo(base, cuantos * 4)
    return [tuple(t[i * 4:i * 4 + 4]) for i in range(cuantos)]


class TestLaMaquinaDeDecidir(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        cls.medio = Memoria(_bytes_del_listado(MEDIO))
        cls.alto = Memoria(_bytes_del_listado(ALTO))

    # ------------------------------------------------------- las dos redes
    def test_las_salidas_de_cada_cruce_caen_dentro_de_su_tabla(self):
        for base, cuantos, nombre in ((RED_GRANDE, CUANTOS_GRANDE, "grande"),
                                      (RED_CHICA, CUANTOS_CHICA, "chica")):
            for i, (_col, _fila, s1, s2) in enumerate(_red(self.medio, base,
                                                           cuantos)):
                for salida in (s1, s2):
                    self.assertLess(
                        salida, cuantos,
                        "la red %s: el cruce %d sale al %d, que no existe"
                        % (nombre, i, salida))

    def test_los_cruces_caen_dentro_del_mapa(self):
        # El mapa jugable es de 128 x 100 casillas (0xCC00, 130 columnas de 102
        # con un borde de una casilla alrededor).
        for base, cuantos in ((RED_GRANDE, CUANTOS_GRANDE),
                              (RED_CHICA, CUANTOS_CHICA)):
            for col, fila, _s1, _s2 in _red(self.medio, base, cuantos):
                self.assertLess(col, 128)
                self.assertLess(fila, 100)

    def test_la_red_chica_es_un_trozo_de_la_grande(self):
        grande = {(c, f) for c, f, _, _ in _red(self.medio, RED_GRANDE,
                                                CUANTOS_GRANDE)}
        chica = _red(self.medio, RED_CHICA, CUANTOS_CHICA)
        for col, fila, _s1, _s2 in chica:
            self.assertIn((col, fila), grande,
                          "el cruce (%d,%d) de la red chica no esta en la "
                          "grande" % (col, fila))

    # --------------------------------------------- por que caen los heroes
    def test_los_personajes_con_nombre_no_llevan_tropa(self):
        tropa = self.alto.tramo(0xC500, 256)
        for n in range(PERSONAJES):
            self.assertEqual(tropa[n], 0,
                             "el personaje %d trae tropa en 0xC500" % n)

    def test_los_ejercitos_si_llevan_tropa(self):
        """Y no es que la tira este vacia: de los 24 para arriba hay tropa."""
        tropa = self.alto.tramo(0xC500, 256)
        con_tropa = sum(1 for n in range(PERSONAJES, 256) if tropa[n] > 0)
        self.assertEqual(con_tropa, 232)

    # -------------------------------------------------- las fichas de tropa
    def test_hay_diez_fichas_de_tropa_y_no_dieciseis(self):
        for tipo in range(FICHAS):
            ficha = self.medio.tramo(FICHAS_DE_TROPA + tipo * 16, 16)
            self.assertEqual(ficha[1], 0xFF, "tipo %d: el terreno 1 deberia "
                             "ser intransitable" % tipo)
            self.assertEqual(ficha[2], 0xFF, "tipo %d: el terreno 2 deberia "
                             "ser intransitable" % tipo)
        # Y donde caeria la ficha once no hay datos: ahi el listado ya tiene
        # CODIGO (0x6DE7 es DESCRIBE_EL_DESTINO), asi que ni un byte suyo
        # aparece en los volcados de datos.
        self.assertNotIn(FICHAS_DE_TROPA + FICHAS * 16, self.medio,
                         "en 0x6DE7 hay datos: la tabla de tropas no acaba "
                         "donde creiamos")

    def test_los_tipos_que_usa_la_cinta_caben_en_las_diez_fichas(self):
        tipos = {b & 0x0F for b in self.alto.tramo(0xBD00, 256)}
        self.assertTrue(max(tipos) < FICHAS,
                        "la cinta usa el tipo %d y solo hay %d fichas"
                        % (max(tipos), FICHAS))

    # ------------------------------------------------------------ el azar
    def test_el_bandazo_esta_sesgado_hacia_un_lado(self):
        """Diez rectos, cuatro a un lado y dos al otro (tabla de 0x6B23)."""
        tabla = [b - 256 if b > 127 else b
                 for b in self.medio.tramo(0x6B23, 16)]
        self.assertEqual(tabla.count(0), 10)
        self.assertEqual(tabla.count(1), 4)
        self.assertEqual(tabla.count(-1), 2)


if __name__ == "__main__":
    unittest.main()
