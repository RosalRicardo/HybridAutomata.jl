module HybridAutomata

# Write your package code here.
    Base.@kwdef mutable struct Automata
        discrete_states::Dict{Any,Any} = Dict()
        continuos_states::Dict{Any,Any} = Dict()
        guard_map::Vector{Function} = []
        reset_map::Vector{Function} = []
    end

    function make_edges(automata::Automata)
        edges = []
        estados_discretos = keys(automata.discrete_states)
        for i ∈ estados_discretos
            for j ∈ estados_discretos
                push!(edges,i => j)
            end
        end
        return edges
    end

    export make_edges
end

