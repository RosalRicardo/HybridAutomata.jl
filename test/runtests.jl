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

parameters = [35,18]

HybridAutomata.add_guard(termostato,2=>1,(z,parameters) -> z >= parameters[1] ? true : false)
HybridAutomata.add_guard(termostato,1=>2,(z,parameters) -> (z <= parameters[1]) && (z >= parameters[2]) ? true : false)
HybridAutomata.add_guard(termostato,3=>2,(z,parameters) -> (z <= parameters[1]) && (z >= parameters[2]) ? true : false)
HybridAutomata.add_guard(termostato,2=>3,(z,parameters) -> (z <= parameters[2]) ? true : false)

termostato.guard_map

HybridAutomata.add_flow(termostato,1,z->0.65z)
HybridAutomata.add_flow(termostato,2,z->1.10z)
HybridAutomata.add_flow(termostato,3,z->1.50z)

termostato.flow_map

state = HybridAutomata.solve(termostato,32.0,2,0:1:100,parameters)

plot(state)

@testset "HybridAutomata.jl" begin
    # Write your tests here.
 
end
