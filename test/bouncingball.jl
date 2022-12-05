using HybridAutomata
using Test
using Plots

modos = Dict(1=>"impact",2=>"bouncing")

estados = Dict("velocity"=>[-9.81],"position"=>[10.0])

ball = HybridAutomata.Automata(discrete_states=modos,continuos_states=estados)

ball.continuos_states["velocity"]

function velocity(ball)
    gravity = -9.81
    return gravity
end

function position(ball)
    ball.continuos_states["position"][end]
end

edges = HybridAutomata.make_edges(ball)

ball.guard_map

parameters = [-0.9,10]

HybridAutomata.add_flow(ball,2,[velocity,position])
HybridAutomata.add_flow(ball,1,[velocity,position])

HybridAutomata.add_guard(ball,2=>1,(ball,parameters)->ball.continuos_states["position"][end]<0 ? true : false)
HybridAutomata.add_guard(ball,1=>2,(ball,parameters)->ball.continuos_states["position"][end]>=0 ? true : false)

function reset_q1(ball,parameters)
    velocity = -0.9*ball.continuos_states["velocity"][end]
    position = 0
    return [velocity,position]
end

function reset_q2(ball,parameters)
    velocity = ball.continuos_states["velocity"][end]
    position = ball.continuos_states["position"][end]
    return [velocity,position]
end

HybridAutomata.add_reset(ball,2=>1,reset_q1)
HybridAutomata.add_reset(ball,1=>2,reset_q2)

ball.flow_map
ball.flow_map[1,2]
ball.flow_map[1,2][2]

keys(ball.continuos_states)

collect(keys(ball.continuos_states))

state = HybridAutomata.solve(ball,32.0,2,0:1:100,parameters)

ball.continuos_states

tam = size(collect(keys(ball.continuos_states)))

for i in 1:tam[1]
    println(i)
end

ball.flow_map[1,2][2](ball)

plot(ball.continuos_states["position"])