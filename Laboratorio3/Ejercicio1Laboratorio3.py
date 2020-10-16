# -*- coding: utf-8 -*-
"""
Created on Fri Oct 16 16:03:14 2020

@author: Juan Antonio Restrepiño

Suponga que el gobernador de un departamento de 6 pueblos desea determinar en cuál de ellos debe poner una estación de bomberos. Para ello la gobernación desea construir la mínima cantidad de estaciones que asegure que al menos habrá una estación dentro de 15 minutos (tiempo para conducir) en cada pueblo. Los tiempos requeridos (en minutos) para conducir entre ciudades se muestran en la siguiente tabla:

Tiempo entre pueblos(min)        Pueblo 1        Pueblo 2        Pueblo 3        Pueblo 4        Pueblo 5        Pueblo 6
Pueblo 1        0        10        20        30        30        20
Pueblo 2        10        0        25        35        20        10
Pueblo 3        20        25        0        15        30        20
Pueblo 4        30        35        15        0        15        25
Pueblo 5        30        20        30        15        0        14
Pueblo 6        20        10        20        25        14        0

Implemente un modelo matemático GENÉRICO que permita hallar la cantidad de estaciones de bomberos a construir y donde construirlas.
"""

from __future__ import division
from pyomo.environ import *

from pyomo.opt import SolverFactory

Model = ConcreteModel()





