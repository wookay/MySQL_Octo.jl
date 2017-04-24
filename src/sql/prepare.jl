# module MySQL_Octo.SQL

function prepare(adapter::QueryBuilders.AbstractAdapter, from::QueryBuilders.FromClause)
    tablename = from.tablename
    mysql_stmt_prepare(adapter.handle, "SELECT * FROM $tablename LIMIT 0")
    mysql_metadata(adapter.handle)
end
