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
FQQueriesBrowserPresenterTest >> addTwoQueriesAndUnion [
	| parents union |
	parents := {(FQBooleanQuery new property: #isAbstract).
	(FQTypeQuery new type: FamixStClass)}.
	union := FQUnionQuery new.
	parents
		do: [ :parent | 
			presenter updateForQuery: parent.
			parent addChild: union ].
	union parents: parents
]

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
FQQueriesBrowserPresenterTest >> testAddCombinationQuery [
	| unionQuery |
	unionQuery := self unionQuery.
	presenter addCombinationQuery: unionQuery.
	
	unionQuery := presenter selectedQuery.
	self assert: unionQuery class identicalTo: FQUnionQuery.
	self
		assert: (presenter queries includes: unionQuery).
	self assert: presenter queriesTree selectedItem equals: unionQuery.
	self
		assertCollection: presenter queryResult items
		hasSameElements: (unionQuery result)
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
FQQueriesBrowserPresenterTest >> testRemoveBinaryQuery [

	| unionQuery firstParent |
	unionQuery := self unionQuery.
	presenter addCombinationQuery: unionQuery.
	firstParent := unionQuery parents first.
	
	presenter removeQuery: unionQuery.
	self
		deny: (presenter queries anySatisfy: [ :query | query == unionQuery ]).
	self assert: presenter selectedQuery equals: firstParent.
	self assert: presenter queriesTree selectedItem equals: firstParent.
	self
		assertCollection: presenter queryResult items
		hasSameElements: firstParent result
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

{ #category : #running }
FQQueriesBrowserPresenterTest >> unionQuery [
	| parents union |
	parents := {(FQBooleanQuery new property: #isAbstract).
	(FQTypeQuery new type: FamixStClass)}.
	union := FQUnionQuery new.
	parents
		do: [ :parent | 
			presenter updateForQuery: parent.
			parent addChild: union ].
	union parents: parents.
	^ union
]
