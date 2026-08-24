"""
    _RETRY_DELAY_SECONDS

Retry intervals for a failed download.
"""
const _RETRY_DELAY_SECONDS = Float64[1, 2, 5, 10]

function _retry_check(state, e)
    retry = e isa Downloads.RequestError
    retry &&
        @warn "Dataset download failed; retrying in $(_RETRY_DELAY_SECONDS[state - 1]) seconds" exception = e
    return (state, retry)
end

const _download_with_retry = Base.retry(Downloads.download; delays=_RETRY_DELAY_SECONDS,
                                        check=_retry_check)

"""
    _download(nm::AbstractString; info=true)

Return the local cache path for dataset `nm`, downloading it (and verifying
its SHA-256 checksum) if it is not already cached or the cached file's
checksum no longer matches. A download that fails with a network error is
retried once. Set `info=false` to suppress the `@info` log messages.
"""
function _download(nm::AbstractString; info=true)
    nm = lowercase(nm)
    return get!(CACHED_DATASETS, nm) do
        nm in keys(DATASETS) ||
            throw(ArgumentError("Dataset \"$nm\" is not available.\nUse MixedModels.datasets() for available names."))
        path = joinpath(CACHE[], nm * ".arrow")
        ds = DATASETS[nm]
        if !isfile(path) || ds.sha2 != bytes2hex(open(sha2_256, path))
            info && @info "Downloading dataset..."
            url = string("https://osf.io/", ds.filename, "/download?version=", ds.version)
            _download_with_retry(url, path)
            ds.sha2 == bytes2hex(open(sha2_256, path)) ||
                error("Downloaded file failed checksum verification.")
            info && @info "done"
        end

        return path
    end
end

function _parse_datasets!(dict, path)
    isfile(path) || return dict
    data, headers = readdlm(path, ',', String;
                            header=true, skipblanks=true, comments=true)
    names = Symbol.(Tuple(headers))
    rows = NamedTuple{names}.(eachrow(data))
    for row in rows
        dict[row.dsname] = row
    end

    return dict
end

"""
    _parse_descriptions!(dict, path)

Populate `dict` with the per-dataset sections of the Markdown documentation
file at `path`, keyed by (lowercased) dataset name. Each `## name` heading
begins a new section, which runs until the next heading or end of file, with
the trailing horizontal-rule separator (`---`) removed.
"""
function _parse_descriptions!(dict, path)
    isfile(path) || return dict
    name = ""
    lines = String[]
    for line in eachline(path)
        m = match(r"^##[ \t]+(\S.*?)[ \t]*$", line)
        if m !== nothing
            _flush!(lines, dict, name)
            # headings escape special markdown characters (e.g. `elp\_ldt\_item`);
            # strip the backslashes to recover the actual dataset name
            name = lowercase(replace(m.captures[1], r"\\(.)" => s"\1"))
            lines = String[line]
        elseif !isempty(name)
            push!(lines, line)
        end
    end
    _flush!(lines, dict, name)
    return dict
end

"""
    _flush!(lines, dict, name)

Store the accumulated section `lines` in `dict` under `name`, joined into a
single string. Trailing blank lines and horizontal-rule separators (`---`) are
dropped first. A no-op when `name` is empty (i.e. before the first section
heading has been seen).
"""
function _flush!(lines::Vector{String}, dict::Dict{String,String}, name::String)
    if !isempty(name)
        while !isempty(lines) &&
              (isempty(strip(last(lines))) || strip(last(lines)) == "---")
            pop!(lines)
        end
        dict[name] = join(lines, '\n')
    end
    return nothing
end

# function hex(row)
#        Downloads.download(
#                           string("https://osf.io/", row.filename, "/download?version=", row.version),
#                            joinpath(CACHE[], lowercase(row.dsname) * ".arrow"))
#        bytes2hex(open(sha2_256,joinpath(CACHE[], lowercase(row.dsname) * ".arrow")))
# end
