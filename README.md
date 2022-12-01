# HybridAutomata

[![Build Status](https://github.com/RosalRicardo/HybridAutomata.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/RosalRicardo/HybridAutomata.jl/actions/workflows/CI.yml?query=branch%3Amain)

ir order to define an automata its is needed to import the library `HybridAutomata.jl`, create two dictionaries, one with the discrete states and other with the continuos states.



## Discrete States

First, a set of finite states is needed, which from now on we will call the $Q$ set, these states are interpreted as the discrete states of the system, where the transition occurs by jumps triggered by discrete events defined later and are represented as follows.

$$
    Q = \{q_1,q_2,...,q_{max}\}
$$

## Continuos States



## Example

```
using HybridAutomata
using Test
using Plots

modos = Dict(1=>"cooling",
            2=>"satisfied",
            3=>"heating")

estados = Dict(1=>"temperature")

termostato = HybridAutomata.Automata(discrete_states=modos,continuos_states=estados)
edges = HybridAutomata.make_edges(termostato)
termostato.flow_map

HybridAutomata.add_guard(termostato,2=>1,(z,Csp,Hsp) -> z >= Csp ? true : false)
HybridAutomata.add_guard(termostato,1=>2,(z,Csp,Hsp) -> (z <= Csp) && (z >= Hsp) ? true : false)
HybridAutomata.add_guard(termostato,3=>2,(z,Csp,Hsp) -> (z <= Csp) && (z >= Hsp) ? true : false)
HybridAutomata.add_guard(termostato,2=>3,(z,Csp,Hsp) -> (z <= Hsp) ? true : false)

termostato.guard_map

HybridAutomata.add_flow(termostato,1,z->0.95z)
HybridAutomata.add_flow(termostato,2,z->1.10z)
HybridAutomata.add_flow(termostato,3,z->1.50z)

termostato.flow_map

state = HybridAutomata.solve(termostato,32.0,2,0:1:100)

plot(state)
```