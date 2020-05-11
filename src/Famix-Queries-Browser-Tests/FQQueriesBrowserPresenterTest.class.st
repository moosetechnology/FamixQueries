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
FQQueriesBrowserPresenterTest >> testInitialization [
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
	
	self
		deny:
			(presenter queries
				anySatisfy: [ :q | q == query  ]).
	self
		assert: presenter selectedQuery
		equals: presenter initialQuery.
	self
		assert: presenter queriesTree selectedItem
		equals: presenter initialQuery.
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
		hasSameElements: query1 result
]

{ #category : #tests }
FQQueriesBrowserPresenterTest >> testUpdateForQuery [
	| query |
	query := FQBooleanQuery new property: #isAbstract.
	presenter updateForQuery: query.
	self assert: (presenter queries includes: query).
	self assert: presenter selectedQuery equals: query.
	self assert: presenter queriesTree selectedItem equals: query.
	self
		assertCollection: presenter queryResult items
		hasSameElements: (helper classesAndMethods select: #isAbstract)
]
