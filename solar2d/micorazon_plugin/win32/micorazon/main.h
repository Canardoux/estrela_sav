#ifndef __MAIN_H__
#define __MAIN_H__

#include <windows.h>
#include <CoronaLua.h>
#include <CoronaMacros.h>

/*  To use this exported function of dll, include this header
 *  in your project.
 */

#ifdef BUILD_DLL
    #define DLL_EXPORT __declspec(dllexport)
#else
    #define DLL_EXPORT __declspec(dllimport)
#endif


#ifdef __cplusplus
extern "C"
{
#endif

void DLL_EXPORT SomeFunction(const LPCSTR sometext);

// This corresponds to the name of the library, e.g. [Lua] require "MiCorazon"
// where the '.' is replaced with '_'
CORONA_EXPORT int luaopen_xyz_canardoux_micorazon ( lua_State *L );


#ifdef __cplusplus
}
#endif

#endif // __MAIN_H__
