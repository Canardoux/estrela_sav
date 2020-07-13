-----------------------------------------------------------------------------------------
--
-- view2.lua
--
-----------------------------------------------------------------------------------------

local composer = require( 'composer' )

DgltCards =
{

OnBackPressed = function ()
	print('OnBackPressed!')
	composer.gotoScene( 'menuscreen' )
--    library.show( "FUCK!!!!" )
-- [LARPOUX] : I do not understant why Corona uses a timer here. I decide to remove it :-/
--[[
	timer.performWithDelay
	(
		1000,
		function()
    			library.show( "FUCK" )
		end
	)
--]]
end,

OnScoreAveragePressed= function ()
	print('OnScoreAveragePressed')
end,

onHanjaChkPressed= function (isOn)
	print('onHanjaChkPressed : ' .. tostring(isOn) )
end,

onExamplesChkPressed= function (isOn)
	print('onExamplesChkPressed : ' .. tostring(isOn) )
end,

onVocalChkPressed= function (isOn)
	print('onVocalChkPressed : ' .. tostring(isOn) )
end,

OnVocalPressed = function ()
	print('OnVocalPressed'  )
--[[
    print 'FUCK!'
    Runtime:addEventListener( "delegate", delegateListener )
    timer.performWithDelay
    (
        1000,
        function()
                library.show( "FUCK" )
        end
    )
    --]]
end,


OnRecordPressed = function ()
	print('OnRecordPressed'  )
end,


OnHanjaTextPressed = function ()
	print('OnHanjaTextPressed'  )
end,

OnGramPressed = function ()
	print('OnGramPressed'  )
end,


OnWordTextPressed = function ()
	print('OnWordTextPressed'  )
end,

OnShowPressed = function ()
	print('OnShowPressed')
	Stacks['OLDER'] = 666
	print (Stacks[2])
	Phase = 'ANSWER'
	ShowCard()
end,


OnRightPressed = function ()
	print ('OnRightPressed')
	Phase = 'QUESTION'
	ShowCard()
end,

OnTagPressed = function ()
	print ('OnTagPressed')
	Phase = 'BROWSE' -- temporary
	Mode = 'BROWSE' -- temporary
	TeacherMode = false
	ShowCard()
end,

OnGoLeftPressed = function ()
	print ('OnGoLeftPressed')
	ShowCard()
end,

OnGoRightPressed = function ()
	print ('OnGoRightPressed')
	ShowCard()
end,


OnFirstPressed = function ()
	print ('OnFirstPressed')
	--Phase = 'BROWSE' -- temporary
	--Mode = 'BROWSE' -- temporary
	TeacherMode = false
	ShowCard()
end,


OnM50Pressed = function ()
	print ('OnM50Pressed')
	Phase = 'QUESTION' -- Temporary
	ShowCard()
end,

OnP50Pressed = function ()
	print ('OnP50Pressed')
	Phase = 'QUESTION' -- Temporary
	ShowCard()
end,


OnLastPressed = function ()
	print ('OnLastPressed')
	--Phase = 'BROWSE' -- temporary
	--Mode = 'BROWSE' -- temporary
	TeacherMode = true
	ShowCard()
end,


OnLookupPressed = function ()
	print ('OnLookupPressed')
	Phase = 'QUESTION' -- Temporary
	ShowCard()
end,

OnGotoRightPressed = function ()
	print ('OnGotoRightPressed')
	Phase = 'QUESTION' -- Temporary
	ShowCard()
end,


OnAddPressed = function ()
	print ('OnAddPressed')
	Phase = 'QUESTION' -- Temporary
	ShowCard()
end,


OnSubPressed = function ()
	print ('OnSubPressed')
	Phase = 'QUESTION' -- Temporary
	ShowCard()
end,


 toto = 'toto'
}

function DgltCards:OnPreviousPressed()
	print(self)
	print(DgltCards)
	print(self.toto)
	--print (sceneGroup)
	--print (QuestFooterGrp)
	Phase = 'PREVIOUS'
	ShowScoreAverage()
	ShowCard()
	--QuestFooterGrp.isVisible = false
	--AnswerFooterGrp.isVisible = true
end


function DgltCards:OnWrongPressed()
	print ('OnWrongPressed')
	--print (sceneGroup)
	--print (QuestFooterGrp)
	--sceneGroup:insert(QuestFooterGrp )
	--display.insert(QuestFooterGrp )
	--scene:showCard()
	--QuestFooterGrp.isVisible = true
	--AnswerFooterGrp.isVisible = false
	Phase = 'QUESTION'
	ShowCard()
end

function DgltCards:OnCreate()
	print 'OnCreate'
	ShowCard()
end

function DgltCards:OnWillShow()
	print ('OnWillShow')
end


function DgltCards:OnShown()
	print ('OnShown')
end


function DgltCards:OnWillHide()
	print ('OnWillHide')
end


function DgltCards:OnHidden()
	print ('OnHidden')
end


function DgltCards:OnDestroy()
	print ('OnDestroy')
end

--[[

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	--
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- create a white background to fill screen
	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 1 )	-- white

	-- create some text
	local title = display.newText( "Second View", display.contentCenterX, 125, native.systemFont, 32 )
	title:setFillColor( 0 )	-- black

	local newTextParams = { text = "Loaded by the second tab's\n\"onPress\" listener\nspecified in the 'tabButtons' table",
							x = display.contentCenterX + 10,
							y = title.y + 215,
							width = 310,
							height = 310,
							font = native.systemFont,
							fontSize = 14,
							align = "center" }
	local summary = display.newText( newTextParams )
	summary:setFillColor( 0 ) -- black

	-- all objects must be added to group (e.g. self.view)
	sceneGroup:insert( background )
	sceneGroup:insert( title )
	sceneGroup:insert( summary )
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		--
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase

	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

	-- Called prior to the removal of scene's "view" (sceneGroup)
	--
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
]]
