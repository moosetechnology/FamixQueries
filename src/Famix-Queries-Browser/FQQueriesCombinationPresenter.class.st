Class {
	#name : #FQQueriesCombinationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#queriesTree',
		'#resultList',
		'#combinationsDroplist',
		'#parentQueries',
		'#newQuery',
		'#browser',
		'#toolBar',
		'#queryWasValidated',
		'#query => SpObservableSlot',
		'#firstParent',
		'#secondParent',
		'#reverseButton',
		'#queryOperator'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #commands }
FQQueriesCombinationPresenter class >> buildCommandsGroupWith: presenter forRoot: aCmCommandsGroup [
	aCmCommandsGroup
		register:
			((FQQueryCreationCommand forSpecWithIconNamed: #glamorousGo)
				context: presenter)
]

{ #category : #specs }
FQQueriesCombinationPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #toolBar height: self toolbarHeight;
		add:
			(SpPanedLayout newHorizontal
				add:
					(SpBoxLayout newVertical
						add: #combinationsDroplist height: self buttonHeight;
						add: #queriesTree;
						yourself);
				add: #resultList;
				yourself);
		yourself
]

{ #category : #specs }
FQQueriesCombinationPresenter class >> nonCommuntativeQueryLayout [
	^ SpBoxLayout newVertical
		add: #toolBar height: self toolbarHeight;
		add:
			(SpPanedLayout newHorizontal
				add:
					(SpBoxLayout newVertical
						add: #combinationsDroplist height: self buttonHeight;
						add: self parentsInversionLayout
							height: self parentInversionHeight;
						add: #queriesTree;
						yourself);
				add: #resultList;
				yourself);
		yourself
]

{ #category : #specs }
FQQueriesCombinationPresenter class >> parentInversionHeight [
	"3 labels in parentsInversionLayout"

	^ self labelHeight * 3
]

{ #category : #specs }
FQQueriesCombinationPresenter class >> parentsInversionLayout [
	^ SpBoxLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #firstParent;
				add: #queryOperator;
				add: #secondParent;
				yourself);
		add: #reverseButton width: self buttonHeight;
		yourself
]

{ #category : #specs }
FQQueriesCombinationPresenter class >> title [
	^ 'Queries Combination'
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> basicInitializeQueriesTree [
	queriesTree := SpNullPresenter new
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> connectPresenters [
	self queryAcceptedPort
		transmitTo: browser queryInputPort
		transform: [ :q | 
			self window close.
			q ]
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> initializeDropList [
	combinationsDroplist := self newDropList
		items: FQBinaryQuery availableCombinations;
		display: [ :queryClass | queryClass label ];
		whenSelectedItemChangedDo: [ :queryClass | self updateForQueryClass: queryClass ]
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> initializeNonCommutativeConfiguration [
	firstParent := self newLabel.
	secondParent := self newLabel.
	queryOperator := self newLabel.
	reverseButton := self newButton
		icon: (self theme iconNamed: #glamorousRefresh);
		action: [ newQuery reverseParents.
			self updateSubPresenters ]
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> initializePresenters [
	self initializeToolBar.
	self initializeDropList.
	self basicInitializeQueriesTree.
	self initializeResultList.
	self initializeNonCommutativeConfiguration
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> initializeResultList [
	resultList := self instantiate: FQResultTreePresenter on: browser
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> initializeToolBar [
	toolBar := self newToolBar fillWith: self rootCommandsGroup
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		whenClosedDo: [ queryWasValidated
				ifFalse: [ parentQueries do: [ :parent | parent removeChild: newQuery ] ] ]
]

{ #category : #update }
FQQueriesCombinationPresenter >> labelsForNonCommutativeQuery: aQuery [
	firstParent label: aQuery parents first name.
	secondParent label: aQuery parents second name.
	queryOperator label: newQuery operator asString
]

{ #category : #accessing }
FQQueriesCombinationPresenter >> newQuery [
	^ newQuery
]

{ #category : #transmissions }
FQQueriesCombinationPresenter >> notifyAcceptedQuery [
	queryWasValidated := true.
	self notifyPropertyChanged: #query
]

{ #category : #opening }
FQQueriesCombinationPresenter >> onQueries: aQueriesCollection [
	parentQueries := aQueriesCollection.
	(queriesTree := FQRoassalQueryPresenter on: parentQueries)
		noInteractions;
		adaptToBrowser: browser.
	combinationsDroplist selectIndex: 1
]

{ #category : #accessing }
FQQueriesCombinationPresenter >> query [
	^ newQuery
]

{ #category : #transmissions }
FQQueriesCombinationPresenter >> queryAcceptedPort [
	^ FQQueryOutputPort newPresenter: self
]

{ #category : #'accessing model' }
FQQueriesCombinationPresenter >> setModelBeforeInitialization: aBrowser [
	browser := aBrowser.
	queryWasValidated := false
]

{ #category : #update }
FQQueriesCombinationPresenter >> updateForQueryClass: queryClass [
	newQuery ifNotNil: [ newQuery prepareRemoval ].
	newQuery := queryClass new
		beChildOf: parentQueries;
		yourself.
	self updateLayoutForQueryClass: queryClass.
	self updateSubPresenters.
	self update
]

{ #category : #update }
FQQueriesCombinationPresenter >> updateLayoutForQueryClass: queryClass [
	layout := queryClass isCommutative
		ifTrue: [ self class defaultSpec ]
		ifFalse: [ self class nonCommuntativeQueryLayout ]
]

{ #category : #update }
FQQueriesCombinationPresenter >> updateSubPresenters [
	self labelsForNonCommutativeQuery: newQuery.
	queriesTree updateWithQueries: newQuery parents , {newQuery}.
	resultList updateForEntities: newQuery result
]
