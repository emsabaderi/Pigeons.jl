function get_dimension(model::DynamicPPL.Model)
    vi = DynamicPPL.VarInfo(SplittableRandom(1), model)
    get_dimension(DynamicPPL.link(vi, model))
end

get_dimension(vi::DynamicPPL.VarInfo) = length(DynamicPPL.getindex_internal(vi, :))


function flatten!(vi::DynamicPPL.VarInfo, dest::Array)
    vals = DynamicPPL.getindex_internal(vi, :)
    copyto!(dest, firstindex(dest), vals, firstindex(vals), length(vals))
    return dest
end
