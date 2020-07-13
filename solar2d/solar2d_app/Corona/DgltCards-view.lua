-----------------------------------------------------------------------------------------
--
-- DgltCards-view.lua
--
-----------------------------------------------------------------------------------------

local DgltCardsxxx = require "DgltCards"
local DgltGlobals = require ("DgltGlobals")


local FOOTER_HEIGHT = 35
local MARGIN = 3
local SCORE_HEIGHT = 22
local STATUS_HEIGHT = 10
local BTN_WIDTH = 70
local STACK_HEIGHT = 13
local QUESTION_HEIGHT = 80
local CHECK_WIDTH = 50
local CHECK_BTN_SIZE = 15
local GRAM_WIDTH = 40
local EXAMPLE_HEIGHT = 80
local ANSWER_HEIGHT = 92


local widget = require "widget"
local composer = require "composer"
local scene = composer.newScene()


function ShowScoreAverage()
	scoreAverageBtn.text = 'Average ' .. GetScore() .. '%'
end

function ShowStacks()
	untestedValue.text = Stacks['UNTESTED']
	newValue.text = Stacks['NEW']
	recentValue.text = Stacks['RECENT']
	olderValue.text = Stacks['OLDER']
	ancientValue.text = Stacks['ANCIENT']
end

function ShowBrowseHeader()
	browseLabel.text = 'Browse Mode (12/1234)' -- Temporary
end

local function showQuestionPanel()
	local width = display.contentWidth - (4 * MARGIN)
	if CheckGrp.isVisible then
		width = width - CHECK_WIDTH
	end

	local hanjaX = (width - GRAM_WIDTH - MARGIN)/2
	--local hanjaWidth = width  - GRAM_WIDTH - 3*MARGIN
	if TeacherMode then
		hanjaX = (width - 2*GRAM_WIDTH)/2 - MARGIN
		--hanjaWidth = width  - 2* GRAM_WIDTH - 4*MARGIN
	end
	if not CheckGrp.isVisible then
		hanjaX = (width - GRAM_WIDTH - MARGIN)/2
	end
	hanjaText.x = hanjaX
	--hanjaText.width = hanjaWidth
	gramText.x = width - GRAM_WIDTH/2 - MARGIN
	wordText.x = (width - GRAM_WIDTH - MARGIN)/2
	vocalBtn.x = width - GRAM_WIDTH/2 - MARGIN
	recordBtn.x = width - GRAM_WIDTH - GRAM_WIDTH/2 - 2*MARGIN

	hanjaChkLabel.isVisible = HasAlternateTranscriptions
	hanjaChkButton.isVisible = HasAlternateTranscriptions
	hanjaText.isVisible = HasAlternateTranscriptions

end

function showTeacherMode()
	recordBtn.isVisible = TeacherMode
	ex1RecBtn.isVisible = TeacherMode
	ex2RecBtn.isVisible = TeacherMode

end

function ShowCard()
	print (Phase)
	if (Phase == 'QUESTION') then
		print 'QUESTION'
		QuestFooterGrp.isVisible = true
		AnswerFooterGrp.isVisible =false
		PreviousFooterGrp.isVisible = false
		BrowseFooterGrp.isVisible = false
		TeacherBrowseFooterGrp.isVisible = false
		TestingHeaderGrp.isVisible = true
		BrowseHeaderGrp.isVisible = false
		AnswerGrp.isVisible = false
		tr1Grp.isVisible = (Mode == 'DEF')
		tr2Grp.isVisible = (Mode == 'DEF')
		--maskAnswer.isVisible = not (Mode == 'DEF')
		CheckGrp.isVisible = not (Mode == 'DEF')

	elseif (Phase == 'ANSWER') then
		print 'ANSWER'
		QuestFooterGrp.isVisible = false
		AnswerFooterGrp.isVisible =true
		PreviousFooterGrp.isVisible = false
		BrowseFooterGrp.isVisible = false
		TeacherBrowseFooterGrp.isVisible = false
		TestingHeaderGrp.isVisible = true
		BrowseHeaderGrp.isVisible = false
		AnswerGrp.isVisible = true
		tr1Grp.isVisible = true
		tr2Grp.isVisible = true
		--maskAnswer.isVisible = false
		CheckGrp.isVisible = false

	elseif (Phase == 'PREVIOUS') then
		print 'PREVIOUS'
		QuestFooterGrp.isVisible = false
		AnswerFooterGrp.isVisible =false
		PreviousFooterGrp.isVisible = true
		BrowseFooterGrp.isVisible = false
		TeacherBrowseFooterGrp.isVisible = false
		TeacherBrowseFooterGrp.isVisible = false
		TestingHeaderGrp.isVisible = true
		BrowseHeaderGrp.isVisible = false
		AnswerGrp.isVisible = true
		tr1Grp.isVisible = true
		tr2Grp.isVisible = true
		--maskAnswer.isVisible = false
		CheckGrp.isVisible =  true -- To have the Vocal Check Button

	elseif (Phase == 'BROWSE') then
		print 'BROWSE'
		QuestFooterGrp.isVisible = false
		AnswerFooterGrp.isVisible = false
		PreviousFooterGrp.isVisible = false
		BrowseFooterGrp.isVisible = not TeacherMode
		TeacherBrowseFooterGrp.isVisible = TeacherMode
		TestingHeaderGrp.isVisible = false
		BrowseHeaderGrp.isVisible = true
		AnswerGrp.isVisible = true
		tr1Grp.isVisible = true
		tr2Grp.isVisible = true
		--maskAnswer.isVisible = false
		CheckGrp.isVisible = true -- To have the Vocal Check Button

	end



	showQuestionPanel()
	ShowScoreAverage()
	ShowStacks()
	ShowBrowseHeader()
	showTeacherMode()
end

local function onHanjaChkPressed(event)
	DgltCards.onHanjaChkPressed(event.target.isOn)
end

local function onExamplesChkPressed(event)
	DgltCards.onExamplesChkPressed(event.target.isOn)
end

local function onVocalChkPressed(event)
	DgltCards.onVocalChkPressed(event.target.isOn)
end

local function OnShowPressed()
	print (DgltCards)
	print ('local .. ' )
	DgltCards:OnShowPressed()
end

function scene:create( event )
------------------------------


	 sceneGroup = self.view

	-- Called when the scene's view does not exist.
	--
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.


	local parambtn =
	{
		id = 'myBtn',
		x = 0,
		y = 0,
		label = 'totox',
		labelAlign = 'center',
		emboss = true,
		labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
		textOnly = false,
		--defaultFile="button2.png",
		--overFile="button2-down.png",
		width = display.contentWidth/2 - 4*MARGIN,
		height = FOOTER_HEIGHT - 4* MARGIN ,
		fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } },
		--strokeColor = { default={ 0, 1, 0 }, over={ 0.4, 0.1, 0.2 } },
		--strokeWidth = FOOTER_HEIGHT - 2*MARGIN,
		shape = 'roundedRect',
		--onPress=onFirstView,
		--selected=true
	}

	local newTextParams =
	{
		text = "Average 50 %",
		x = display.contentCenterX ,
		--y = top + SCORE_HEIGHT/2,--title.y + 215,
		width = display.contentWidth,
		height = SCORE_HEIGHT,
		font = native.systemFont,
		fontSize = 12,
		align = "center"
	}

	-- create a lila background to fill screen

	local backgroundGrp = display.newGroup()
	sceneGroup:insert( backgroundGrp )
	--backgroundGrp.y =50

	local background = display.newRect( display.contentCenterX, display.contentCenterY, display.contentWidth, display.contentHeight )
	background:setFillColor( 0.5, 0.5, 1 )	-- lila
	backgroundGrp:insert( background )

	local top = 0
	if ( system.getInfo("platformName") ~= "macos") and  (system.getInfo("platformName") ~= "win32") then
		top = STATUS_HEIGHT
	end


	-- Create the Browse Header
	BrowseHeaderGrp = display.newGroup()
	backgroundGrp:insert(BrowseHeaderGrp)
	BrowseHeaderGrp.x = 0
	BrowseHeaderGrp.y =  top

	newTextParams.text = 'Browse Mode (1/1323)'
	newTextParams.x = display.contentCenterX
	newTextParams.y = top + SCORE_HEIGHT/2 + 2*STACK_HEIGHT
	newTextParams.fontSize = 16

	browseLabel = display.newText( newTextParams )
	browseLabel:setFillColor( 0 ) -- black
	BrowseHeaderGrp:insert(browseLabel)


	parambtn.id = 'Back2Btn'
	parambtn.label = 'Back'
	parambtn.onPress=DgltCards.OnBackPressed
	back2Btn = widget.newButton( parambtn )
	back2Btn.width = BTN_WIDTH
	back2Btn.height = SCORE_HEIGHT
	back2Btn.x =  BTN_WIDTH/2 + MARGIN
	back2Btn.y = top + SCORE_HEIGHT/2
	BrowseHeaderGrp:insert(back2Btn)



	-- Create the Testing Header

	TestingHeaderGrp = display.newGroup()
	backgroundGrp:insert(TestingHeaderGrp)
	TestingHeaderGrp.x = 0
	TestingHeaderGrp.y =  top

	parambtn.id = 'ScoreBtn'
	parambtn.label = 'Average 95%'
	parambtn.onPress=DgltCards.OnScoreAveragePressed
	local savColor = parambtn.fillColor
	parambtn.fillColor = { default={  0.5, 0.5, 1 }, over={ 0.7, 0.2, 0.5} }
	scoreAverageBtn = widget.newButton( parambtn )
	parambtn.fillColor = savColor
	scoreAverageBtn.width = display.contentWidth - 2*(BTN_WIDTH + 2*MARGIN)
	scoreAverageBtn.height = SCORE_HEIGHT
	scoreAverageBtn.x =  display.contentCenterX
	scoreAverageBtn.y = top + SCORE_HEIGHT/2
	TestingHeaderGrp:insert(scoreAverageBtn)

	parambtn.id = 'BackBtn'
	parambtn.label = 'Back'
	parambtn.onPress=DgltCards.OnBackPressed
	backBtn = widget.newButton( parambtn )
	backBtn.width = BTN_WIDTH
	backBtn.height = SCORE_HEIGHT
	backBtn.x =  BTN_WIDTH/2 + MARGIN
	backBtn.y = top + SCORE_HEIGHT/2
	TestingHeaderGrp:insert(backBtn)

	top = top + SCORE_HEIGHT + 2*MARGIN

	StacksGrp = display.newGroup()
	TestingHeaderGrp:insert(StacksGrp)
	StacksGrp.x = 0
	StacksGrp.y = top + STACK_HEIGHT

	Stacks1stRowGrp = display.newGroup()
	StacksGrp:insert(Stacks1stRowGrp)
	Stacks1stRowGrp.x = 0
	Stacks1stRowGrp.y = - STACK_HEIGHT/2

	Stacks2ndRowGrp = display.newGroup()
	StacksGrp:insert(Stacks2ndRowGrp)
	Stacks2ndRowGrp.x = 0
	Stacks2ndRowGrp.y = STACK_HEIGHT/2


---
	newTextParams.fontSize = 12

	newTextParams.text = 'Untested'
	newTextParams.x =  display.contentWidth/10
	newTextParams.y = 0
	newTextParams.width = display.contentWidth/5
	newTextParams.height = STACK_HEIGHT
	local untestedLabel = display.newText( newTextParams )
	Stacks1stRowGrp:insert(untestedLabel)

	newTextParams.text = 'New'
	newTextParams.x =  display.contentWidth/10 + display.contentWidth/5
	newTextParams.y = 0
	newTextParams.width = display.contentWidth/5
	newTextParams.height = STACK_HEIGHT
	local newLabel = display.newText( newTextParams )
	Stacks1stRowGrp:insert(newLabel)

	newTextParams.text = 'Recent'
	newTextParams.x =  display.contentWidth/10 + 2*display.contentWidth/5
	newTextParams.y = 0
	newTextParams.width = display.contentWidth/5
	newTextParams.height = STACK_HEIGHT
	local recentLabel = display.newText( newTextParams )
	Stacks1stRowGrp:insert(recentLabel)

	newTextParams.text = 'Older'
	newTextParams.x =  display.contentWidth/10 + 3*display.contentWidth/5
	newTextParams.y = 0
	newTextParams.width = display.contentWidth/5
	newTextParams.height = STACK_HEIGHT
	local olderLabel = display.newText( newTextParams )
	Stacks1stRowGrp:insert(olderLabel)

	newTextParams.text = 'Ancient'
	newTextParams.x =  display.contentWidth/10 + 4*display.contentWidth/5
	newTextParams.y = 0
	newTextParams.width = display.contentWidth/5
	newTextParams.height = STACK_HEIGHT
	local ancientLabel = display.newText( newTextParams )
	Stacks1stRowGrp:insert(ancientLabel)

-------

	newTextParams.text = '1000'
	newTextParams.x =  display.contentWidth/10
	newTextParams.y = 0
	newTextParams.width = display.contentWidth/5
	newTextParams.height = STACK_HEIGHT
	untestedValue = display.newText( newTextParams )
	Stacks2ndRowGrp:insert(untestedValue)

	newTextParams.text = '1500'
	newTextParams.x =  display.contentWidth/10 + display.contentWidth/5
	newTextParams.y = 0
	newTextParams.width = display.contentWidth/5
	newTextParams.height = STACK_HEIGHT
	newValue = display.newText( newTextParams )
	Stacks2ndRowGrp:insert(newValue)

	newTextParams.text = '9999'
	newTextParams.x =  display.contentWidth/10 + 2*display.contentWidth/5
	newTextParams.y = 0
	newTextParams.width = display.contentWidth/5
	newTextParams.height = STACK_HEIGHT
	recentValue = display.newText( newTextParams )
	Stacks2ndRowGrp:insert(recentValue)

	newTextParams.text = '1111'
	newTextParams.x =  display.contentWidth/10 + 3*display.contentWidth/5
	newTextParams.y = 0
	newTextParams.width = display.contentWidth/5
	newTextParams.height = STACK_HEIGHT
	olderValue = display.newText( newTextParams )
	Stacks2ndRowGrp:insert(olderValue)

	newTextParams.text = '7777'
	newTextParams.x =  display.contentWidth/10 + 4*display.contentWidth/5
	newTextParams.y = 0
	newTextParams.width = display.contentWidth/5
	newTextParams.height = STACK_HEIGHT
	ancientValue = display.newText( newTextParams )
	Stacks2ndRowGrp:insert(ancientValue)

	top = top + 2*STACK_HEIGHT + 4*MARGIN

-- Create the Question Panel
	QuestionGrp = display.newGroup()
	backgroundGrp:insert(QuestionGrp)
	QuestionGrp.x = 0
	QuestionGrp.y =  top + MARGIN

	local QuestionPanel = display.newRect( display.contentCenterX,    QUESTION_HEIGHT/2,     display.contentWidth - (2 * MARGIN),      QUESTION_HEIGHT)
	QuestionPanel:setFillColor( 0, 0, 0.3 )
	QuestionGrp:insert(QuestionPanel)

	local QuestionPanel2 = display.newRect( display.contentCenterX,    QUESTION_HEIGHT/2,     display.contentWidth - (4 * MARGIN),      QUESTION_HEIGHT - 2*MARGIN)
	QuestionPanel2:setFillColor(0.7, 0.8, 0.9  )
	QuestionGrp:insert(QuestionPanel2)

	-- Create the CheckPanel
	CheckGrp = display.newGroup()
	QuestionGrp:insert(CheckGrp)
	CheckGrp.x = display.contentWidth - CHECK_WIDTH - 2*MARGIN
	CheckGrp.y = 0




	examplesChkButton = widget.newSwitch(
    	{
	        x =CHECK_BTN_SIZE/2,
	        y = QUESTION_HEIGHT/4,
	        style = "checkbox",
	        id = "Checkbox",
	        onPress = onExamplesChkPressed,
	        width = CHECK_BTN_SIZE,
        	height = CHECK_BTN_SIZE,
	})
	CheckGrp:insert(examplesChkButton)

	vocalChkButton = widget.newSwitch(
    	{
	        x =CHECK_BTN_SIZE/2,
	        y = QUESTION_HEIGHT/2,
	        style = "checkbox",
	        id = "Checkbox",
	        onPress = onVocalChkPressed,
	        width = CHECK_BTN_SIZE,
        	height = CHECK_BTN_SIZE,
	})
	CheckGrp:insert(vocalChkButton)

	hanjaChkButton = widget.newSwitch(
    	{
	        x = CHECK_BTN_SIZE/2,
	        y = QUESTION_HEIGHT * 3/4,
	        style = "checkbox",
	        id = "Checkbox",
	        onPress = onHanjaChkPressed,
	        width = CHECK_BTN_SIZE,
        	height = CHECK_BTN_SIZE,
        	label = 'Toto',
        	defaultFile = "button1.png",
        	overFile = "button1-down.png",
	})
	CheckGrp:insert(hanjaChkButton)



	local examplesChkLabel = display.newText(
	{
		text = 'Ex.',
		align = 'left',
		x = CHECK_BTN_SIZE + (CHECK_WIDTH - CHECK_BTN_SIZE)/2 + MARGIN,
		y = QUESTION_HEIGHT/4,
		width = CHECK_WIDTH - CHECK_BTN_SIZE,
		height = CHECK_BTN_SIZE,
		font = native.systemFont,
		fontSize = 13,

	})
	examplesChkLabel:setFillColor( 0 ) -- black
	CheckGrp:insert(examplesChkLabel)

	local vocalChkLabel = display.newText(
	{
		text = 'Vocal',
		align = 'left',
		x = CHECK_BTN_SIZE + (CHECK_WIDTH - CHECK_BTN_SIZE)/2 + MARGIN,
		y = QUESTION_HEIGHT/2,
		width = CHECK_WIDTH - CHECK_BTN_SIZE,
		height = CHECK_BTN_SIZE,
		font = native.systemFont,
		fontSize = 13,

	})
	vocalChkLabel:setFillColor( 0 ) -- black
	CheckGrp:insert(vocalChkLabel)

	hanjaChkLabel = display.newText(
	{
		text = AlternateTranscription,
		align = 'left',
		x = CHECK_BTN_SIZE + (CHECK_WIDTH - CHECK_BTN_SIZE)/2 + MARGIN,
		y = QUESTION_HEIGHT * 3/4,
		width = CHECK_WIDTH - CHECK_BTN_SIZE,
		height = CHECK_BTN_SIZE,
		font = native.systemFont,
		fontSize = 13,

	})
	hanjaChkLabel:setFillColor( 0 ) -- black
	CheckGrp:insert(hanjaChkLabel)



	QuestionGrp2 = display.newGroup()
	QuestionGrp:insert(QuestionGrp2)
	QuestionGrp2.x = 2*MARGIN
	QuestionGrp2.y =   QUESTION_HEIGHT/2

	local width = display.contentWidth - (4 * MARGIN) - CHECK_WIDTH



	gramText = widget.newButton(
	{
		label = 'Gram',
		id = 'GramText',
		x = width - GRAM_WIDTH/2 - MARGIN,
		y = - QUESTION_HEIGHT/4 + MARGIN,
		onPress = DgltCards.OnGramPressed,
		width = GRAM_WIDTH,
		height = QUESTION_HEIGHT /2 - 3*MARGIN,
		fillColor = { default={1, 1,1 }, over={ 1, 0.2, 0.5, 1 } },
		labelAlign = 'center',
		fontSize = 11,
		emboss = true,
		labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
		textOnly = false,
		shape = 'rect',
	})
	QuestionGrp2:insert(gramText)




	wordText = widget.newButton(
	{
		label = 'Korean',
		id = 'KoreanText',
		x = (width - GRAM_WIDTH - MARGIN)/2,
		y =   - QUESTION_HEIGHT/4 + MARGIN,
		onPress = DgltCards.OnWordTextPressed,
		width =  width  - GRAM_WIDTH - 3*MARGIN ,
		height = QUESTION_HEIGHT /2 - 3*MARGIN,
		fillColor = { default={1, 1,1 }, over={ 1, 0.2, 0.5, 1 } },
		labelAlign = 'center',
		emboss = true,
		labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
		textOnly = false,
		fontSize = 20,
		shape = 'rect',
	})
	QuestionGrp2:insert(wordText)





	vocalBtn = widget.newButton(
	{
		label = 'Play',
		id = 'PlayBtn',
		x = width - GRAM_WIDTH/2 - MARGIN,
		y = QUESTION_HEIGHT/4 - MARGIN,
		onPress = DgltCards.OnVocalPressed,
		width = GRAM_WIDTH,
		height = QUESTION_HEIGHT /2 - 3*MARGIN,
		fillColor = { default={0.7, 0.8, 0.6 }, over={ 1, 0.2, 0.5, 1 } },
		labelAlign = 'center',
		emboss = true,
		labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
		textOnly = false,
		shape = 'roundedRect',
	})
	QuestionGrp2:insert(vocalBtn)



	recordBtn = widget.newButton(
	{
		label = 'Rec.',
		id = 'RecBtn',
		x = width - GRAM_WIDTH - GRAM_WIDTH/2 - 2*MARGIN,
		y = QUESTION_HEIGHT/4 - MARGIN,
		onPress = DgltCards.OnRecordPressed,
		width = GRAM_WIDTH,
		height = QUESTION_HEIGHT /2 - 3*MARGIN,
		fillColor = { default={0.7, 0.8, 0.6 }, over={ 1, 0.2, 0.5, 1 } },
		labelAlign = 'center',
		emboss = true,
		labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
		textOnly = false,
		shape = 'roundedRect',
	})
	QuestionGrp2:insert(recordBtn)



	local hanjaX = (width - 2*GRAM_WIDTH)/2 - MARGIN
	local hanjaWidth = width  - 2* GRAM_WIDTH - 4*MARGIN

	hanjaText = widget.newButton(
	{
		label = 'Hanja',
		id = 'hanjaText',
		x = hanjaX,
		y =   QUESTION_HEIGHT/4 - MARGIN,
		onPress = DgltCards.OnHanjaTextPressed,
		width =  hanjaWidth ,
		height = QUESTION_HEIGHT /2 - 3*MARGIN,
		fillColor = { default={1, 1,1 }, over={ 1, 0.2, 0.5, 1 } },
		labelAlign = 'center',
		emboss = true,
		labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
		textOnly = false,
		fontSize = 20,
		shape = 'rect',
	})
	QuestionGrp2:insert(hanjaText)

	top = top + QUESTION_HEIGHT + 2*MARGIN

-- Create the First Example Panel

	ExampleGrp = display.newGroup()
	backgroundGrp:insert(ExampleGrp)
	ExampleGrp.x = 0
	ExampleGrp.y =  top + MARGIN

	local ExamplePanel = display.newRect( display.contentCenterX,    EXAMPLE_HEIGHT/2,     display.contentWidth - (2 * MARGIN),      EXAMPLE_HEIGHT)
	ExamplePanel:setFillColor( 0, 0, 0.3 )
	ExampleGrp:insert(ExamplePanel)

	local ExamplePanel2 = display.newRect( display.contentCenterX,    EXAMPLE_HEIGHT/2,     display.contentWidth - (4 * MARGIN),      EXAMPLE_HEIGHT - 2*MARGIN)
	ExamplePanel2:setFillColor(0.7, 0.8, 0.9  )
	ExampleGrp:insert(ExamplePanel2)

	ex1VocalBtn = widget.newButton(
	{
		label = 'Play',
		id = 'Ex1PlayBtn',
		x = display.contentWidth  - GRAM_WIDTH/2 - 3*MARGIN,
		y =  8* MARGIN,
		onPress = DgltCards.OnVocalPressed,
		width = GRAM_WIDTH,
		height = GRAM_WIDTH  - 3*MARGIN,
		fillColor = { default={0.7, 0.8, 0.6 }, over={ 1, 0.2, 0.5, 1 } },
		labelAlign = 'center',
		emboss = true,
		labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
		textOnly = false,
		shape = 'roundedRect',
	})
	ExampleGrp:insert(ex1VocalBtn)

	ex1RecBtn = widget.newButton(
	{
		label = 'Rec.',
		id = 'Ex1PlayBtn',
		x = display.contentWidth  - GRAM_WIDTH/2 - 3*MARGIN,
		y =  GRAM_WIDTH + 6* MARGIN,
		onPress = DgltCards.OnVocalPressed,
		width = GRAM_WIDTH,
		height = GRAM_WIDTH  - 3*MARGIN,
		fillColor = { default={0.7, 0.8, 0.6 }, over={ 1, 0.2, 0.5, 1 } },
		labelAlign = 'center',
		emboss = true,
		labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
		textOnly = false,
		shape = 'roundedRect',
	})
	ExampleGrp:insert(ex1RecBtn)

	ex1Grp = display.newGroup()
	ExampleGrp:insert(ex1Grp)
	ex1Grp.x = (display.contentWidth - GRAM_WIDTH - MARGIN)/2
	ex1Grp.y = 0

	tr1Grp = display.newGroup()
	ExampleGrp:insert(tr1Grp)
	tr1Grp.x = (display.contentWidth - GRAM_WIDTH - MARGIN)/2
	tr1Grp.y = 0


	ex1Panel = display.newRect( 0,    8* MARGIN,     display.contentWidth - GRAM_WIDTH- (7* MARGIN),      EXAMPLE_HEIGHT/2 - 2*MARGIN)
	ex1Panel:setFillColor(1, 1, 1)
	ex1Grp:insert(ex1Panel)

	tr1Panel = display.newRect( 0 ,   EXAMPLE_HEIGHT/2 + 6* MARGIN,     display.contentWidth - GRAM_WIDTH- (7* MARGIN),      EXAMPLE_HEIGHT/2 - 3* MARGIN)
	tr1Panel:setFillColor(1, 1, 1)
	tr1Grp:insert(tr1Panel)

--

	ex1Text = display.newText(
	{
		text = 'Le premier exemple en Korean\n...et en plus sur 2 lignes',
		align = 'center',
		x = MARGIN,
		y =8* MARGIN,
		width = display.contentWidth - GRAM_WIDTH- (7* MARGIN),
		height =  EXAMPLE_HEIGHT/2 - 2*MARGIN,
		font = native.systemFont,
		fontSize = 14,

	})
	ex1Grp:insert(ex1Text)
	ex1Text:setFillColor( 0 ) -- black

	tr1Text = display.newText(
	{
		text = 'La premiere traduction\n...et toujours sur 2 lignes',
		align = 'center',
		x = MARGIN,
		y = EXAMPLE_HEIGHT/2 + 6* MARGIN,
		width = display.contentWidth - GRAM_WIDTH- (7* MARGIN),
		height =  EXAMPLE_HEIGHT/2 - 2*MARGIN,
		font = native.systemFont,
		fontSize = 14,

	})
	tr1Grp:insert(tr1Text)
	tr1Text:setFillColor( 0 ) -- black

	top = top + EXAMPLE_HEIGHT - MARGIN


-- Create the Second Example Panel

	Example2Grp = display.newGroup()
	backgroundGrp:insert(Example2Grp)
	Example2Grp.x = 0
	Example2Grp.y =  top + MARGIN

	local Example2Panel = display.newRect( display.contentCenterX,    EXAMPLE_HEIGHT/2,     display.contentWidth - (2 * MARGIN),      EXAMPLE_HEIGHT)
	Example2Panel:setFillColor( 0, 0, 0.3 )
	Example2Grp:insert(Example2Panel)

	local Example2Panel2 = display.newRect( display.contentCenterX,    EXAMPLE_HEIGHT/2,     display.contentWidth - (4 * MARGIN),      EXAMPLE_HEIGHT - 2*MARGIN)
	Example2Panel2:setFillColor(0.7, 0.8, 0.9  )
	Example2Grp:insert(Example2Panel2)


	ex2Grp = display.newGroup()
	Example2Grp:insert(ex2Grp)
	ex2Grp.x =  (display.contentWidth - GRAM_WIDTH - MARGIN)/2
	ex2Grp.y = 0

	tr2Grp = display.newGroup()
	Example2Grp:insert(tr2Grp)
	tr2Grp.x = (display.contentWidth - GRAM_WIDTH - MARGIN)/2
	tr2Grp.y = 0


	ex2Panel = display.newRect(0,    8* MARGIN,     display.contentWidth - GRAM_WIDTH- (7* MARGIN),      EXAMPLE_HEIGHT/2 - 2*MARGIN)
	ex2Panel:setFillColor(1, 1, 1)
	ex2Grp:insert(ex2Panel)

	tr2Panel = display.newRect( 0 ,   EXAMPLE_HEIGHT/2 + 6* MARGIN,     display.contentWidth - GRAM_WIDTH- (7* MARGIN),      EXAMPLE_HEIGHT/2 - 3* MARGIN)
	tr2Panel:setFillColor(1, 1, 1)
	tr2Grp:insert(tr2Panel)




	ex2Text = display.newText(
	{
		text = 'Le deuxieme exemple en Korean\n...et en plus sur 2 lignes!',
		align = 'center',
		x = MARGIN,
		y =8* MARGIN,
		width = display.contentWidth - GRAM_WIDTH- (7* MARGIN),
		height =  EXAMPLE_HEIGHT/2 - 2*MARGIN,
		font = native.systemFont,
		fontSize = 14,

	})
	ex2Grp:insert(ex2Text)
	ex2Text:setFillColor( 0 ) -- black

	tr2Text = display.newText(
	{
		text = 'La deuxieme traduction\n...et toujours sur 2 lignes!',
		align = 'center',
		x = MARGIN,
		y = EXAMPLE_HEIGHT/2 + 6* MARGIN,
		width = display.contentWidth - GRAM_WIDTH- (7* MARGIN),
		height =  EXAMPLE_HEIGHT/2 - 2*MARGIN,
		font = native.systemFont,
		fontSize = 14,

	})
	tr2Grp:insert(tr2Text)
	tr2Text:setFillColor( 0 ) -- black






	top = top + EXAMPLE_HEIGHT + 2*MARGIN


	ex2VocalBtn = widget.newButton(
	{
		label = 'Play',
		id = 'Ex1PlayBtn',
		x = display.contentWidth  - GRAM_WIDTH/2 - 3*MARGIN,
		y =  8* MARGIN,
		onPress = DgltCards.OnVocalPressed,
		width = GRAM_WIDTH,
		height = GRAM_WIDTH  - 3*MARGIN,
		fillColor = { default={0.7, 0.8, 0.6 }, over={ 1, 0.2, 0.5, 1 } },
		labelAlign = 'center',
		emboss = true,
		labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
		textOnly = false,
		shape = 'roundedRect',
	})
	Example2Grp:insert(ex2VocalBtn)

	ex2RecBtn = widget.newButton(
	{
		label = 'Rec.',
		id = 'Ex1PlayBtn',
		x = display.contentWidth  - GRAM_WIDTH/2 - 3*MARGIN,
		y =  GRAM_WIDTH + 6* MARGIN,
		onPress = DgltCards.OnVocalPressed,
		width = GRAM_WIDTH,
		height = GRAM_WIDTH  - 3*MARGIN,
		fillColor = { default={0.7, 0.8, 0.6 }, over={ 1, 0.2, 0.5, 1 } },
		labelAlign = 'center',
		emboss = true,
		labelColor = { default={ 0, 0.2, 0.1 }, over={ 0, 0, 0, 0.5 } },
		textOnly = false,
		shape = 'roundedRect',
	})
	Example2Grp:insert(ex2RecBtn)



-- Create the Answer Mask panel

	--maskAnswer = display.newRect( display.contentCenterX,    ANSWER_HEIGHT/2,     display.contentWidth - (2 * MARGIN),      ANSWER_HEIGHT)
	--maskAnswer:setFillColor( 0.5, 0.5, 1 )	-- lila
	--backgroundGrp:insert(maskAnswer)


-- Create the Answer Panel

	AnswerGrp = display.newGroup()
	backgroundGrp:insert(AnswerGrp)
	AnswerGrp.x = 0
	AnswerGrp.y =  top + MARGIN

	local AnserPanel = display.newRect( display.contentCenterX,    ANSWER_HEIGHT/2,     display.contentWidth - (2 * MARGIN),      ANSWER_HEIGHT)
	AnserPanel:setFillColor( 0, 0, 0.3 )
	AnswerGrp:insert(AnserPanel)

	local AnserPanel2 = display.newRect( display.contentCenterX,    ANSWER_HEIGHT/2,     display.contentWidth - (4 * MARGIN),      ANSWER_HEIGHT - 2*MARGIN)
	AnserPanel2:setFillColor(0.7, 0.8, 0.9  )
	AnswerGrp:insert(AnserPanel2)

	top = top + EXAMPLE_HEIGHT - MARGIN



-- Create the QuestionFooter
	QuestFooterGrp = display.newGroup()
	backgroundGrp:insert(QuestFooterGrp)
	QuestFooterGrp.x = 0
	QuestFooterGrp.y =  display.contentHeight  - (FOOTER_HEIGHT /2 )
	local QuestFooterPanel = display.newRect( display.contentCenterX, 0, display.contentWidth - (2 * MARGIN), FOOTER_HEIGHT - 2 * MARGIN)
	QuestFooterPanel:setFillColor( 0, 0, 0.3 )
	QuestFooterGrp:insert(QuestFooterPanel)


	parambtn.id = 'PreviousBtn'
	parambtn.label = 'Previous'
	parambtn.x =  display.contentWidth/4
	parambtn.onPress=DgltCards.OnPreviousPressed
	local previousBtn = widget.newButton( parambtn )
	QuestFooterGrp:insert(previousBtn)


	parambtn.id = 'ShowAnswerBtn'
	parambtn.label = 'Show Answer'
	parambtn.x =  display.contentWidth*3/4
	parambtn.onPress=OnShowPressed
	local showAnswerBtn = widget.newButton( parambtn )
	QuestFooterGrp:insert(showAnswerBtn)




-- Create the AnswerFooter
	AnswerFooterGrp = display.newGroup()
	backgroundGrp:insert(AnswerFooterGrp)
	AnswerFooterGrp.x = 0
	AnswerFooterGrp.y =  display.contentHeight  - (FOOTER_HEIGHT /2 )
	local AnswerFooterPanel = display.newRect( display.contentCenterX, 0, display.contentWidth - (2 * MARGIN), FOOTER_HEIGHT - 2 * MARGIN)
	AnswerFooterPanel:setFillColor( 0, 0, 0.3 )
	AnswerFooterGrp:insert(AnswerFooterPanel)

	parambtn.id = 'WrongBtn'
	parambtn.label = 'Wrong'
	parambtn.x =  display.contentWidth/6
	parambtn.onPress=DgltCards.OnWrongPressed
	parambtn.width = display.contentWidth/3 - 4*MARGIN
	parambtn.fillColor = { default={1, 0.2, 0.2  }, over={ 1, 0.2, 0.5, 1 } }
	local wrongBtn = widget.newButton( parambtn )
	AnswerFooterGrp:insert(wrongBtn)


	parambtn.id = 'TagBtn'
	parambtn.label = 'Tag'
	parambtn.x =  display.contentWidth*3/6
	parambtn.onPress=DgltCards.OnTagPressed
	parambtn.width = display.contentWidth/3
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local tagBtn = widget.newButton( parambtn )
	AnswerFooterGrp:insert(tagBtn)

	parambtn.id = 'RightBtn'
	parambtn.label = 'Right'
	parambtn.x =  display.contentWidth*5/6
	parambtn.onPress=DgltCards.OnRightPressed
	parambtn.width = display.contentWidth/3 - 4*MARGIN
	parambtn.fillColor = { default={0.2, 1, 0.2  }, over={ 1, 0.2, 0.5, 1 } }
	local rightBtn = widget.newButton( parambtn )
	AnswerFooterGrp:insert(rightBtn)



-- Create the PreviousFooter
	PreviousFooterGrp = display.newGroup()
	backgroundGrp:insert(PreviousFooterGrp)

	PreviousFooterGrp.x = 0
	PreviousFooterGrp.y =  display.contentHeight  - (FOOTER_HEIGHT /2 )
	local PreviousFooterPanel = display.newRect( display.contentCenterX, 0, display.contentWidth - (2 * MARGIN), FOOTER_HEIGHT - 2 * MARGIN)
	PreviousFooterPanel:setFillColor( 0, 0, 0.3  )
	PreviousFooterGrp:insert(PreviousFooterPanel)


	parambtn.id = 'WrongBtn'
	parambtn.label = 'Wrong'
	parambtn.x =  display.contentWidth/6
	parambtn.onPress=DgltCards.OnWrongPressed
	parambtn.width = display.contentWidth/3 - 4*MARGIN
	parambtn.fillColor = { default={1, 0.2, 0.2  }, over={ 1, 0.2, 0.5, 1 } }
	local wrongBtn = widget.newButton( parambtn )
	PreviousFooterGrp:insert(wrongBtn)


	parambtn.id = 'TagBtn'
	parambtn.label = 'Tag'
	parambtn.x =  display.contentWidth*3/6
	parambtn.onPress=DgltCards.OnTagPressed
	parambtn.width = display.contentWidth/9
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local tagBtn = widget.newButton( parambtn )
	PreviousFooterGrp:insert(tagBtn)

	parambtn.id = 'RightBtn'
	parambtn.label = 'Right'
	parambtn.x =  display.contentWidth*5/6
	parambtn.onPress=DgltCards.OnRightPressed
	parambtn.width = display.contentWidth/3 - 4*MARGIN
	parambtn.fillColor = { default={0.2, 1, 0.2  }, over={ 1, 0.2, 0.5, 1 } }
	local rightBtn = widget.newButton( parambtn )
	PreviousFooterGrp:insert(rightBtn)

	parambtn.id = 'GoLeftBtn'
	parambtn.label = '<'
	parambtn.x =  display.contentWidth*(7/18) - MARGIN
	parambtn.onPress=DgltCards.OnGoLeftPressed
	parambtn.width = display.contentWidth/9
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local goLeftBtn = widget.newButton( parambtn )
	PreviousFooterGrp:insert(goLeftBtn)

	parambtn.id = 'GoRightBtn'
	parambtn.label = '>'
	parambtn.x =  display.contentWidth*(11/18) + MARGIN
	parambtn.onPress=DgltCards.OnGoRightPressed
	parambtn.width = display.contentWidth/9
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local GoRightBtn = widget.newButton( parambtn )
	PreviousFooterGrp:insert(GoRightBtn)


	-- Create the two BrowseFooters for regular student
	local totalWidth = display.contentWidth - 4 * MARGIN



	BrowseFooterGrp= display.newGroup()
	backgroundGrp:insert(BrowseFooterGrp)

	BrowseFooterGrp.x = MARGIN/2
	BrowseFooterGrp.y =  display.contentHeight  - (FOOTER_HEIGHT ) + 2 * MARGIN - MARGIN/2
	local BrowseFooterPanel = display.newRect( display.contentCenterX - MARGIN/2, 0,     display.contentWidth - (2 * MARGIN),     2 * FOOTER_HEIGHT - 5 * MARGIN)
	BrowseFooterPanel:setFillColor( 0, 0, 0.3 )
	BrowseFooterGrp:insert(BrowseFooterPanel)


	Browse1FooterGrp= display.newGroup()
	Browse1FooterGrp.x = MARGIN + MARGIN/2 -- Hack ?
	Browse1FooterGrp.y =  (-FOOTER_HEIGHT /2 + MARGIN + MARGIN/2) -- Hack ?
	BrowseFooterGrp:insert(Browse1FooterGrp)

	Browse2FooterGrp= display.newGroup()
	Browse2FooterGrp.x =  MARGIN + MARGIN/2 -- Hack ?
	Browse2FooterGrp.y =    (FOOTER_HEIGHT /2 - MARGIN - MARGIN/2)
	BrowseFooterGrp:insert(Browse2FooterGrp)


	parambtn.id = 'FirstBtn'
	parambtn.label = '<<'
	parambtn.x =  totalWidth/8
	parambtn.onPress=DgltCards.OnFirstPressed
	parambtn.width = totalWidth/4 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local firstBtn = widget.newButton( parambtn )
	Browse1FooterGrp:insert(firstBtn)

	parambtn.id = 'M50'
	parambtn.label = '-50'
	parambtn.x =  totalWidth/8 + totalWidth/4
	parambtn.onPress=DgltCards.OnM50Pressed
	parambtn.width = totalWidth/4 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local m50Btn = widget.newButton( parambtn )
	Browse1FooterGrp:insert(m50Btn)

	parambtn.id = 'P50'
	parambtn.label = '+50'
	parambtn.x =  totalWidth/8 + 2*totalWidth/4
	parambtn.onPress=DgltCards.OnP50Pressed
	parambtn.width = totalWidth/4 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local p50Btn = widget.newButton( parambtn )
	Browse1FooterGrp:insert(p50Btn)

	parambtn.id = 'Last'
	parambtn.label = '>>'
	parambtn.x =  totalWidth/8 + 3*totalWidth/4
	parambtn.onPress=DgltCards.OnLastPressed
	parambtn.width = totalWidth/4 -  MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local lastBtn = widget.newButton( parambtn )
	Browse1FooterGrp:insert(lastBtn)

	--

	parambtn.id = 'GotoLeft2'
	parambtn.label = '<'
	parambtn.x =  totalWidth/8
	parambtn.onPress=DgltCards.OnGoLeftPressed
	parambtn.width = totalWidth/4 -  MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local gotoLeft2Btn = widget.newButton( parambtn )
	Browse2FooterGrp:insert(gotoLeft2Btn)

	parambtn.id = 'Lookup'
	parambtn.label = '!'
	parambtn.x =  totalWidth/8 + totalWidth/4
	parambtn.onPress=DgltCards.OnLookupPressed
	parambtn.width = totalWidth/4 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local lookupBtn = widget.newButton( parambtn )
	Browse2FooterGrp:insert(lookupBtn)

	parambtn.id = 'TagBtn2'
	parambtn.label = 'Tag'
	parambtn.x =  totalWidth/8 + 2*totalWidth/4
	parambtn.onPress=DgltCards.OnTagPressed
	parambtn.width = totalWidth/4 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local tag2Btn = widget.newButton( parambtn )
	Browse2FooterGrp:insert(tag2Btn)

	parambtn.id = 'GotoRight2'
	parambtn.label = '>'
	parambtn.x =  totalWidth/8 + 3*totalWidth/4
	parambtn.onPress=DgltCards.OnGotoRightPressed
	parambtn.width = totalWidth/4 -  MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local gotoRight2Btn = widget.newButton( parambtn )
	Browse2FooterGrp:insert(gotoRight2Btn)



	-- Create the two BrowseFooters for Teacher
	TeacherBrowseFooterGrp = display.newGroup()
	backgroundGrp:insert(TeacherBrowseFooterGrp)

	TeacherBrowseFooterGrp.x = MARGIN/2
	TeacherBrowseFooterGrp.y =  display.contentHeight  - (FOOTER_HEIGHT ) + 2 * MARGIN - MARGIN/2
	local TeacherBrowseFooterPanel = display.newRect( display.contentCenterX - MARGIN/2, 0,     display.contentWidth - (2 * MARGIN),     2 * FOOTER_HEIGHT - 5 * MARGIN)
	TeacherBrowseFooterPanel:setFillColor( 0, 0, 0.3 )
	TeacherBrowseFooterGrp:insert(TeacherBrowseFooterPanel)

	TeacherBrowse1FooterGrp= display.newGroup()
	TeacherBrowse1FooterGrp.x = MARGIN + MARGIN/2 -- Hack ?
	TeacherBrowse1FooterGrp.y =  (-FOOTER_HEIGHT /2 + MARGIN + MARGIN/2) -- Hack ?
	TeacherBrowseFooterGrp:insert(TeacherBrowse1FooterGrp)

	TeacherBrowse2FooterGrp= display.newGroup()
	TeacherBrowse2FooterGrp.x =  MARGIN + MARGIN/2 -- Hack ?
	TeacherBrowse2FooterGrp.y =    (FOOTER_HEIGHT /2 - MARGIN - MARGIN/2)
	TeacherBrowseFooterGrp:insert(TeacherBrowse2FooterGrp)

	parambtn.id = 'AddBtn'
	parambtn.label = '+'
	parambtn.x =  totalWidth/10
	parambtn.onPress=DgltCards.OnAddPressed
	parambtn.width = totalWidth/5 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local firstBtn = widget.newButton( parambtn )
	TeacherBrowse1FooterGrp:insert(firstBtn)

	parambtn.id = 'FirstBtn'
	parambtn.label = '<<'
	parambtn.x =  totalWidth/10+ totalWidth/5
	parambtn.onPress=DgltCards.OnFirstPressed
	parambtn.width = totalWidth/5 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local firstBtn = widget.newButton( parambtn )
	TeacherBrowse1FooterGrp:insert(firstBtn)

	parambtn.id = 'M50'
	parambtn.label = '-50'
	parambtn.x =  totalWidth/10 + 2*totalWidth/5
	parambtn.onPress=DgltCards.OnM50Pressed
	parambtn.width = totalWidth/5 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local m50Btn = widget.newButton( parambtn )
	TeacherBrowse1FooterGrp:insert(m50Btn)

	parambtn.id = 'P50'
	parambtn.label = '+50'
	parambtn.x =  totalWidth/10 + 3*totalWidth/5
	parambtn.onPress=DgltCards.OnP50Pressed
	parambtn.width = totalWidth/5 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local p50Btn = widget.newButton( parambtn )
	TeacherBrowse1FooterGrp:insert(p50Btn)

	parambtn.id = 'Last'
	parambtn.label = '>>'
	parambtn.x =  totalWidth/10 + 4*totalWidth/5
	parambtn.onPress=DgltCards.OnLastPressed
	parambtn.width = totalWidth/5 -  MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local lastBtn = widget.newButton( parambtn )
	TeacherBrowse1FooterGrp:insert(lastBtn)

	--

	parambtn.id = 'SubBtn'
	parambtn.label = '-'
	parambtn.x =  totalWidth/10
	parambtn.onPress=DgltCards.OnSubPressed
	parambtn.width = totalWidth/5 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local subBtn = widget.newButton( parambtn )
	TeacherBrowse2FooterGrp:insert(subBtn)

	parambtn.id = 'GotoLeft2'
	parambtn.label = '<'
	parambtn.x =  totalWidth/10 + totalWidth/5
	parambtn.onPress=DgltCards.OnGoLeftPressed
	parambtn.width = totalWidth/5 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local gotoLeft2Btn = widget.newButton( parambtn )
	TeacherBrowse2FooterGrp:insert(gotoLeft2Btn)

	parambtn.id = 'Lookup'
	parambtn.label = '!'
	parambtn.x =  totalWidth/10 + 2*totalWidth/5
	parambtn.onPress=DgltCards.OnLookupPressed
	parambtn.width = totalWidth/5 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local lookupBtn = widget.newButton( parambtn )
	TeacherBrowse2FooterGrp:insert(lookupBtn)

	parambtn.id = 'TagBtn2'
	parambtn.label = 'Tag'
	parambtn.x =  totalWidth/10 + 3*totalWidth/5
	parambtn.onPress=DgltCards.OnTagPressed
	parambtn.width = totalWidth/5 - MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local tag2Btn = widget.newButton( parambtn )
	TeacherBrowse2FooterGrp:insert(tag2Btn)

	parambtn.id = 'GotoRight2'
	parambtn.label = '>'
	parambtn.x =  totalWidth/10 + 4*totalWidth/5
	parambtn.onPress=DgltCards.OnGotoRightPressed
	parambtn.width = totalWidth/5 -  MARGIN
	parambtn.fillColor = { default={0.7, 0.8, 0.6  }, over={ 1, 0.2, 0.5, 1 } }
	local gotoRight2Btn = widget.newButton( parambtn )
	TeacherBrowse2FooterGrp:insert(gotoRight2Btn)


	DgltCards:OnCreate()
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase

	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
		DgltCards:OnWillShow()
	elseif phase == "did" then
		DgltCards:OnShown()
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
		DgltCards:OnWillHide()
	elseif phase == "did" then
		-- Called when the scene is now off screen
		DgltCards:OnHidden()
	end
end

function scene:destroy( event )
	local sceneGroup = self.view

	-- Called prior to the removal of scene's "view" (sceneGroup)
	--
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	DgltCards:OnDestroy()
end


---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

print ('display.contentWidth : ' .. display.contentWidth)
print ('display.contentHeight : ' .. display.contentHeight)
print ('display.actualContentWidth : ' .. display.actualContentWidth)
print ('display.actualContentHeight : ' .. display.actualContentHeight)
-----------------------------------------------------------------------------------------

return scene
