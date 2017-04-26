module SQL

using Compat

import ..MySQL: MySQLHandle, MySQLInternalError, MySQLRowIterator, MYSQL_TUPLES, MYSQL_OPT_RECONNECT
import ..MySQL: mysql_connect, mysql_disconnect, mysql_stmt_prepare, mysql_metadata, mysql_execute

import Octo
import .Octo: QueryBuilders
import .QueryBuilders: DefaultArrangement, arrange

include("sql/adapter.jl")
include("sql/connect.jl")
include("sql/prepare.jl")
include("sql/iterate.jl")
include("sql/execute.jl")
include("sql/arrange.jl")
include("sql/table_from.jl")

end
