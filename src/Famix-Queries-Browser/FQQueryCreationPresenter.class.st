Class {
	#name : #FQQueryCreationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#queryConfigurationPresenter',
		'#queryCode',
		'#queryTypesDropList',
		'#resultList',
		'#toolBar',
		'#browser',
		'#sequence',
		'#query => SpObservableSlot'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #commands }
FQQueryCreationPresenter class >> buildCommandsGroupWith: presenter forRoot: aCmCommandsGroup [
	aCmCommandsGroup
		register:
			((FQQueryCreationCommand forSpecWithIconNamed: #glamorousGo)
				context: presenter).
]

{ #category : #specs }
FQQueryCreationPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #toolBar height: self toolbarHeight;
		add: #sequence height: self toolbarHeight;
		add:
			(SpPanedLayout newHorizontal
				add: self queryConfigurationLayout;
				position: 65 percent;
				add: #resultList;
				yourself);
		yourself
]

{ #category : #specs }
FQQueryCreationPresenter class >> queryConfigurationHeight [
	"If this is changed, FQQueryConfigurationPresenter>>paddingAroundButton should also be changed."

	"(Padding around button = 50) * 2 + (button height = 29, see SpAbstractPresenter>>buttonHeight)"

	^ 129
]

{ #category : #specs }
FQQueryCreationPresenter class >> queryConfigurationLayout [
	^ SpBoxLayout newVertical
		add: #queryTypesDropList height: self buttonHeight;
		add: #queryConfigurationPresenter
			height: self queryConfigurationHeight;
		add: #queryCode;
		yourself
]

{ #category : #'query configuration presenters' }
FQQueryCreationPresenter class >> queryConfigurationPresenters [
	^ FQQueryConfigurationPresenter allSubclasses
]

{ #category : #specs }
FQQueryCreationPresenter class >> title [
	^ 'Query Creation'
]

{ #category : #accessing }
FQQueryCreationPresenter >> browser [
	self
		flag:
			#FQImprove
				, 'Used ony by FQCreationCommand. Should be moved to tests package'.
	^ browser
]

{ #category : #initialization }
FQQueryCreationPresenter >> connectPresenters [
	self queryAcceptedPort transmitTo: browser queryInputPort
]

{ #category : #accessing }
FQQueryCreationPresenter >> entities [
	^ browser entities
]

{ #category : #initialization }
FQQueryCreationPresenter >> initialize [
	super initialize.
	queryTypesDropList
		selectItem: self class queryConfigurationPresenters first
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializePresenters [
	self initializeToolBar.
	self initializeRoassalSequence.
	self initializeQueryTypesDropList.
	self initializeQueryCode.
	self initializeResultList
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeQueryCode [
	queryCode := self newCode
		whenSubmitDo: [ :code | self updateForAcceptedCode: code ];
		withoutSyntaxHighlight;
		yourself
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeQueryTypesDropList [
	queryTypesDropList := self newDropList
		items: self class queryConfigurationPresenters;
		display: [ :presenterClass | presenterClass label ];
		whenSelectedItemChangedDo:
				[ :presenterClass | self updateConfigurationPresenter: presenterClass ]
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeResultList [
	resultList := (self instantiate: FQResultTreePresenter on: browser)
		updateForEntities: browser entities;
		yourself
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeRoassalSequence [
	sequence := (FQRoassalSequence
		on: browser selectedQuery parentSequence)
		shapeColor: [ :model | model class color ];
		shapeLabel: [ :model | model name substrings first ]
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeToolBar [
	toolBar := self newToolBar	"beText"
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 550 @ 400
]

{ #category : #transmissions }
FQQueryCreationPresenter >> notifyAcceptedQuery [
	browser selectedQuery addChild: self query.
	self notifyPropertyChanged: #query
]

{ #category : #accessing }
FQQueryCreationPresenter >> query [
	^ queryConfigurationPresenter query
]

{ #category : #transmissions }
FQQueryCreationPresenter >> queryAcceptedPort [
	^ FQQueryOutputPort newPresenter: self
]

{ #category : #accessing }
FQQueryCreationPresenter >> queryBuilder [
	^ queryConfigurationPresenter queryBuilder
]

{ #category : #transmissions }
FQQueryCreationPresenter >> queryChangedPort [
	^ FQQueryInputPort newPresenter: self
]

{ #category : #'accessing model' }
FQQueryCreationPresenter >> setModelBeforeInitialization: aQueriesPresenter [
	browser := aQueriesPresenter
]

{ #category : #update }
FQQueryCreationPresenter >> updateConfigurationPresenter: aPresenterClass [
	queryConfigurationPresenter := aPresenterClass
		owner: self
		on: browser selectedQuery.
	queryConfigurationPresenter queryChangedPort
		transmitTo: self queryChangedPort.
	queryConfigurationPresenter transmitInitialConfiguration
]

{ #category : #update }
FQQueryCreationPresenter >> updateForAcceptedCode: code [
	queryConfigurationPresenter updateForQueryCode: code.
	queryCode
		text: queryConfigurationPresenter queryBuilder codeToDisplay.
	self
		flag:
			#FQSpecPb
				,
					'This should go through transmissions but TextChangedPort is buggy in Spec for now.'
]

{ #category : #update }
FQQueryCreationPresenter >> updateForQuery: aQuery [
	resultList updateForEntities: aQuery result.
	queryCode
		syntaxHighlight: aQuery isValid;
		text: queryConfigurationPresenter queryBuilder codeToDisplay.
	sequence setModels: aQuery parentSequence.
	self flag: #FQImprove , 'Use transmission ?'.
	self updateToolBar.
	self update
]

{ #category : #update }
FQQueryCreationPresenter >> updateToolBar [
	| commandGroup |
	self flag: #FQSpecPb , 'Disabling a toolbar button does nothing.'.
	commandGroup := self rootCommandsGroup.
	toolBar fillWith: commandGroup.
	commandGroup allCommands do: #updateEnableStatus.
	toolBar update
]
