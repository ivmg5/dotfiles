lua_interpreter = "/opt/homebrew/opt/luajit/bin/luajit"
lua_version     = "5.1"

variables = {
  LUA_DIR    = "/opt/homebrew/opt/luajit";
  LUA_BINDIR = "/opt/homebrew/opt/luajit/bin";
  LUA_INCDIR = "/opt/homebrew/opt/luajit/include/luajit-2.1";
  LUA_LIBDIR = "/opt/homebrew/opt/luajit/lib";
}

rocks_trees = {
  { name = "user", root = "/Users/ivmg5/.luarocks" }
}
