using HybridAutomata
using Test
using Plots

modos = Dict(1=>"impact",2=>"bouncing")

estados = Dict("velocity"=>[0],"position"=>[0])

ball = HybridAutomata.Automata(discrete_states=modos,continuos_states=estados)

ball.continuos_states["velocity"]

function velocity(ball)
    return -9.81
end

function positions(ball)
    ball.continuos_states["velocity"][end]
end

edges = HybridAutomata.make_edges(ball)

ball.guard_map

HybridAutomata.add_flow(ball,2,[velocity,position])
HybridAutomata.add_flow(ball,1,[velocity,position])

HybridAutomata.add_guard(ball,2=>1,(ball,parameters)->ball.continuos_states["position"][end]==0 ? true : false)
HybridAutomata.add_guard(ball,1=>2,(ball,parameters)->ball.continuos_states["position"][end]!=0 ? true : false)

function reset_velocity(ball,parameters)
    return -0.3*ball.continuos_states["velocity"][end]
end

function reset_position(ball,parameters)
    return 0
end

function reset_velocity_1(ball,parameters)
    return ball.continuos_states["velocity"][end] 
end

function reset_position_1(ball,parameters)
    return ball.continuos_states["position"][end] 
end

HybridAutomata.add_reset(ball,2=>1,[reset_velocity,reset_position])
HybridAutomata.add_reset(ball,1=>2,[reset_velocity_1,reset_position_1])

state = HybridAutomata.solve(ball,)