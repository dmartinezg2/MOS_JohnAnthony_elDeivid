# -*- coding: utf-8 -*-
"""
Created on Tue oct 27

@author: Juan Antonio Restrepo  & David Martinez G
"""
from __future__ import division
from pyomo.opt import SolverFactory
from pyomo.environ import *


Model = ConcreteModel()

# SETS & PARAMETERS********************************************************************

#Conjunto del numero de trabajadores enecesitados por dia de la semana.
setDias = {"Lunes": 17,"Martes": 13,"Miercoles": 15, "Jueves": 19,"Viernes": 14, "Sabado": 16, "Domingo": 11 }
# Conjunto de opciones que va a utilizarse para calculart el numero de dias libres que se le debe dar a los empleados.
setOpciones =  {1,2,3,4,5,6,7}

# VARIABLES****************************************************************************
#En esta variable se guarda el número de trabajadores que trbajaran ese dia.
Model.setDias = Var(setOpciones, domain=PositiveReals)

# OBJECTIVE FUNCTION*******************************************************************

Model.obj = Objective(expr=sum(Model.setDias[i] for i in setOpciones))

# CONSTRAINTS**************************************************************************

Model.Lunes = Constraint(expr= sum(Model.setDias[i] for i in [1,2,3,4,5]) >= setDias["Lunes"])      
Model.Martes = Constraint(expr= sum(Model.setDias[i] for i in [2,3,4,5,6]) >= setDias["Martes"])    
Model.Miercoles = Constraint(expr= sum(Model.setDias[i] for i in [3,4,5,6,7]) >= setDias["Miercoles"])    
Model.Jueves = Constraint(expr= sum(Model.setDias[i] for i in [4,5,6,7,1]) >= setDias["Jueves"])    
Model.Viernes = Constraint(expr= sum(Model.setDias[i] for i in [5,6,7,1,2]) >= setDias["Viernes"])    
Model.Sabado = Constraint(expr= sum(Model.setDias[i] for i in [6,7,1,2,3]) >= setDias["Sabado"])    
Model.Domingo = Constraint(expr= sum(Model.setDias[i] for i in [7,1,2,3,4]) >= setDias["Domingo"])    

# APPLYING THE SOLVER******************************************************************

SolverFactory("glpk").solve(Model)
sol =sum( Model.setDias[i].value for i in setOpciones)
Model.display()
print(f"Solución tipo real: {sol}")