# -*- coding: utf-8 -*-
"""
Created on Thu Oct 29 13:32:09 2020

@author: Juan Antonio Restrepo & David Martinez G

Dado el creciente número de ciclorrutas puesta en toda la ciudad una de las dudas de los ciclistas que quieren utilizar este medio para transportarse es 
la seguridad de las rutas. El objetivo de esta propuesta es crear un modelo de optimización que tome todas las rutas posibles que puede tomar un ciclista
 de un punto inicial a un punto final y proponerle la más segura en términos de seguridad vial, menos robos y otros parámetros indicativos y calificativos
 de la ruta. Inicialmente el proyecto se haría para la ruta más segura hacia la Universidad de los Andes, sin embargo, lo ideal sería que fuera escalable.
 En este caso buscaremos las rutas que tengan un CAI en el camino para velar por la seguridad de los ciclistas. Además de esto, debería tener por lo menos 
 una parada a lo largo de la ruta donde tomar café o arreglar la bicicleta. 
"""
from __future__ import division
from pyomo.opt import SolverFactory
from pyomo.environ import *

# SETS & PARAMETERS********************************************************************
setNodos={1:"Calle 26 con 7", 2:"Calle 22 con 7", 3:"Calle 26 con Caracas", 4: "Carrera 7 con 40",5:"Universidad de los Andes"}

setDistancia = {(1,1):999, (1,2):4,   (1,3):12,   (1,4):14, (1,5):999,\
         (2,1):4, (2,2):999, (2,3):999, (2,4):999, (2,5):4,\
         (3,1):12, (3,2):999, (3,3):999, (3,4):999,   (3,5):999,\
         (4,1):14, (4,2):999, (4,3):999, (4,4):999, (4,5):999,\
         (5,1):999, (5,2):4, (5,3):999, (5,4):999, (5,5):999}
    
setSeguridad= {(1,1):999, (1,2):6,   (1,3):8,   (1,4):4, (1,5):999,\
         (2,1):6, (2,2):999, (2,3):999, (2,4):999, (2,5):4,\
         (3,1):7, (3,2):999, (3,3):999, (3,4):999,   (3,5):999,\
         (4,1):4, (4,2):999, (4,3):999, (4,4):999, (4,5):999,\
         (5,1):999, (5,2):8, (5,3):999, (5,4):999, (5,5):999}
    
setTiempo = {(1,1):999, (1,2):12,   (1,3):16,   (1,4):8, (1,5):999,\
         (2,1):12, (2,2):999, (2,3):999, (2,4):999, (2,5):12,\
         (3,1):14, (3,2):999, (3,3):999, (3,4):999,   (3,5):999,\
         (4,1):8, (4,2):999, (4,3):999, (4,4):999, (4,5):999,\
         (5,1):999, (5,2):8, (5,3):999, (5,4):999, (5,5):999}

setCai = {(1,1):0, (1,2):0,   (1,3):1,   (1,4):1, (1,5):0,\
         (2,1):0, (2,2):0, (2,3):0, (2,4):0, (2,5):1,\
         (3,1):1, (3,2):0, (3,3):0, (3,4):0,   (3,5):0,\
         (4,1):1, (4,2):0, (4,3):0, (4,4):0, (4,5):0,\
         (5,1):0, (5,2):1, (5,3):0, (5,4):0, (5,5):0}

m = ConcreteModel()
# VARIABLES****************************************************************************
N= RangeSet(1,5)

m.x = Var(N,N, domain=Binary)

inputMinTiempo= int(input("Ingrese el tiempo mínimo de la ruta que quiere escoger \n"))
print(inputMinTiempo)
inputMaxDistancia= int(input("Ingrese distancia máxima de la ruta que quiere escoger \n"))
print(inputMaxDistancia)

# OBJECTIVE FUNCTION*******************************************************************
m.obj = Objective(expr= sum(m.x[i,j]*setSeguridad[i,j] for i in N for j in N), sense=maximize )
# CONSTRAINTS**************************************************************************
def func_Distancia(m):
    return  sum(m.x[i,j]*setDistancia[i,j] for i in N for j in N) <= inputMaxDistancia
# APPLYING THE SOLVER******************************************************************
m.Distancia = Constraint(rule = func_Distancia)

SolverFactory("glpk").solve(m)
sol =sum(m.x[i,j].value for i in N for j in N)
m.display()
print(f"Valor seguridad : {sol}")