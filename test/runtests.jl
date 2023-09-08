using Arrow
using Aqua
using MixedModelsDatasets
using Test

@testset "Aqua" begin
    @static if VERSION >= v"1.9"
        Aqua.test_all(MixedModelsDatasets; ambiguities=false, piracy=true)
    end
end

@testset "datasets" begin
    @test length(datasets()) == 17

    @testset "$(ds) loadable" for ds in datasets()
        @test dataset(ds) isa Arrow.Table
    end
end
