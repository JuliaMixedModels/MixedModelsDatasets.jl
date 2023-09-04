using Documenter
using DocStringExtensions
using MixedModelsDatasets

makedocs(; root=joinpath(dirname(pathof(MixedModelsDatasets)), "..", "docs"),
         sitename="BoxCox",
         doctest=true,
         strict=true,
         pages=["index.md"])

deploydocs(; repo="github.com/JuliaMixedModels/MixedModelsDatasets.jl", push_preview=true,
           devbranch="main")
