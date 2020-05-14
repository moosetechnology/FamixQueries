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
		'#query => SpObservableSlot'
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
FQQueriesCombinationPresenter >> initialize [
	super initialize.
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> initializeDropList [
	combinationsDroplist := self newDropList
		items: (FQBinaryQuery allSubclasses copyWithout: FQSequenceQuery);
		display: [ :queryClass | queryClass label ];
		whenSelectedItemChangedDo: [ :queryClass | self updateForQueryClass: queryClass ]
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> initializePresenters [
	self initializeToolBar.
	self initializeDropList.
	self basicInitializeQueriesTree.
	self initializeResultList
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
	newQuery
		ifNotNil: [ parentQueries do: [ :parent | parent removeChild: newQuery ] ].
	newQuery := queryClass new parents: parentQueries.
	parentQueries do: [ :parent | parent addChild: newQuery ].
	queriesTree updateWithQueries: parentQueries , {newQuery}.
	resultList updateForEntities: newQuery result
]
