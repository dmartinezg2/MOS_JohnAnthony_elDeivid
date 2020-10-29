# -- coding: utf-8 --
"""
Created on Fri Oct 23 21:11:36 2020

@author: Juan Antonio Restrepo y David Martinez
"""
from __future__ import division
from pyomo.environ import *

from pyomo.opt import SolverFactory
# SETS & PARAMETERS ********

tiposCanciones= {
    1:"Blues",
    2:"Rock",
    3:"Blues",
    4:"Rock",
    5:"Blues",
    6:"Rock",
    7:"Ninguno",
    8:"B y R"
}

duracionCanciones = {
    1:4,
    2:5,
    3:3,
    4:2,
    5:4,
    6:3,
    7:5,
    8:4
}
cancionesBlues = {
    1,
    3,
    5,
    8
}
cancionesRock = {
    2,
    4,
    6,
    8
}

model = ConcreteModel()

songs = 8
N=RangeSet(1,songs)

#Dice si llevo la cancion o no en el lado A
model.ladoA = Var(N, domain=Binary)
#Dice si llevo o no la cancion para el lado B
model.ladoB = Var(N, domain=Binary)

model.obj = Objective(expr=sum(model.ladoA[i]*duracionCanciones[i] for i in N) + sum(model.ladoB[i]*duracionCanciones[i] for i in N), sense=maximize)


#Por el lado A debe tener por lo menos entre 14 y 16 minutos de duracion
def duracion_maxLadoA(model):
    duration = sum(model.ladoA[i] * duracionCanciones[i] for i in N)
    return inequality(14, duration, 16, False)


#Por el lado B debe tener por lo menos entre 14 y 16 minutos de duracion
def duracion_maxLadoB(model):
    duration = sum(model.ladoB[i] * duracionCanciones[i] for i in N)
    return inequality(14, duration, 16, False)

#Canciones Blues por lado A
def blues_ladoA(model):
    return sum(model.ladoA[i] for i in cancionesBlues) ==2


#Canciones Blues por lado B
def blues_ladoB(model):
    return sum(model.ladoB[i] for i in cancionesBlues) ==2


#Canciones Rock por lado A deben ser por lo menos 3
def rock_ladoA(model):
    return sum(model.ladoA[i] for i in cancionesRock) >=3

#No funciono :(
#def cancion5_rule(model):
#   rta = 0
#    if model.ladoA[1] ==1 and model.ladoA[5] ==1:
#        rta = 2
#        return rta
#   else:
#        rta=1
#        return rta

#def canciones_rule(model):
#    if model.ladoA[2] == 1 and model.ladoA[4] == 1 and model.ladoB[1] == 1:
#        return True
#    else:
#        return False


model.songA = Constraint(expr= sum(model.ladoA[i] for i in [1,5]) <= 1)
model.songs = Constraint(expr= sum(model.ladoA[i] for i in [2,4])-1 <= model.ladoB[1])
model.duracionA =Constraint(rule = duracion_maxLadoA)
model.duracionB =Constraint(rule = duracion_maxLadoB)
model.bluesA = Constraint(rule = blues_ladoA)
model.bluesB = Constraint(rule = blues_ladoB)
model.rockA = Constraint(rule = rock_ladoA)



SolverFactory('glpk').solve(model)

model.display()