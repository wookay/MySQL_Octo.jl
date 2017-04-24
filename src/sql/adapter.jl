# module MySQL_Octo.SQL

type MySQLAdapter <: QueryBuilders.AbstractAdapter
    handle::Union{Void, MySQLHandle}
end
