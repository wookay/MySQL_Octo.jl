# module MySQL_Octo.SQL

function connect(; kw...)::MySQLAdapter # throws(MySQLInternalError)
    adapter = MySQLAdapter(nothing)
    options = Dict(kw)
    opts = Dict(MYSQL_OPT_RECONNECT => Int(get(options, :reconnect, true)))
    adapter.handle = mysql_connect(options[:host], options[:user], options[:pass], options[:db], opts=opts)
    adapter
end
