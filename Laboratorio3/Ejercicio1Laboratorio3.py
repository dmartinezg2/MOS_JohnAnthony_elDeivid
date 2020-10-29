# -*- coding: utf-8 -*-
"""
Created on Fri Oct 16 16:03:14 2020

@author: Juan Antonio Restrepiño

Suponga que el gobernador de un departamento de 6 pueblos desea determinar en 
cuál de ellos debe poner una estación de bomberos. Para ello la gobernación desea
construir la mínima cantidad de estaciones que asegure que al menos habrá una 
estación dentro de 15 minutos (tiempo para conducir) en cada pueblo. 

Los tiempos requeridos (en minutos) para conducir entre ciudades se muestran 
en la siguiente tabla:

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

m = ConcreteModel()

# SETS & PARAMETERS *****************************************************************

numPueblos = 6

N = RangeSet(1,numPueblos)

distancias={(1,1):0, (1,2):10, (1,3):20, (1,4):30, (1,5):30, (1,6):20,\
            (2,1):10, (2,2):0, (2,3):25, (2,4):35, (2,5):20, (2,6):10,\
            (3,1):20, (3,2):25, (3,3):0, (3,4):15, (3,5):30, (3,6):20,\
            (4,1):30, (4,2):35, (4,3):15, (4,4):0, (4,5):15, (4,6):25,\
            (5,1):30, (5,2):20, (5,3):30, (5,4):15, (5,5):0, (5,6):14,\
            (6,1):20, (6,2):10, (6,3):20, (6,4):25, (6,5):14, (6,6):0}

print(distancias)
# VARIABLES ************************************************************************

m.estacion = Var(N, domain=Binary)

#OBJECTIVE FUNCTION*****************************************************************

m.obj = Objective(expr =sum(m.estacion[i] for i in N), sense = minimize)


# CONSTRAINTS **********************************************************************
m.res1=ConstraintList()
for i in N:
    m.res1.add(sum(m.estacion[j] for j in N if distancias[i,j]<=15)>=1)
# APPLYING THE SOLVER **************************************************************
SolverFactory('glpk').solve(m)

m.display()


        



