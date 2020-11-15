# -*- coding: utf-8 -*-
"""
Created on Sat Nov 14 19:55:29 2020

@author: Juan Antonio Restrepo & David Martinez G
"""

from __future__ import division
from pyomo.environ import *

from pyomo.opt import SolverFactory

m = ConcreteModel()
# SETS & PARAMETERS********************************************************************

arcos= {(1,1):999, (1,2):5,(1,3):999,(1,4):5, (1,5):999,(1,6):999,\
      (2,1):999,(2,2):999, (2,3):3,(2,4):7,(2,5):999,(2,6):999,\
      (3,1):999,(3,2):3, (3,3):999,(3,4):999,(3,5):7,(3,6):5,\
      (4,1):5,(4,2):7,(4,3):999,(4,4):999,(4,5):3,(4,6):999,\
      (5,1):999,(5,2):999,(5,3):7,(5,4):999,(5,5):999,(5,6):5,\
      (6,1):999,(6,2):999,(6,3):5,(6,4):999,(6,5):5,(6,6):999}
    
# VARIABLES****************************************************************************
    
N=RangeSet(1,6)

m.x = Var(N,N,domain=Binary)

# OBJECTIVE FUNCTION*******************************************************************

m.obj=Objective(expr=sum(m.x[i, j] * arcos[i, j] for i in N for j in N) )

# CONSTRAINTS**************************************************************************
def source_rule(m, i):
    if i == 1 or i == 4:
        return sum(m.x[i, j] for j in N) - sum(m.x[j, i] for j in N) == 1
    else:
        return Constraint.Skip
    
m.source=Constraint(N, rule=source_rule)

def not_source_rule(m, i):
    if i != 1 and i != 4:
        return sum(m.x[j, i] for j in N) == 1
    else:
        return Constraint.Skip

m.notSource = Constraint(N,rule=not_source_rule)
def intermediate_rule(m,i):
    if i != 1 and i != 4:
        return sum(m.x[j, i] for j in N) <= 1
    else:
        return Constraint.Skip
        
m.intermediate=Constraint(N, rule=intermediate_rule)

def not_repeated(m, i, j):
    return m.x[i, j] + m.x[j, i] <= 1

m.notRepeated=Constraint(N,N,rule=not_repeated)

# APPLYING THE SOLVER******************************************************************
SolverFactory('glpk').solve(m)

m.display()


