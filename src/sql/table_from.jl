# module MySQL_Octo.SQL

function table_from(adapter::QueryBuilders.AbstractAdapter, tablename::String)
    meta = SQL.prepare(adapter, QueryBuilders.FromClause(tablename))
    fields = tuple(map(Symbol, meta.names)...)
    Octo.Adapters.Base.build_table(adapter, tablename, nothing, fields)
end
