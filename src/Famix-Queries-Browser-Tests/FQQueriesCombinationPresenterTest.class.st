Class {
	#name : #FQQueriesCombinationPresenterTest,
	#superclass : #SpTest,
	#instVars : [
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #running }
FQQueriesCombinationPresenterTest >> browserWithTwoQueries [
	| browser |
	browser := FQQueriesBrowserPresenter on: helper classesAndMethods.
	{(FQBooleanQuery new property: #isAbstract).
	(FQTypeQuery new type: FamixStClass)}
		do: [ :parent | 
			browser updateForQuery: parent.
			browser selectQuery: browser initialQuery ].
	^ browser
]

{ #category : #running }
FQQueriesCombinationPresenterTest >> classToTest [
	^ FQQueriesCombinationPresenter
]

{ #category : #running }
FQQueriesCombinationPresenterTest >> openInstance [
	presenter
		onQueries:
			(presenter browser queries copyWithout: presenter browser initialQuery).
	super openInstance
]

{ #category : #running }
FQQueriesCombinationPresenterTest >> presenterClass [
	^ FQQueriesCombinationPresenter
]

{ #category : #running }
FQQueriesCombinationPresenterTest >> setUp [
	super setUp.
	helper := FQBrowserTestsHelper new.
	presenter := self presenterClass on: self browserWithTwoQueries
]

{ #category : #tests }
FQQueriesCombinationPresenterTest >> testBasicInitialization [
	self
		assertCollection: (presenter combinationsDroplist model items collect: #model)
		hasSameElements:
			{FQUnionQuery.
			FQIntersectionQuery.
			FQSubstractionQuery}.
	self
		assertCollection: presenter resultList items
		hasSameElements: #().
	self assert: presenter toolBar class identicalTo: SpToolBarPresenter.
	self
		assert: presenter toolBar presenters first class
		identicalTo: SpToolBarButton
]

{ #category : #tests }
FQQueriesCombinationPresenterTest >> testNeverKeepFalseChildren [
	self openInstance.
	presenter combinationsDroplist selectItem: FQUnionQuery.

	presenter parentQueries
		do: [ :parent | 
			self assert: parent children size equals: 1.
			self assert: parent children first identicalTo: presenter newQuery.
			self assert: (presenter newQuery parents includes: parent) ].
		
	presenter combinationsDroplist selectItem: FQIntersectionQuery.

	presenter parentQueries
		do: [ :parent | 
			self assert: parent children size equals: 1.
			self assert: parent children first identicalTo: presenter newQuery.
			self assert: (presenter newQuery parents includes: parent) ].
]

{ #category : #tests }
FQQueriesCombinationPresenterTest >> testOnQueries [
	self openInstance.
	self
		assert: presenter newQuery class
		identicalTo: presenter combinationsDroplist selectedItem.
	self
		assert: presenter queriesTree class
		identicalTo: FQRoassalQueryPresenter.
	self
		assert: presenter queriesTree selectedItem
		identicalTo: presenter newQuery.
	self
		assertCollection: presenter resultList items
		hasSameElements: presenter newQuery result
]

{ #category : #tests }
FQQueriesCombinationPresenterTest >> testToolBarAction [
	| initialQueriesSize |
	self openInstance.
	initialQueriesSize := presenter browser queries size.
	presenter toolBar presenters first click.
	self
		assert: presenter browser queries size
		equals: initialQueriesSize + 1.
	self
		assert: presenter browser selectedQuery
		equals: presenter newQuery.
	self
		assertCollection: presenter browser selectedQuery parents
		hasSameElements: presenter parentQueries.
	(presenter browser queries
		copyWithoutAll:
			{presenter browser initialQuery.
			presenter newQuery})
		do: [ :parent | 
			self assert: parent children size equals: 1.
			self assert: parent children first identicalTo: presenter newQuery ]
]

{ #category : #tests }
FQQueriesCombinationPresenterTest >> testUpdateForQueryClass [
	self openInstance.
	presenter combinationsDroplist selectItem: FQUnionQuery.
	
	self assert: presenter newQuery class identicalTo: FQUnionQuery.
	
	presenter parentQueries
		do: [ :parent | 
			self assert: parent children size equals: 1.
			self assert: parent children first identicalTo: presenter newQuery.
			self assert: (presenter newQuery parents includes: parent) ].
	
	self
		assert: presenter queriesTree selectedItem
		identicalTo: presenter newQuery.
	
	self
		assertCollection: presenter resultList items
		hasSameElements: presenter newQuery result
]

{ #category : #tests }
FQQueriesCombinationPresenterTest >> testWindowClosedAction [
	| initialQueriesSize |
	self openInstance.
	initialQueriesSize := presenter browser queries size.
	presenter window close.
	self
		assert: presenter browser queries size
		equals: initialQueriesSize.
	self deny: presenter browser selectedQuery equals: presenter newQuery.
	self deny: (presenter browser queries includes: presenter newQuery).
	(presenter browser queries
		copyWithoutAll:
			{presenter browser initialQuery.
			presenter newQuery})
		do: [ :parent | self assert: parent children isEmpty ]
]
