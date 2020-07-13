

local FOOTER_HEIGHT = 35
local MARGIN = 3
local NB_BUTTON_PER_ROW = 4


local widget = require 'widget'
local composer = require 'composer'
local scene = composer.newScene()


local library = require 'xyz.canardoux.micorazon'
local dyglot = require 'DgltCards-view'
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

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
        width = display.contentWidth/2 - NB_BUTTON_PER_ROW*MARGIN,
        height = FOOTER_HEIGHT - 4* MARGIN ,
        fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } },
        shape = 'roundedRect',
        width = totalWidth/NB_BUTTON_PER_ROW -  MARGIN
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
        if ( system.getInfo("platformName") ~= "macos") and  (system.getInfo("platformName") ~= "win32") and (system.getInfo("platformName") ~= "linux") then
                top = STATUS_HEIGHT
        end

        --local Hello = display.newRect( backgroundGrp, display.contentCenterX ,     display.contentCenterY ,     200, 100)
        --backgroundGrp:insert(Hello)
        local t1 = display.newText(   {parent = backgroundGrp, x = display.contentCenterX , y = display.contentCenterY - 10 , text = 'Form composed with Solar2d' } )
       local  t1 = display.newText(   {parent = backgroundGrp, x = display.contentCenterX , y = display.contentCenterY + 10 , text = 'and rendered by Solar2d' } )


        ButtonBar = display.newGroup()
        backgroundGrp:insert(ButtonBar)

        ButtonBar.x = MARGIN/2
        ButtonBar.y =  display.contentHeight  - (FOOTER_HEIGHT ) + 2 * MARGIN - MARGIN/2
        local ButtonBarPanel = display.newRect( display.contentCenterX - MARGIN/2, 0,     display.contentWidth - (2 * MARGIN),     2 * FOOTER_HEIGHT - 5 * MARGIN)
        ButtonBarPanel:setFillColor( 0, 0, 0.3 )
        ButtonBar:insert(ButtonBarPanel)

        FirstButtonRow = display.newGroup()
        FirstButtonRow.x = MARGIN + MARGIN/2
        FirstButtonRow.y =  (-FOOTER_HEIGHT /2 + MARGIN + MARGIN/2)
        ButtonBar:insert(FirstButtonRow)

        SecondButtonRow= display.newGroup()
        SecondButtonRow.x =  MARGIN + MARGIN/2
        SecondButtonRow.y =    (FOOTER_HEIGHT /2 - MARGIN - MARGIN/2)
        ButtonBar:insert(SecondButtonRow)

        parambtn.label = 'Micorazon'
        parambtn.x =  totalWidth/(2*NB_BUTTON_PER_ROW)
        parambtn.onPress=function() library.show( 'Zozo' ); end
        local firstBtn = widget.newButton( parambtn )
        FirstButtonRow:insert(firstBtn)

        parambtn.label = 'Flutter'
        parambtn.x =  totalWidth/(2*NB_BUTTON_PER_ROW)+ totalWidth/NB_BUTTON_PER_ROW
        parambtn.onPress=function() library.run( ); end
        local firstBtn = widget.newButton( parambtn )
        FirstButtonRow:insert(firstBtn)

        parambtn.label = 'Dyna'
        parambtn.x =  totalWidth/(2*NB_BUTTON_PER_ROW) + 2*totalWidth/NB_BUTTON_PER_ROW
        parambtn.onPress=nullFn
        local thirdBtn = widget.newButton( parambtn )
        FirstButtonRow:insert(thirdBtn)

        parambtn.label = 'Dyglot'
        parambtn.x =  totalWidth/(2*NB_BUTTON_PER_ROW) + 3*totalWidth/NB_BUTTON_PER_ROW
        parambtn.onPress=function() composer.gotoScene( "DgltCards-view" ); end
        local fourthBtn = widget.newButton( parambtn )
        FirstButtonRow:insert(fourthBtn)

        --

        parambtn.label = 'Run2'
        parambtn.x =  totalWidth/(2*NB_BUTTON_PER_ROW)
        parambtn.onPress=function() library.run2( ); end
        local subBtn = widget.newButton( parambtn )
        SecondButtonRow:insert(subBtn)

        parambtn.label = ''
        parambtn.x =  totalWidth/(2*NB_BUTTON_PER_ROW) + totalWidth/NB_BUTTON_PER_ROW
        parambtn.onPress=nullFn
        local gotoLeft2Btn = widget.newButton( parambtn )
        SecondButtonRow:insert(gotoLeft2Btn)

        parambtn.label = ''
        parambtn.x =  totalWidth/(2*NB_BUTTON_PER_ROW) + 2*totalWidth/NB_BUTTON_PER_ROW
        parambtn.onPress=nullFn
        local lookupBtn = widget.newButton( parambtn )
        SecondButtonRow:insert(lookupBtn)

        parambtn.label = ''
        parambtn.x =  totalWidth/(2*NB_BUTTON_PER_ROW) + 3*totalWidth/NB_BUTTON_PER_ROW
        parambtn.onPress=nullFn
        local tag2Btn = widget.newButton( parambtn )
        SecondButtonRow:insert(tag2Btn)



 end



-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
-- -----------------------------------------------------------------------------------

return scene
