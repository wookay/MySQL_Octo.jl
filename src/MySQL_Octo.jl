__precompile__()

module MySQL_Octo

import Octo

export        QueryBuilders
import .Octo: QueryBuilders

export                 @functions, and, or, not, like, between, asc, desc
import .QueryBuilders: @functions, and, or, not, like, between, asc, desc

export                 Select, Insert, Update, Delete, Join, Over
import .QueryBuilders: Select, Insert, Update, Delete, Join, Over

export                 Create, Alter, Drop, Database, Table, Column, Index, ForeignKey
import .QueryBuilders: Create, Alter, Drop, Database, Table, Column, Index, ForeignKey

export                 Queryable, arrange
import .QueryBuilders: Queryable, arrange

import MySQL
# temporary forked for Julia 0.6
# include("forked/MySQL.jl/src/MySQL.jl")

include("sql.jl")

export  SQL, table_from, DefaultArrangement
import .SQL: table_from, DefaultArrangement

end # module
