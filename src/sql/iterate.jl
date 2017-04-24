# module MySQL_Octo.SQL

function iterate(query::QueryBuilders.Queryable)
    MySQLRowIterator(query.adapter.handle, repr(query))
end
