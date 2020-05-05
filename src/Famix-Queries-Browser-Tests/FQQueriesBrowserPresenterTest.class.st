Class {
	#name : #FQQueriesBrowserPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #running }
FQQueriesBrowserPresenterTest >> presenterClass [
	^ FQQueriesBrowserPresenter
]

{ #category : #running }
FQQueriesBrowserPresenterTest >> setUp [
	super setUp.
	helper := FQBrowserTestsHelper new.
	presenter := self presenterClass on: helper classesAndMethods
]

{ #category : #tests }
FQQueriesBrowserPresenterTest >> testAddUnionQueryBetweenAnd [
	| query1 query2 unionQuery |
	presenter updateForQuery: (FQBooleanQuery new property: #isAbstract).
	query1 := presenter selectedQuery.
	presenter updateForQuery: (FQTypeQuery new type: FamixStClass).
	query2 := presenter selectedQuery.
	presenter addUnionQueryBetween: query1 and: query2.
	self
		assert: presenter selectedQuery class
		identicalTo: FQCombinatorQueryWrapper.
	unionQuery := presenter selectedQuery.
	self
		assert: presenter queriesCombinator queries last
		equals: unionQuery.
	self assert: presenter queriesTree selectedItem equals: unionQuery.
	self
		assertCollection: presenter queryResult items
		hasSameElements: (presenter queriesCombinator resultOfQuery: unionQuery)
]

{ #category : #tests }
FQQueriesBrowserPresenterTest >> testInitialization [
	self
		assert: presenter queriesCombinator class
		identicalTo: FQQueriesCombinator.
	self
		assertCollection: presenter entities
		hasSameElements: helper classesAndMethods
]

{ #category : #tests }
FQQueriesBrowserPresenterTest >> testQueriesTree [
	self flag: #FQImprove.
	self
		assert: presenter queriesTree class
		identicalTo: FQRoassalQueryPresenter
]

{ #category : #tests }
FQQueriesBrowserPresenterTest >> testQueryResult [
	self assert: presenter queryResult class identicalTo: SpListPresenter.
	self
		assertCollection: presenter queryResult items
		hasSameElements: presenter entities
]

{ #category : #tests }
FQQueriesBrowserPresenterTest >> testRemoveQuery [
	| query |
	query := FQBooleanQuery new property: #isAbstract.
	presenter updateForQuery: query.
	presenter removeQuery: presenter selectedQuery.
	self assert: presenter queriesCombinator queries size equals: 1.
	self
		assert: presenter selectedQuery
		equals: presenter queriesCombinator initialQuery.
	self
		assert: presenter queriesTree selectedItem
		equals: presenter queriesCombinator initialQuery.
	self
		assertCollection: presenter queryResult items
		hasSameElements: helper classesAndMethods
]

{ #category : #tests }
FQQueriesBrowserPresenterTest >> testSelectQuery [
	| query1 |
	presenter updateForQuery: (FQBooleanQuery new property: #isAbstract).
	query1 := presenter selectedQuery.
	presenter updateForQuery: (FQTypeQuery new type: FamixStClass).
	
	presenter selectQuery: query1.
	self assert: presenter selectedQuery equals: query1.
	self assert: presenter queriesTree selectedItem equals: query1.
	self
		assertCollection: presenter queryResult items
		hasSameElements: (presenter queriesCombinator resultOfQuery: query1)
]

{ #category : #tests }
FQQueriesBrowserPresenterTest >> testUpdateForQuery [
	| query |
	query := FQBooleanQuery new property: #isAbstract.
	presenter updateForQuery: query.
	self
		assert: presenter queriesCombinator queries last query
		equals: query.
	self assert: presenter selectedQuery query equals: query.
	self assert: presenter queriesTree selectedItem query equals: query.
	self
		assertCollection: presenter queryResult items
		hasSameElements: (helper classesAndMethods select: #isAbstract)
]
