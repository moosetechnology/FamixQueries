Class {
	#name : #FQQueriesCombinationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'queriesTree',
		'resultList',
		'combinationsDroplist',
		'parentQueries',
		'newQuery',
		'browser',
		'toolBar'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #commands }
FQQueriesCombinationPresenter class >> buildCommandsGroupWith: presenter forRoot: aCmCommandsGroup [
	aCmCommandsGroup
		register:
			((FQQueryCombinationCommand forSpecWithIconNamed: #glamorousGo)
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
FQQueriesCombinationPresenter >> initializeQueriesTree [
	queriesTree := SpNullPresenter new
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> initializeResultList [
	resultList := self newList
		display: #name;
		yourself
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> initializeToolBar [
	toolBar := self newToolBar fillWith: self rootCommandsGroup
]

{ #category : #initialization }
FQQueriesCombinationPresenter >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		whenClosedDo: [ parentQueries do: [ :parent | parent removeChild: newQuery ] ]
]

{ #category : #accessing }
FQQueriesCombinationPresenter >> newQuery [
	^ newQuery
]

{ #category : #update }
FQQueriesCombinationPresenter >> notifyAcceptedQuery [
	browser addCombinationQuery: newQuery
]

{ #category : #accessing }
FQQueriesCombinationPresenter >> openOnQueries: aQueriesCollection [
	parentQueries := aQueriesCollection.
	(queriesTree := FQRoassalQueryPresenter on: parentQueries)
		noInteractions;
		adaptToBrowser: browser.
	combinationsDroplist selectIndex: 1.
	self openWithSpec
]

{ #category : #'accessing model' }
FQQueriesCombinationPresenter >> setModelBeforeInitialization: aBrowser [
	browser := aBrowser
]

{ #category : #update }
FQQueriesCombinationPresenter >> updateForQueryClass: queryClass [
	newQuery
		ifNotNil: [ parentQueries do: [ :parent | parent removeChild: newQuery ] ].
	newQuery := queryClass new parents: parentQueries.
	parentQueries do: [ :parent | parent addChild: newQuery ].
	queriesTree updateWithQueries: parentQueries , {newQuery}.
	resultList items: newQuery result
]
