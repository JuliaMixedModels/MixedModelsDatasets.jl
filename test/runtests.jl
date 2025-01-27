using Arrow
using Aqua
using MixedModelsDatasets
using Test

@testset "Aqua" begin
    Aqua.test_all(MixedModelsDatasets)
end

@testset "datasets" begin
    @test length(datasets()) == 17

    @testset "$(ds) loadable" for ds in datasets()
        @test dataset(ds) isa Arrow.Table
        @test dataset(titlecase(ds)) isa Arrow.Table
    end
end
