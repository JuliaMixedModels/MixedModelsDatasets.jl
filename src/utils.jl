"""
    _download(nm::AbstractString; info=true)

Return the local cache path for dataset `nm`, downloading it (and verifying
its SHA-256 checksum) if it is not already cached or the cached file's
checksum no longer matches. Set `info=false` to suppress the `@info` log
messages.
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
            Downloads.download(url, path)
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
    flush! = function ()
        if !isempty(name)
            while !isempty(lines) &&
                (isempty(strip(last(lines))) || strip(last(lines)) == "---")
                pop!(lines)
            end
            dict[name] = join(lines, '\n')
        end
        return nothing
    end
    for line in eachline(path)
        m = match(r"^##[ \t]+(\S.*?)[ \t]*$", line)
        if m !== nothing
            flush!()
            name = lowercase(m.captures[1])
            lines = String[line]
        elseif !isempty(name)
            push!(lines, line)
        end
    end
    flush!()
    return dict
end

# function hex(row)
#        Downloads.download(
#                           string("https://osf.io/", row.filename, "/download?version=", row.version),
#                            joinpath(CACHE[], lowercase(row.dsname) * ".arrow"))
#        bytes2hex(open(sha2_256,joinpath(CACHE[], lowercase(row.dsname) * ".arrow")))
# end
