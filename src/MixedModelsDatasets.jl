module MixedModelsDatasets

using Arrow
using DelimitedFiles
using Downloads
using Markdown
using ProgressMeter
using Scratch
using SHA

export dataset, datasets, description

# Paths
const CACHE = Ref("")
const DATASET_CSV = Ref("")

# In-memory structures
const CACHED_DATASETS = Dict{String,String}()
const DATASETS = Dict{String,NamedTuple}()
const DESCRIPTIONS = Dict{String,String}()

include("utils.jl")

"""
    __init__()

Initialize the package scratchspace and populate the internal registry of
available datasets by parsing `datasets.csv`.
"""
function __init__()
    CACHE[] = @get_scratch!("data")
    DATASET_CSV[] = joinpath(@__DIR__, "datasets.csv")
    return nothing
end

"""
    clear_scratchspaces!()

Remove all cached datasets by clearing the package's scratchspace, forcing
subsequent downloads to be fetched anew.
"""
clear_scratchspaces!() = Scratch.clear_scratchspaces!(@__MODULE__)

"""
    dataset(nm)

Return, as an `Arrow.Table`, the test data set named `nm`, which can be a `String` or `Symbol`

!!! note "Case insensitive"
    Dataset names are case insensitive: internally all names are normalized to lowercase.
"""
function dataset(nm::AbstractString)
    isempty(DATASETS) && _parse_datasets!(DATASETS, DATASET_CSV[])
    path = _download(nm)
    return Arrow.Table(path)
end
dataset(nm::Symbol) = dataset(string(nm))

"""
    datasets()

Return a vector of names of the available test data sets
"""
function datasets(; downloaded=false)
    isempty(DATASETS) && _parse_datasets!(DATASETS, DATASET_CSV[])
    ds = collect(keys(DATASETS))
    if downloaded
        intersect!(ds, keys(CACHED_DATASETS))
    end
    return sort!(ds)
end

"""
    description(nm)

Return the documentation entry for the dataset named `nm` (a `String` or
`Symbol`) as a `Markdown.MD` object, which renders nicely in the REPL. The
entry — full name, description, column table, example models, and citation —
is parsed from the package's `datasets.md` documentation.

!!! note "Case insensitive"
    Dataset names are case insensitive: internally all names are normalized to lowercase.
"""
function description(nm::AbstractString)
    # load the descriptions on first use
    isempty(DESCRIPTIONS) &&
        _parse_descriptions!(DESCRIPTIONS,
                             joinpath(dirname(@__DIR__), "docs", "src", "datasets.md"))

    key = lowercase(nm)
    haskey(DESCRIPTIONS, key) ||
        throw(ArgumentError("No description available for dataset \"$nm\".\nUse MixedModelsDatasets.datasets() for available names."))
    return Markdown.parse(DESCRIPTIONS[key])
end
description(nm::Symbol) = description(string(nm))

"""
    download_all()

Download every available dataset into the local cache, displaying a progress
bar as they are fetched.
"""
function download_all()
    @showprogress asyncmap(x -> _download(x; info=false), collect(keys(DATASETS)))
    return nothing
end

end # module MixedModelsDatasets
