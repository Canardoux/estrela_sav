--local library = require "xyz.canardoux.micorazon"

-- This event is dispatched to the global Runtime object
-- by `didLoadMain:` in MyCoronaDelegate.mm
local function delegateListener( event )
	native.showAlert(
		"Event dispatched from `didLoadMain:`",
		"of type: " .. tostring( event.name ),
		{ "OK" } )
end

Runtime:addEventListener( "delegate", delegateListener )

-- This event is dispatched to the following Lua function
-- by PluginLibrary::show() in PluginLibrary.mm
local function listener( event )
	print( "Received event from Library plugin (" .. event.name .. "): ", event.message )
end
--library.init( listener )
--timer.performWithDelay( 1000, function()
	--library.show( "corona" )
--end )


-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
local composer = require "composer"
print 'toto'


function zozo( str,int )
    return "C est coule mec : " -------.. library.getstr(str)
end

print (zozo('hiu', 555))


-- show default status bar (iOS)
display.setStatusBar( display.DefaultStatusBar )



if ( system.getInfo("platformName") == "Android" ) then
        --local androidVersion = string.sub( system.getInfo( "platformVersion" ), 1, 3)
        --if( androidVersion and tonumber(androidVersion) >= 4.4 ) then
        --native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
        --native.setProperty( "androidSystemUiVisibility", "lowProfile" )
        --elseif( androidVersion ) then
        print 'Android'
        native.setProperty( "androidSystemUiVisibility", "default" )
        --end
end


composer.gotoScene( "menuscreen" )

