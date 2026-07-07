module MixedModelsDatasets

using Arrow
using DelimitedFiles
using Downloads
using ProgressMeter
using Scratch 
using SHA

export dataset, datasets

const CACHE = Ref("")
const CACHED_DATASETS = Dict{String,String}()
const DATASETS = Dict{String,NamedTuple}() 

"""
    __init__()

Initialize the package scratchspace and populate the internal registry of
available datasets by parsing `datasets.csv`.
"""
function __init__()
    CACHE[] = @get_scratch!("data")

    csv = joinpath(@__DIR__, "datasets.csv")
    data, headers = readdlm(csv, ',', String; 
                            header=true, skipblanks=true, comments=true)
    names = Symbol.(Tuple(headers))
    rows = NamedTuple{names}.(eachrow(data))
    for row in rows 
        DATASETS[row.dsname] = row
    end

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
    path = _download(nm)
    return Arrow.Table(path)
end
dataset(nm::Symbol) = dataset(string(nm))

"""
    datasets()

Return a vector of names of the available test data sets
"""
function datasets(; downloaded=false)
    ds = collect(keys(DATASETS))
    if downloaded
        intersect!(ds, keys(CACHED_DATASETS))
    end
    return sort!(ds)
end

"""
    _download(nm::AbstractString; info=true)

Return the local cache path for dataset `nm`, downloading it (and verifying
its SHA-256 checksum) if it is not already cached or the cached file's
checksum no longer matches. Set `info=false` to suppress the `@info` log
messages.
"""
function _download(nm::AbstractString; info=true)
    return get!(CACHED_DATASETS, nm) do
        nm in keys(DATASETS) ||
            throw(ArgumentError("Dataset \"$nm\" is not available.\nUse MixedModels.datasets() for available names."))
        
        path = joinpath(CACHE[], lowercase(nm) * ".arrow")
        ds = DATASETS[nm]
        if !isfile(path) || ds.sha2 != bytes2hex(open(sha2_256, path))
            info && @info "Downloading dataset..."
            url = string("https://osf.io/", ds.filename, "/download?version=", ds.version)
            Downloads.download(url, path)
            ds.sha2 == bytes2hex(open(sha2_256, path)) ||
                error("Downloaded file failed checksum verification.")
            info && @info "done"
        end

        return path
    end
end

"""
    download_all()

Download every available dataset into the local cache, displaying a progress
bar as they are fetched.
"""
function download_all()
    @showprogress asyncmap(x -> _download(x; info=false), collect(keys(DATASETS)))
    return nothing
end

# function hex(row)
#        Downloads.download(
#                           string("https://osf.io/", row.filename, "/download?version=", row.version),
#                            joinpath(CACHE[], lowercase(row.dsname) * ".arrow"))
#        bytes2hex(open(sha2_256,joinpath(CACHE[], lowercase(row.dsname) * ".arrow")))
# end

end # module MixedModelsDatasets
