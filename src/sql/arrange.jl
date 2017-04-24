# module MySQL_Octo.SQL

function arrange(::Type{DefaultArrangement}, io::IO, query::QueryBuilders.Queryable)
    write(io, QueryBuilders.colored_repr(query), "\n")
    for row in SQL.iterate(query)
        write(io, string(row))
    end
end
