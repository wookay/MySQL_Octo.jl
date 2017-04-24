"""
Initializes the MYSQL object. Must be called before mysql_real_connect.
Memory allocated by mysql_init can be freed with mysql_close.
"""
function mysql_init(mysqlptr::Ptr{Void})
    return ccall((:mysql_init, mysql_lib),
                 Ptr{Void},
                 (Ptr{Cuchar}, ),
                 mysqlptr)
end

"""
Used to connect to database server. Returns a MYSQL handle on success and
C_NULL on failure.
"""
function mysql_real_connect(mysqlptr::Ptr{Void},
                              host::String,
                              user::String,
                              passwd::String,
                              db::String,
                              port::Cuint,
                              unix_socket::String,
                              @compat client_flag::UInt32)

    return ccall((:mysql_real_connect, mysql_lib),
                 Ptr{Void},
                 (Ptr{Void},
                  Ptr{Cuchar},
                  Ptr{Cuchar},
                  Ptr{Cuchar},
                  Ptr{Cuchar},
                  Cuint,
                  Ptr{Cuchar},
                  Culong),
                 mysqlptr,
                 host,
                 user,
                 passwd,
                 db,
                 port,
                 unix_socket,
                 client_flag)
end

function mysql_options(mysqlptr::Ptr{Void},
                        option_type::Cuint,
                        option::Ptr{Void})
    return ccall((:mysql_options, mysql_lib),
                 Cint,
                 (Ptr{Cuchar},
                  Cint,
                  Ptr{Cuchar}),
                 mysqlptr,
                 option_type,
                 option)
end

mysql_options(mysqlptr, option_type, option::String) =
    mysql_options(mysqlptr, option_type, convert(Ptr{Void}, pointer(option)))

function mysql_options(mysqlptr, option_type, option)
    v = [option]
    return mysql_options(mysqlptr, option_type, convert(Ptr{Void}, pointer(v)))
end

"""
Close an opened MySQL connection.
"""
function mysql_close(mysqlptr::Ptr{Void})
    return ccall((:mysql_close, mysql_lib),
                 Void,
                 (Ptr{Cuchar}, ),
                 mysqlptr)
end

"""
Returns the error number of the last API call.
"""
function mysql_errno(mysqlptr::Ptr{Void})
    return ccall((:mysql_errno, mysql_lib),
                 Cuint,
                 (Ptr{Cuchar}, ),
                 mysqlptr)
end

"""
Returns a string of the last error message of the most recent function call.
If no error occured and empty string is returned.
"""
function mysql_error(mysqlptr::Ptr{Void})
    return ccall((:mysql_error, mysql_lib),
                 Ptr{Cuchar},
                 (Ptr{Cuchar}, ),
                 mysqlptr)
end

"""
Executes the prepared query associated with the statement handle.
"""
function mysql_stmt_execute(stmtptr::Ptr{MYSQL_STMT})
    return ccall((:mysql_stmt_execute, mysql_lib),
                 Cint,
                 (Ptr{Cuchar}, ),
                 stmtptr)
end

"""
Closes the prepared statement.
"""
function mysql_stmt_close(stmtptr::Ptr{MYSQL_STMT})
    return ccall((:mysql_stmt_close, mysql_lib),
                 Cchar,
                 (Ptr{Cuchar}, ),
                 stmtptr)
end

function mysql_insert_id(mysqlptr::Ptr{Void})
    return ccall((:mysql_insert_id, mysql_lib),
                 Culong,
                 (Ptr{Cuchar}, ),
                 mysqlptr)
end

"""
Creates the sql string where the special chars are escaped
"""
function mysql_real_escape_string(mysqlptr::Ptr{Void},
                                  to::Vector{Cuchar},
                                  from::String,
                                  length::Culong)
    return ccall((:mysql_real_escape_string, mysql_lib),
                 Cuint,
                 (Ptr{Cuchar},
                  Ptr{Cuchar},
                  Ptr{Cuchar},
                  Culong),
                 mysqlptr,
                 to,
                 from,
                 length)
end

"""
Creates a mysql_stmt handle. Should be closed with mysql_close_stmt
"""
function mysql_stmt_init(mysqlptr::Ptr{Void})
    return ccall((:mysql_stmt_init, mysql_lib),
                 Ptr{MYSQL_STMT},
                 (Ptr{Void}, ),
                 mysqlptr)
end

function mysql_stmt_prepare(stmtptr::Ptr{MYSQL_STMT}, sql::String)
    s = String(sql)
    return ccall((:mysql_stmt_prepare, mysql_lib),
                 Cint,
                 (Ptr{Void}, Ptr{Cchar}, Culong),
                 stmtptr,      s,        length(s))
end

"""
Returns the error message for the recently invoked statement API
"""
function mysql_stmt_error(stmtptr::Ptr{MYSQL_STMT})
    return ccall((:mysql_stmt_error, mysql_lib),
                 Ptr{Cuchar},
                 (Ptr{Cuchar}, ),
                 stmtptr)
end

"""
Store the entire result returned by the prepared statement in the
bind datastructure provided by mysql_stmt_bind_result.
"""
function mysql_stmt_store_result(stmtptr::Ptr{MYSQL_STMT})
    return ccall((:mysql_stmt_store_result, mysql_lib),
                 Cint,
                 (Ptr{Cuchar}, ),
                 stmtptr)
end

"""
Return the metadata for the results that will be received from
the execution of the prepared statement.
"""
function mysql_stmt_result_metadata(stmtptr::Ptr{MYSQL_STMT})
    return ccall((:mysql_stmt_result_metadata, mysql_lib),
                 MYSQL_RES,
                 (Ptr{MYSQL_STMT}, ),
                 stmtptr)
end

"""
Equivalent of `mysql_num_rows` for prepared statements.
"""
function mysql_stmt_num_rows(stmtptr::Ptr{MYSQL_STMT})
    return ccall((:mysql_stmt_num_rows, mysql_lib),
                 Clong,
                 (Ptr{Cuchar}, ),
                 stmtptr)
end

"""
Equivalent of `mysql_fetch_row` for prepared statements.
"""
function mysql_stmt_fetch(stmtptr::Ptr{MYSQL_STMT})
    return ccall((:mysql_stmt_fetch, mysql_lib),
                 Cint,
                 (Ptr{Cuchar}, ),
                 stmtptr)
end

"""
Bind the returned data from execution of the prepared statement
to a preallocated datastructure `bind`.
"""
function mysql_stmt_bind_result(stmtptr::Ptr{MYSQL_STMT}, bind::Ptr{MYSQL_BIND})
    return ccall((:mysql_stmt_bind_result, mysql_lib),
                 Cchar,
                 (Ptr{Cuchar}, Ptr{Cuchar}),
                 stmtptr,
                 bind)
end

function mysql_query(mysqlptr::Ptr{Void}, sql::String)
    return ccall((:mysql_query, mysql_lib),
                 Cchar,
                 (Ptr{Void}, Ptr{Cuchar}),
                 mysqlptr,
                 sql)
end

function mysql_store_result(mysqlptr::Ptr{Void})
    return ccall((:mysql_store_result, mysql_lib),
                 MYSQL_RES,
                 (Ptr{Void}, ),
                 mysqlptr)
end

"""
Returns the field metadata.
"""
function mysql_fetch_fields(results::MYSQL_RES)
    return ccall((:mysql_fetch_fields, mysql_lib),
                 Ptr{MYSQL_FIELD},
                 (MYSQL_RES, ),
                 results)
end


"""
Returns the row from the result set.
"""
function mysql_fetch_row(results::MYSQL_RES)
    return ccall((:mysql_fetch_row, mysql_lib),
                 MYSQL_ROW,
                 (MYSQL_RES, ),
                 results)
end

"""
Frees the result set.
"""
function mysql_free_result(results::MYSQL_RES)
    return ccall((:mysql_free_result, mysql_lib),
                 Ptr{Cuchar},
                 (MYSQL_RES, ),
                 results)
end

"""
Returns the number of fields in the result set.
"""
function mysql_num_fields(results::MYSQL_RES)
    return ccall((:mysql_num_fields, mysql_lib),
                 Cuint,
                 (MYSQL_RES, ),
                 results)
end

"""
Returns the number of records from the result set.
"""
function mysql_num_rows(results::MYSQL_RES)
    return ccall((:mysql_num_rows, mysql_lib),
                 Clong,
                 (MYSQL_RES, ),
                 results)
end

"""
Returns the # of affected rows in case of insert / update / delete.
"""
function mysql_affected_rows(results::MYSQL_RES)
    return ccall((:mysql_affected_rows, mysql_lib),
                 Culong,
                 (MYSQL_RES, ),
                 results)
end

"""
Set the auto commit mode.
"""
function mysql_autocommit(mysqlptr::Ptr{Void}, mode::Cchar)
    return ccall((:mysql_autocommit, mysql_lib),
                 Cchar, (Ptr{Void}, Cchar),
                 mysqlptr, mode)
end

"""
Used to get the next result while executing multi query. Returns 0 on success
and more results are present. Returns -1 on success and no more results. Returns
positve on error.
"""
function mysql_next_result(mysqlptr::Ptr{Void})
    return ccall((:mysql_next_result, mysql_lib),
                 Cint, (MYSQL_RES, ),
                 mysqlptr)
end

"""
Returns the number of columns for the most recent query on the connection.
"""
function mysql_field_count(mysqlptr::Ptr{Void})
    return ccall((:mysql_field_count, mysql_lib),
                 Cuint, (Ptr{Void}, ), mysqlptr)
end

"""
This API is used to bind input data for the parameter markers in the SQL
 statement that was passed to `mysql_stmt_prepare()`. It uses `MYSQL_BIND`
 structures to supply the data. `bind` is the address of an array of `MYSQL_BIND`
 structures. The client library expects the array to contain one element for
 each ? parameter marker that is present in the query.
"""
function mysql_stmt_bind_param(stmt::Ptr{MYSQL_STMT}, bind::Ptr{MYSQL_BIND})
    return ccall((:mysql_stmt_bind_param, mysql_lib),
                 Cuchar, (Ptr{MYSQL_STMT}, Ptr{MYSQL_BIND}, ),
                 stmt, bind)
end

mysql_stmt_bind_param(stmt, bind::Array{MYSQL_BIND, 1}) =
    mysql_stmt_bind_param(stmt, pointer(bind))

"""
Returns number of affected rows for prepared statement. `mysql_stmt_execute` must
 be called before this.
"""
function mysql_stmt_affected_rows(stmt::Ptr{MYSQL_STMT})
    return ccall((:mysql_stmt_affected_rows, mysql_lib),
                 Culong, (Ptr{Void}, ), stmt)
end
