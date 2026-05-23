using Documenter
using MixedModelsDatasets

makedocs(;
        #  format=Documenter.HTML(; size_threshold=500_000, size_threshold_warn=250_000),
        sitename="MixedModelsDatasets.jl",
         doctest=true,
         # pagesonly=true,
         # warnonly=true,
         # warnonly=[:cross_references],
         pages=["index.md", 
                "datasets.md"])

deploydocs(; repo="github.com/JuliaMixedModels/MixedModelsDatasets.jl", push_preview=true,
           devbranch="main")
