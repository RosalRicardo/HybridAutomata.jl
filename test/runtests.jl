using HybridAutomata
using Test

estados = Dict("primeira marcha"=>1,
"segunda marcha"=>2,
"terceira marcha"=>3)

motor = HybridAutomata.Automata(discrete_states=estados)

HybridAutomata.make_edges(motor)

@testset "HybridAutomata.jl" begin
    # Write your tests here.
 
end
