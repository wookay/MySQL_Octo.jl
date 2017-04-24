module SQL

using Compat

import ..MySQL: MySQLHandle, MySQLInternalError, MySQLRowIterator, MYSQL_OPT_RECONNECT
import ..MySQL: mysql_connect, mysql_stmt_prepare, mysql_metadata

import Octo
import .Octo: QueryBuilders
import .QueryBuilders: DefaultArrangement, arrange

include("sql/Command.jl")
include("sql/adapter.jl")
include("sql/connect.jl")
include("sql/iterate.jl")
include("sql/arrange.jl")
include("sql/table_from.jl")
include("sql/prepare.jl")

end
