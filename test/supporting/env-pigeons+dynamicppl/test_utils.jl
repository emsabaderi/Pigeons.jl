using Test
using Pigeons
using DynamicPPL
using Distributions
using Random
using SplittableRandoms
include("../../../ext/PigeonsDynamicPPLExt/state.jl")
include("../../../ext/PigeonsDynamicPPLExt/utils.jl")


@model function test_model()
    α ~ Beta(1, 2)
    β ~ Beta(2, 3)
    y ~ Binomial(10, α * β)
    return nothing
end

rng = MersenneTwister(2026)
model = test_model()
vi = DynamicPPL.VarInfo(model)

@testset "get_dimemsion" begin
    @test get_dimension(model) == 3
    @test get_dimension(vi) == 3
end


@testset "flatten!" begin
    vals = DynamicPPL.getindex_internal(vi, :)
    println("values = ", vals)
    dest = Vector{Float64}(undef, length(vals))
    result = flatten!(vi, dest)
    @test result == dest
    @test result == vals  
end