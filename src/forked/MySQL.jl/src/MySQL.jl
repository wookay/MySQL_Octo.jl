__precompile__()

module MySQL
    using Compat
    using Compat.String

    include("config.jl")
    include("consts.jl")
    include("types.jl")
    include("datetime.jl")
    include("api.jl")
    include("results.jl")
    include("iterators.jl")
    include("handy.jl")
end
