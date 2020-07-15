
local widget = require 'widget'
local composer = require 'composer'
local scene = composer.newScene()
local library = require 'xyz.canardoux.micorazon'



-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
-- show()
function scene:show( event )
    print('test SHOW')
              --library.push( );
               -- print('test PUSH CALLED');
  end

-- hide()
function scene:hide( event )
        print('test HIDE')
     local phase = event.phase
     if (phase == 'will') then
                --composer.removeScene('test');
                --composer.gotoScene('menuscreen'  );
     end

end

-- show()
function scene:destroy( event )
        print('test DESTROY')

end


-- create()
function scene:create( event )

    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen

    local totalWidth = display.contentWidth

      -- Set the background to white
        display.setDefault( "background", 1 )    -- white


        local backgroundGrp = display.newGroup()
        sceneGroup:insert( backgroundGrp )

        local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
        background:setFillColor( 0.5, 0.5, 1 )  -- lila
        backgroundGrp:insert( background )

          --local Hello = display.newRect( backgroundGrp, display.contentCenterX ,     display.contentCenterY ,     200, 100)
        --backgroundGrp:insert(Hello)
        local t1 = display.newText(   {parent = backgroundGrp, x = display.contentCenterX , y = display.contentCenterY - 10 , text = 'Form composed with Solar2d' } )
        local t1 = display.newText(   {parent = backgroundGrp, x = display.contentCenterX , y = display.contentCenterY + 10 , text = 'and rendered by Solar2d' } )


    local parambtn =
    {
        id = 'myBtn',
        x = 0,
        y = 0,
        labelAlign = 'center',
        emboss = true,
        labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
        textOnly = false,
        height = 20,
        fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } },
        shape = 'roundedRect',
        width = 150,
        parent = backgroundGrp,
        x = display.contentCenterX ,
    }
        parambtn.label = 'Back to Previous'
        parambtn.onPress=function()  composer.gotoScene( composer.getSceneName( "previous" )); end
        parambtn.y = display.contentCenterY + 30
        local firstBtn = widget.newButton( parambtn )
        backgroundGrp:insert(firstBtn)

        parambtn.label = 'Menu...'
        parambtn.onPress=function()  composer.gotoScene( 'menuscreen'); end
        parambtn.y = display.contentCenterY + 60
        local firstBtn = widget.newButton( parambtn )
        backgroundGrp:insert(firstBtn)


        parambtn.label = 'Push'
        parambtn.onPress=function()  library.push();
        composer.removeScene('test');
                                        composer.gotoScene('menuscreen'  );end
        parambtn.y = display.contentCenterY + 90
        local firstBtn = widget.newButton( parambtn )
        backgroundGrp:insert(firstBtn)



 end



-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
