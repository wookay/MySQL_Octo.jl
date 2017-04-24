using MySQL_Octo
using Base.Test

adapter = SQL.connect(host="127.0.0.1", user="test", pass="test", db="mysqltest", reconnect=true)
@test !isa(adapter.handle, Void)
u = table_from(adapter, "users")
@test repr(u) == "FROM users"
@test repr(u[*]) == "SELECT * FROM users"
@test repr(u[u.id]) == "SELECT id FROM users"

SQL.arrange(DefaultArrangement, STDOUT, u[*](:where => and(u.id == 1, u.name == "John")))

# custom arrangement
function SQL.arrange(io::IO, query::Queryable)
    write(io, QueryBuilders.colored_repr(query), "\n")
    for row in SQL.iterate(query)
        write(io, string(map(x -> isa(x, Nullable) ? x.value : x, row)))
    end
end

Octo.Text.colors[:keyword] = :bold

SQL.arrange(STDOUT, u[*](:where => and(u.id == 1, u.name == "John")))

Octo.Text.colors[:keyword] = :normal

SQL.arrange(STDOUT, u[u.name](:where => and(u.id == 1, u.name == "John")))

SQL.arrange(STDOUT, u[u.name, u.id](:where => and(u.id == 1, u.name == "John"), :limit => 2))
