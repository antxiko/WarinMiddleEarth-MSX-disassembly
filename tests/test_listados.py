#!/usr/bin/env python3
"""Comprobaciones sobre los cinco listados.

Ninguna necesita la cinta: se hacen sobre los src/*.asm y src/*.notes, que van
en el repositorio. Este desensamblado esta a medias, asi que estos tests no
afirman que este completo: vigilan que lo que YA esta hecho no se degrade sin
que nadie se entere -que no se pierdan comentarios al retrazar, que no se
solapen rangos, y que los listados los siga generando la herramienta-.
"""
import os
import re
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(RAIZ, "src")

# Cada bloque: su listado y sus anotaciones.
BLOQUES = [
    ("loader", "war_loader.asm", "loader.notes"),
    ("pantalla", "war_pantalla.asm", "pantalla.notes"),
    ("bajo", "war_bajo.asm", "bajo.notes"),
    ("medio", "war_medio.asm", "medio.notes"),
    ("alto", "war_alto.asm", "alto.notes"),
]


def lee(nombre):
    with open(os.path.join(SRC, nombre), encoding="utf-8") as f:
        return f.read()


def directivas(notas, clave):
    return [l for l in notas.splitlines() if l.startswith(clave + " ")]


class TestListados(unittest.TestCase):

    def test_estan_los_cinco_bloques(self):
        """Los cinco listados y sus cinco ficheros de anotaciones."""
        for nombre, asm, notes in BLOQUES:
            self.assertTrue(os.path.exists(os.path.join(SRC, asm)),
                            "falta el listado de %s" % nombre)
            self.assertTrue(os.path.exists(os.path.join(SRC, notes)),
                            "faltan las anotaciones de %s" % nombre)

    def test_los_listados_los_genera_la_herramienta(self):
        """Un .asm editado a mano se pierde en el siguiente retrazado."""
        for nombre, asm, _ in BLOQUES:
            self.assertIn("Generado por tools/mkasm.py", lee(asm),
                          "%s no lo ha generado mkasm.py" % nombre)

    def test_todos_los_comentarios_llegan_al_listado(self):
        """Un comentario anclado a una direccion que ya no existe se pierde."""
        for nombre, asm, notes in BLOQUES:
            texto = lee(asm)
            vivas = set(re.findall(r";([0-9a-f]{4})(?:\s|$)", texto, re.M))
            perdidos = [l.split()[1] for l in directivas(lee(notes), "C")
                        if l.split()[1][2:].lower() not in vivas]
            self.assertEqual(perdidos, [], "%s: comentarios que no llegan: %s"
                             % (nombre, " ".join(perdidos[:10])))

    def test_todas_las_etiquetas_llegan_al_listado(self):
        """Una L cuyo nombre no aparece definido es una etiqueta perdida."""
        for nombre, asm, notes in BLOQUES:
            texto = lee(asm)
            perdidas = [l.split()[2] for l in directivas(lee(notes), "L")
                        if not re.search(r"^%s:" % re.escape(l.split()[2]),
                                         texto, re.M)]
            self.assertEqual(perdidas, [], "%s: etiquetas que no llegan: %s"
                             % (nombre, " ".join(perdidas[:10])))

    def test_ninguna_direccion_bautizada_dos_veces(self):
        """Dos L para la misma direccion: una de las dos se pierde en silencio."""
        for nombre, _, notes in BLOQUES:
            dirs = [l.split()[1] for l in directivas(lee(notes), "L")]
            repes = sorted({d for d in dirs if dirs.count(d) > 1})
            self.assertEqual(repes, [], "%s: direcciones con dos nombres: %s"
                             % (nombre, " ".join(repes)))

    def test_ninguna_etiqueta_declarada_dos_veces(self):
        """Dos etiquetas con el mismo nombre y el ensamblador se queja."""
        for nombre, asm, _ in BLOQUES:
            nombres = re.findall(r"^([A-Za-z_][\w]*):", lee(asm), re.M)
            repes = sorted({n for n in nombres if nombres.count(n) > 1})
            self.assertEqual(repes, [], "%s: etiquetas repetidas: %s"
                             % (nombre, " ".join(repes)))

    def test_los_rangos_no_se_solapan(self):
        """Dos D que pisan los mismos bytes: uno de los dos esta mal."""
        for nombre, _, notes in BLOQUES:
            rangos = sorted((int(l.split()[1], 16), int(l.split()[2], 16),
                             l.split()[3]) for l in directivas(lee(notes), "D"))
            for (a1, b1, n1), (a2, b2, n2) in zip(rangos, rangos[1:]):
                self.assertLessEqual(b1, a2, "%s: %s (%04X-%04X) pisa a %s"
                                     % (nombre, n1, a1, b1, n2))

    def test_todos_los_rangos_van_al_derecho(self):
        """Un rango acaba despues de empezar."""
        for nombre, _, notes in BLOQUES:
            for l in directivas(lee(notes), "D"):
                a, b = int(l.split()[1], 16), int(l.split()[2], 16)
                self.assertLess(a, b, "%s: %s va del reves"
                                % (nombre, l.split()[3]))

    def test_los_listados_no_hablan_de_otro_juego(self):
        """Los comentarios prestados de otro desensamblado se cuelan solos."""
        otros = ("Pitfall", "Antarctic", "Temptations", "Stardust",
                 "Athletic Land", "Colt 36")
        for nombre, asm, _ in BLOQUES:
            texto = lee(asm)
            for juego in otros:
                self.assertNotIn(juego, texto, "%s nombra %s" % (nombre, juego))


if __name__ == "__main__":
    unittest.main()
