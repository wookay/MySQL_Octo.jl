# module MySQL_Octo.SQL

function connect(; kw...)::MySQLAdapter # throws(MySQLInternalError)
    adapter = MySQLAdapter(nothing)
    options = Dict(kw)
    opts = Dict(MYSQL_OPT_RECONNECT => Int(get(options, :reconnect, true)))
    args = Vector()
    for key in (:host, :user, :pass, :db)
        haskey(options, key) && push!(args, options[key])
    end
    adapter.handle = mysql_connect(args..., opts=opts)
    adapter
end

function disconnect(adapter::QueryBuilders.AbstractAdapter)
    mysql_disconnect(adapter.handle)
end
