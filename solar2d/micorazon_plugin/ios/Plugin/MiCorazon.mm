//
//  PluginLibrary.mm
//  TemplateApp
//
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MiCorazon.h"

#include <CoronaRuntime.h>
#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>
#import <CoronaDelegate.h>
#import <UIKit/UIApplication.h>
#import "GeneratedPluginRegistrant.h"
#import <UIKit/UIViewController.h>


static FlutterEngine *flutterEngine = nil;

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
                static int run( lua_State *L );
                static int run2( lua_State *L );
                static int run3( lua_State *L );

	private:
		CoronaLuaRef fListener;
  
        private:
                static UIViewController* topViewController();
                static UIViewController* topViewController(UIViewController * rootViewController);
                static UIViewController* bottomViewController();


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
                { "run", run },
                { "run2", run2 },
                { "run3", run3 },

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
	
	if ( [UIReferenceLibraryViewController class] )
	{
		id<CoronaRuntime> runtime = (id<CoronaRuntime>)CoronaLuaGetContext( L );

		const char kDefaultWord[] = "toto";
		const char *word = lua_tostring( L, 1 );
		if ( ! word )
		{
			word = kDefaultWord;
		}

		UIReferenceLibraryViewController *controller = [[[UIReferenceLibraryViewController alloc] initWithTerm:[NSString stringWithUTF8String:word]] autorelease];

		// Present the controller modally.
		[runtime.appViewController presentViewController:controller animated:YES completion:nil];

		message = @"Success. Displaying UIReferenceLibraryViewController for 'corona'.";
	}

	Self *library = ToLibrary( L );

	// Create event and add message to it
	CoronaLuaNewEvent( L, kEvent );
	lua_pushstring( L, [message UTF8String] );
	lua_setfield( L, -2, "message" );

	// Dispatch event to library's listener
	CoronaLuaDispatchEvent( L, library->GetListener(), 0 );

	return 0;
}

UIViewController*
MiCorazon::topViewController()
{
  return topViewController ([UIApplication sharedApplication].keyWindow.rootViewController);
}


UIViewController*
MiCorazon::bottomViewController()
{
  return [UIApplication sharedApplication].keyWindow.rootViewController;
}

UIViewController*
MiCorazon::topViewController(UIViewController * rootViewController)
{
        if (rootViewController.presentedViewController == nil)
        {
                return rootViewController;
        }
  
        if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]])
        {
                UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
                UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
                return topViewController (lastViewController);
        }
  
        UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
        return topViewController (presentedViewController);
}

int
MiCorazon::run (lua_State* L)
{
        if (flutterEngine == nil)
        {
                flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
                [flutterEngine runWithEntrypoint:nil];
                [GeneratedPluginRegistrant registerWithRegistry: flutterEngine];
        }
        FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
        UIViewController* top = topViewController();
        [top presentViewController:flutterViewController animated:YES completion:nil];
        return 0;
}


int
MiCorazon::run2 (lua_State* L)
{
        if (flutterEngine == nil)
        {
                flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
                [flutterEngine runWithEntrypoint:nil];
                [GeneratedPluginRegistrant registerWithRegistry: flutterEngine];
        }
        FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
        UIViewController* bottom = bottomViewController();
        [bottom presentViewController:flutterViewController animated:YES completion:nil];
        return 0;
}


int
MiCorazon::run3 (lua_State* L)
{
        if (flutterEngine == nil)
        {
                flutterEngine = [[FlutterEngine alloc] initWithName:@"io.flutter" project:nil];
                [flutterEngine runWithEntrypoint:nil];
                [GeneratedPluginRegistrant registerWithRegistry: flutterEngine];
        }
        id<CoronaRuntime> runtime = (id<CoronaRuntime>)CoronaLuaGetContext( L );
        FlutterViewController* flutterViewController = [[FlutterViewController alloc] initWithEngine:flutterEngine nibName:nil bundle:nil];
        UINavigationController* nav = runtime.appViewController.navigationController;
        [nav pushViewController: flutterViewController animated:YES];
        [runtime.appViewController presentViewController:flutterViewController animated:YES completion:nil];
        return 0;
}


// ----------------------------------------------------------------------------

CORONA_EXPORT int luaopen_xyz_canardoux_micorazon( lua_State *L )
{
	return MiCorazon::Open( L );
}
