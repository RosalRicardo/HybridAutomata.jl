module HybridAutomata

# Write your package code here.
    Base.@kwdef mutable struct Automata
        discrete_states::Dict{Any,Any} = Dict()
        continuos_states::Dict{Any,Any} = Dict()
        edges::Vector{Pair} = []
        guard_map::Matrix{Any} = Array{Any}(undef, 0, 0)
        flow_map::Matrix{Any} = Array{Any}(undef, 0, 0)
        reset_map::Matrix{Any} = Array{Any}(undef, 0, 0)
    end

    function Automata(discrete_states::Dict{Any,Any},continuos_states::Dict{Any,Any})
        println(discrete_states)
        println(continuos_states)
        edges = []
        estados_discretos = keys(discrete_states)
        for i ∈ estados_discretos
            for j ∈ estados_discretos
                push!(edges,i => j)
            end
        end
        guard_map = zeros(size(discrete_states)[1]^2,size(discrete_states)[1]^2)
        new(discrete_states,continuos_states,edges,guard_map)
    end

    function make_edges(automata::Automata)
        edges = []
        estados_discretos = collect(keys(automata.discrete_states))
        for i ∈ estados_discretos
            for j ∈ estados_discretos
                push!(edges,i => j)
            end
        end
        zero_reset_guard = zeros(size(edges)[1])
        automata.edges = edges
        automata.guard_map = hcat(edges,zero_reset_guard)
        automata.flow_map = hcat(estados_discretos,zeros(size(estados_discretos)[1]))
        automata.reset_map = hcat(edges,zero_reset_guard)
        return edges
    end

    function add_guard(automato::Automata,edge::Pair,guard::Function)
        idx = findfirst(==(edge),automato.guard_map[:,1])
        automato.guard_map[idx,2] = guard
    end

    function add_flow(automato::Automata,mode::Int,flow::Vector{Function})
        idx = findfirst(==(mode),automato.flow_map[:,1])
        automato.flow_map[idx,2] = flow
    end

    function add_reset(automato::Automata,edge::Pair,reset::Vector{Function})
        idx = findfirst(==(edge),automato.guard_map[:,1])
        automato.reset_map[idx,2] = reset
    end

    function solve(automato::Automata,initial_condition::Float64,initial_state::Int,interval::StepRange,parameters::Vector)
        z = [initial_condition]
        q = initial_state
        for i ∈ interval
            idx = findfirst(==(q),automato.flow_map[:,1])
            new_z = automato.flow_map[idx,2](z[end])
            push!(z,new_z)
            for edge ∈ automato.guard_map[:,1]
                q_idx = findfirst(==(edge),automato.guard_map[:,1])
                if first(edge) == q && automato.guard_map[q_idx,2] != 0
                    automato.guard_map[q_idx,2](z[end],parameters) ? q = edge.second : q = edge.first
                end
            end
        end
        return z
    end

    export make_edges
    export add_guard
    export add_flow
end