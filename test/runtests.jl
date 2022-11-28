using HybridAutomata
using Test

modos = Dict(1=>"cooling",
            2=>"satisfied",
            3=>"heating")

estados = Dict(1=>"temperature")

termostato = HybridAutomata.Automata(discrete_states=modos,continuos_states=estados)
edges = HybridAutomata.make_edges(termostato)
termostato.flow_map

HybridAutomata.add_guard(termostato,2=>1,(z,Csp) -> z >= Csp ? true : false)
HybridAutomata.add_guard(termostato,1=>2,(z,Csp,Hsp) -> (z <= Csp) && (z >= Hsp) ? true : false)
HybridAutomata.add_guard(termostato,3=>2,(z,Csp,Hsp) -> (z <= Csp) && (z >= Hsp) ? true : false)
HybridAutomata.add_guard(termostato,2=>3,(z,Hsp) -> (z <= Hsp) ? true : false)

termostato.guard_map

HybridAutomata.add_flow(termostato,1,z->0.95z)
HybridAutomata.add_flow(termostato,2,z->1.10z)
HybridAutomata.add_flow(termostato,3,z->1.50z)


@testset "HybridAutomata.jl" begin
    # Write your tests here.
 
end
