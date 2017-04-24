# MySQL_Octo

```julia
julia> Pkg.clone("https://github.com/wookay/Octo.jl.git")

julia> Pkg.clone("https://github.com/wookay/MySQL_Octo.jl.git")
```


```julia
julia> using MySQL_Octo

julia> adapter = SQL.connect(host="127.0.0.1", user="test", pass="test", db="mysqltest", reconnect=true)
MySQL_Octo.SQL.MySQLAdapter(MySQL Handle
------------
Host: 127.0.0.1
User: test
DB:   mysqltest
)

julia> u = table_from(adapter, "users")
FROM users

julia> u[*]
SELECT * FROM users
(1, Nullable{String}("John"))

julia> u[u.name]
SELECT name FROM users
(Nullable{String}("John"),)

julia> u[u.name](:where => u.id == 1)
SELECT name FROM users WHERE id = 1
(Nullable{String}("John"),)

julia> u[u.name](:where => u.id == 1, :limit => 3)
SELECT name FROM users WHERE id = 1 LIMIT 3
(Nullable{String}("John"),)

julia> # custom arrangement
       function SQL.arrange(io::IO, query::Queryable)
           write(io, QueryBuilders.colored_repr(query), "\n")
           for row in SQL.iterate(query)
               write(io, string(map(x -> isa(x, Nullable) ? x.value : x, row)))
           end
       end

julia> u[u.name](:where => u.id == 1, :limit => 3)
SELECT name FROM users WHERE id = 1 LIMIT 3
("John",)
```
