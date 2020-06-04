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
		register: (FQQueryCreationCommand forSpecContext: presenter)
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
FQQueryCreationPresenter class >> queryTypes [
	self
		flag: #FQImprove , 'We should have a way to select interesting classes'.
	^ {FQNavigationQuery.
	FQPropertyQuery.
	FQScopeQuery.
	FQTypeQuery}
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

{ #category : #'query configuration' }
FQQueryCreationPresenter >> configureBooleanQuery: aQuery [
	queryConfigurationPresenter := FQPropertyQueriesPresenter
		owner: self
		on: aQuery
]

{ #category : #'query configuration' }
FQQueryCreationPresenter >> configureNavigationQuery: aQuery [
	queryConfigurationPresenter := FQNavigationQueriesPresenter
		owner: self
		on: aQuery
]

{ #category : #'query configuration' }
FQQueryCreationPresenter >> configureNumericQuery: aQuery [
	queryConfigurationPresenter := FQPropertyQueriesPresenter
		owner: self
		on: aQuery
]

{ #category : #'query configuration' }
FQQueryCreationPresenter >> configureScopeQuery: aQuery [
	queryConfigurationPresenter := FQScopeQueriesPresenter
		owner: self
		on: aQuery
]

{ #category : #'query configuration' }
FQQueryCreationPresenter >> configureStringQuery: aQuery [
	queryConfigurationPresenter := FQPropertyQueriesPresenter
		owner: self
		on: aQuery
]

{ #category : #'query configuration' }
FQQueryCreationPresenter >> configureTypeQuery: aQuery [
	queryConfigurationPresenter := FQTypeQueriesPresenter
		owner: self
		on: aQuery
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
	queryTypesDropList selectIndex: 1
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
		"withoutSyntaxHighlight;"
			yourself.
	self flag: #FQSpecPb , 'modifying syntaxt highlight is slow for now'
]

{ #category : #initialization }
FQQueryCreationPresenter >> initializeQueryTypesDropList [
	queryTypesDropList := self newDropList
		items: self class queryTypes;
		display: [ :queryClass | queryClass label ];
		whenSelectedItemChangedDo:
				[ :queryClass | self updateQueryConfigurationFor: queryClass ]
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

{ #category : #transmissions }
FQQueryCreationPresenter >> queryChangedPort [
	self flag: #FQUnused.
	^ FQQueryInputPort newPresenter: self
]

{ #category : #'accessing model' }
FQQueryCreationPresenter >> setModelBeforeInitialization: aQueriesPresenter [
	browser := aQueriesPresenter
]

{ #category : #update }
FQQueryCreationPresenter >> updateForAcceptedCode: code [
	self flag: #FQImprove
]

{ #category : #update }
FQQueryCreationPresenter >> updateForQuery: aQuery [
	"aQuery should already have browser selectedQuery as parent"

	self flag: #FQImprove , 'Use this to update queryConfiguration ?'.
	resultList updateForEntities: aQuery result.
	self updateQueryCode.
	sequence setModels: aQuery parentSequence.
	self updateToolBar.
	self update
]

{ #category : #update }
FQQueryCreationPresenter >> updateFromConfiguration [
	resultList updateForEntities: self query result.
	self updateQueryCode.
	sequence setModels: self query parentSequence.
	self updateToolBar
]

{ #category : #update }
FQQueryCreationPresenter >> updateQueryCode [
	queryCode
		text:
			(self query isValid
				ifTrue: [ String streamContents: [ :s | self query storeOn: s ] ]
				ifFalse: [ 'No valid query' ]);
		update.
	"syntaxHighlight: self query isValid;"
	self flag: #FQSpecPb , 'modifying syntaxt highlight is slow for now'
]

{ #category : #update }
FQQueryCreationPresenter >> updateQueryConfigurationFor: queryClass [
	(queryClass defaultForParent: browser selectedQuery)
		configureIn: self.
	self updateForQuery: queryConfigurationPresenter query
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
