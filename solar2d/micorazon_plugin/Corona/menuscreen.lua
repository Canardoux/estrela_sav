

local FOOTER_HEIGHT = 35
local MARGIN = 3


local widget = require "widget"
local composer = require "composer"
local scene = composer.newScene()

local library = require "xyz.canardoux.micorazon"
--This event is dispatched to the following Lua function
-- by PluginLibrary::show() in PluginLibrary.mm
local function listener( event )
    print( "Received event from Library plugin (" .. event.name .. "): ", event.message )
end
--++library.init( listener )

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    -- Hide the status bar
    --display.setStatusBar( display.HiddenStatusBar )

   local totalWidth = display.contentWidth - 4 * MARGIN


    local parambtn =
    {
        id = 'myBtn',
        x = 0,
        y = 0,
        labelAlign = 'center',
        emboss = true,
        labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
        textOnly = false,
        width = display.contentWidth/2 - 4*MARGIN,
        height = FOOTER_HEIGHT - 4* MARGIN ,
        fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } },
        shape = 'roundedRect',
        width = totalWidth/5 -  MARGIN
    }

    nullFn= function ()
        print('NULL\n')
    end

    -- Set the background to white
    display.setDefault( "background", 1 )    -- white


    local backgroundGrp = display.newGroup()
    sceneGroup:insert( backgroundGrp )

    local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
    background:setFillColor( 0.5, 0.5, 1 )  -- lila
    backgroundGrp:insert( background )

    local top = 0
    if ( system.getInfo("platformName") ~= "macos") and  (system.getInfo("platformName") ~= "win32") then
        top = STATUS_HEIGHT
    end



    TeacherBrowseFooterGrp = display.newGroup()
    backgroundGrp:insert(TeacherBrowseFooterGrp)

    TeacherBrowseFooterGrp.x = MARGIN/2
    TeacherBrowseFooterGrp.y =  display.contentHeight  - (FOOTER_HEIGHT ) + 2 * MARGIN - MARGIN/2
    local TeacherBrowseFooterPanel = display.newRect( display.contentCenterX - MARGIN/2, 0,     display.contentWidth - (2 * MARGIN),     2 * FOOTER_HEIGHT - 5 * MARGIN)
    TeacherBrowseFooterPanel:setFillColor( 0, 0, 0.3 )
    TeacherBrowseFooterGrp:insert(TeacherBrowseFooterPanel)

    TeacherBrowse1FooterGrp= display.newGroup()
    TeacherBrowse1FooterGrp.x = MARGIN + MARGIN/2
    TeacherBrowse1FooterGrp.y =  (-FOOTER_HEIGHT /2 + MARGIN + MARGIN/2)
    TeacherBrowseFooterGrp:insert(TeacherBrowse1FooterGrp)

    TeacherBrowse2FooterGrp= display.newGroup()
    TeacherBrowse2FooterGrp.x =  MARGIN + MARGIN/2
    TeacherBrowse2FooterGrp.y =    (FOOTER_HEIGHT /2 - MARGIN - MARGIN/2)
    TeacherBrowseFooterGrp:insert(TeacherBrowse2FooterGrp)

    parambtn.label = 'Show'
    parambtn.x =  totalWidth/10
    parambtn.onPress=function() library.show( "Zozo" ); end
    local firstBtn = widget.newButton( parambtn )
    TeacherBrowse1FooterGrp:insert(firstBtn)

    parambtn.label = 'Flutter'
    parambtn.x =  totalWidth/10+ totalWidth/5
    parambtn.onPress=nullFn
    local firstBtn = widget.newButton( parambtn )
    TeacherBrowse1FooterGrp:insert(firstBtn)

    parambtn.label = 'Dyna'
    parambtn.x =  totalWidth/10 + 2*totalWidth/5
    parambtn.onPress=nullFn
    local m50Btn = widget.newButton( parambtn )
    TeacherBrowse1FooterGrp:insert(m50Btn)

    parambtn.label = ''
    parambtn.x =  totalWidth/10 + 3*totalWidth/5
    parambtn.onPress=nullFn
    local p50Btn = widget.newButton( parambtn )
    TeacherBrowse1FooterGrp:insert(p50Btn)

    parambtn.label = ''
    parambtn.x =  totalWidth/10 + 4*totalWidth/5
    parambtn.onPress=nullFn
    local lastBtn = widget.newButton( parambtn )
    TeacherBrowse1FooterGrp:insert(lastBtn)

    --

    parambtn.label = ''
    parambtn.x =  totalWidth/10
    parambtn.onPress=nullFn
    local subBtn = widget.newButton( parambtn )
    TeacherBrowse2FooterGrp:insert(subBtn)

    parambtn.label = ''
    parambtn.x =  totalWidth/10 + totalWidth/5
    parambtn.onPress=nullFn
    local gotoLeft2Btn = widget.newButton( parambtn )
    TeacherBrowse2FooterGrp:insert(gotoLeft2Btn)

    parambtn.label = ''
    parambtn.x =  totalWidth/10 + 2*totalWidth/5
    parambtn.onPress=nullFn
    local lookupBtn = widget.newButton( parambtn )
    TeacherBrowse2FooterGrp:insert(lookupBtn)

    parambtn.label = ''
    parambtn.x =  totalWidth/10 + 3*totalWidth/5
    parambtn.onPress=nullFn
    local tag2Btn = widget.newButton( parambtn )
    TeacherBrowse2FooterGrp:insert(tag2Btn)

    parambtn.label = ''
    parambtn.x =  totalWidth/10 + 4*totalWidth/5
    parambtn.onPress=nullFn
    local gotoRight2Btn = widget.newButton( parambtn )
    TeacherBrowse2FooterGrp:insert(gotoRight2Btn)



 end



-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
-- -----------------------------------------------------------------------------------

return scene
