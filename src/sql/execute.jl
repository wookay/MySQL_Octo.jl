# module MySQL_Octo.SQL

function execute(adapter::QueryBuilders.AbstractAdapter, commands::String)
    print_with_color(:bold, commands, "\n")
    res = mysql_execute(adapter.handle, commands; opformat=MYSQL_TUPLES)
    print_with_color(:normal, join(res, ' '), "\n")
end
