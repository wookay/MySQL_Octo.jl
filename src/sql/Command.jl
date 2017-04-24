# module MySQL_Octo.SQL

type Command <: QueryBuilders.Queryable
    query::String
end

Base.repr(cmd::Command) = cmd.query
