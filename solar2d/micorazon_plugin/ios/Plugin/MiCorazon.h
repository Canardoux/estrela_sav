//
//  PluginLibrary.h
//  TemplateApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#ifndef MiCorazon_H_
#define MiCorazon_H_

#include <CoronaLua.h>
#include <CoronaMacros.h>

// This corresponds to the name of the library, e.g. [Lua] require "MiCorazon"
// where the '.' is replaced with '_'
CORONA_EXPORT int luaopen_xyz_canardoux_micorazon( lua_State *L );

#endif // MiCorazon_H_
