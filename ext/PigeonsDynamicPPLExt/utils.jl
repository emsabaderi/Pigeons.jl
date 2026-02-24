function get_dimension(model::DynamicPPL.Model) 
    vi = DynamicPPL.VarInfo(SplittableRandom(1), model)
    get_dimension(DynamicPPL.link(vi, model))
    # get_dimension(DynamicPPL.link!!(DynamicPPL.DynamicTransformation(), vi, model))
end

# get_dimension(vi::DynamicPPL.VarInfo) = sum(meta -> sum(length, meta.ranges), vi.metadata)
get_dimension(vi::DynamicPPL.VarInfo) = length(DynamicPPL.getindex_internal(vi, :))

# function flatten!(vi::DynamicPPL.VarInfo, dest::Array)
#     i = firstindex(dest)
#     for meta in vi.metadata
#         vals = meta.vals
#         for r in meta.ranges
#             N = length(r)
#             copyto!(dest, i, vals, first(r), N)
#             i += N
#         end
#     end
#     return dest
# end

function flatten!(vi::DynamicPPL.VarInfo, dest::Array)
    vals = DynamicPPL.getindex_internal(vi, :)
    copyto!(dest, firstindex(dest), vals, first(vals), length(vals))
    return dest
end
