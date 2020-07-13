//
//  SimulatorMiCorazon.mm
//  TemplateApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SimulatorMiCorazon.h"

#include <CoronaRuntime.h>

#include <CoronaLua.h>
#include <CoronaMacros.h>
#include <AppKit/AppKit.h>



// ----------------------------------------------------------------------------

class MiCorazon
{
	public:
		typedef MiCorazon Self;

	public:
		static const char kName[];
		static const char kEvent[];

	protected:
		MiCorazon();

	public:
		bool Initialize( CoronaLuaRef listener );

	public:
		CoronaLuaRef GetListener() const { return fListener; }

	public:
		static int Open( lua_State *L );

	protected:
		static int Finalizer( lua_State *L );

	public:
		static Self *ToLibrary( lua_State *L );

	public:
		static int init( lua_State *L );
		static int show( lua_State *L );

	private:
		CoronaLuaRef fListener;
};

// ----------------------------------------------------------------------------

// This corresponds to the name of the library, e.g. [Lua] require "MiCorazon"
const char MiCorazon::kName[] = "MiCorazon";

// This corresponds to the event name, e.g. [Lua] event.name
const char MiCorazon::kEvent[] = "micorazonevent";

MiCorazon::MiCorazon()
:	fListener( NULL )
{
}

bool
MiCorazon::Initialize( CoronaLuaRef listener )
{
	// Can only initialize listener once
	bool result = ( NULL == fListener );

	if ( result )
	{
		fListener = listener;
	}

	return result;
}

int
MiCorazon::Open( lua_State *L )
{
	// Register __gc callback
	const char kMetatableName[] = __FILE__; // Globally unique string to prevent collision
	CoronaLuaInitializeGCMetatable( L, kMetatableName, Finalizer );

	// Functions in library
	const luaL_Reg kVTable[] =
	{
		{ "init", init },
		{ "show", show },

		{ NULL, NULL }
	};

	// Set library as upvalue for each library function
	Self *library = new Self;
	CoronaLuaPushUserdata( L, library, kMetatableName );

	luaL_openlib( L, kName, kVTable, 1 ); // leave "library" on top of stack

	return 1;
}

int
MiCorazon::Finalizer( lua_State *L )
{
	Self *library = (Self *)CoronaLuaToUserdata( L, 1 );

	CoronaLuaDeleteRef( L, library->GetListener() );

	delete library;

	return 0;
}

MiCorazon *
MiCorazon::ToLibrary( lua_State *L )
{
	// library is pushed as part of the closure
	Self *library = (Self *)CoronaLuaToUserdata( L, lua_upvalueindex( 1 ) );
	return library;
}

// [Lua] library.init( listener )
int
MiCorazon::init( lua_State *L )
{
	int listenerIndex = 1;

	if ( CoronaLuaIsListener( L, listenerIndex, kEvent ) )
	{
		Self *library = ToLibrary( L );

		CoronaLuaRef listener = CoronaLuaNewRef( L, listenerIndex );
		library->Initialize( listener );
	}

	return 0;
}

// [Lua] library.show( word )
int
MiCorazon::show( lua_State *L )
{
	NSString *message = @"Error: Could not display UIReferenceLibraryViewController. This feature requires iOS 5 or later.";
	/*
	if ( [NSViewController class] )
	{
		id<CoronaRuntime> runtime = (id<CoronaRuntime>)CoronaLuaGetContext( L );

		const char kDefaultWord[] = "toto";
		const char *word = lua_tostring( L, 1 );
		if ( ! word )
		{
			word = kDefaultWord;
		}

		NSViewController *controller = [[[NSViewController alloc] initWithTerm:[NSString stringWithUTF8String:word]] autorelease];

		// Present the controller modally.
		[runtime.appViewController presentViewController:controller animated:YES completion:nil];

		message = @"Success. Displaying UIReferenceLibraryViewController for 'corona'.";
	}
*/
NSRunAlertPanel(@"Mi Corazon Plugin for MAC", @"Mi Corazon Plugin for MAC", @"OK", nil, nil);

	Self *library = ToLibrary( L );

	// Create event and add message to it
	CoronaLuaNewEvent( L, kEvent );
	lua_pushstring( L, [message UTF8String] );
	lua_setfield( L, -2, "message" );

	// Dispatch event to library's listener
	CoronaLuaDispatchEvent( L, library->GetListener(), 0 );

	return 0;
}


// ----------------------------------------------------------------------------

// This corresponds to the name of the Lua file (simulator_plugin_library.lua)
// where the prefix 'CoronaPluginLuaLoad' is prepended.
CORONA_EXPORT int CoronaPluginLuaLoad_simulatorMiCorazon( lua_State * );


// ----------------------------------------------------------------------------

CORONA_EXPORT int luaopen_xyz_canardoux_micorazon( lua_State *L )
{
	return MiCorazon::Open( L );
}
