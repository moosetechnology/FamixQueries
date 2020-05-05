Class {
	#name : #FQQueriesCombinatorTest,
	#superclass : #TestCase,
	#instVars : [
		'combinator',
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #running }
FQQueriesCombinatorTest >> addBooleanQuery [
	^ combinator
		addQuery: (FQBooleanQuery new property: #isAbstract)
		after: combinator initialQuery
]

{ #category : #running }
FQQueriesCombinatorTest >> addTypeQuery [
	^ combinator
		addQuery: (FQTypeQuery new type: FamixStClass)
		after: combinator initialQuery
]

{ #category : #running }
FQQueriesCombinatorTest >> setUp [
	helper := FQBrowserTestsHelper new.
	combinator := FQQueriesCombinator
		newWithEntities: helper classesAndMethods
]

{ #category : #tests }
FQQueriesCombinatorTest >> testAddQueryAfter [
	| wrapper |
	wrapper := self addBooleanQuery.
	
	self assert: combinator queries size equals: 2.
	self assert: combinator queries last identicalTo: wrapper.
	
	self assert: wrapper class identicalTo: FQTerminalQueryWrapper.
	self assert: wrapper query equals: (FQBooleanQuery new property: #isAbstract).
	
	self assert: (combinator initialQuery children first) identicalTo: wrapper.
	self assert: wrapper parent identicalTo: combinator initialQuery
]

{ #category : #tests }
FQQueriesCombinatorTest >> testComputeResultOf [
	| query1 query2 |
	query1 := self addTypeQuery.
	self
		assertCollection: (combinator computeResultOf: query1)
		hasSameElements: (combinator initialEntities select: #isClass).
	query2 := combinator
		addQuery:
			(FQStringQuery new
				property: #name;
				comparator: #includesSubstring:;
				valueToCompare: 'Server')
		after: query1.
	self
		denyCollection: (combinator computeResultOf: query2)
		hasSameElements:
			(combinator initialEntities
				select: [ :class | class name includesSubstring: 'Server' ]).
	self
		assertCollection: (combinator computeResultOf: query2)
		hasSameElements:
			(query1 result
				select: [ :class | class name includesSubstring: 'Server' ])
]

{ #category : #tests }
FQQueriesCombinatorTest >> testInitialEntities [
	self
		assertCollection: combinator initialEntities
		hasSameElements: helper classesAndMethods
]

{ #category : #tests }
FQQueriesCombinatorTest >> testInitialQuery [
	self
		assertCollection: combinator initialQuery result
		hasSameElements: helper classesAndMethods.
	self assert: combinator initialQuery query isNil.
	self assert: combinator initialQuery parent isNil.
	self assert: combinator initialQuery children isEmpty
]

{ #category : #tests }
FQQueriesCombinatorTest >> testRemoveCombinatorQuery [
	| query1 query2 unionQuery |
	query1 := self addBooleanQuery.
	query2 := self addTypeQuery.
	unionQuery := combinator addUnionQueryBetween: query1 and: query2.
	
	combinator removeQuery: unionQuery.
	
	self assert: unionQuery parents isEmpty.
	self assert: query1 children isEmpty.
	self assert: query2 children isEmpty.
	
	self deny: (combinator queries includes: unionQuery)
]

{ #category : #tests }
FQQueriesCombinatorTest >> testRemoveQuery [
	| wrapper |
	wrapper := self addBooleanQuery.
	
	combinator removeQuery: wrapper.
	
	self assert: wrapper parent isNil.
	self assert: combinator initialQuery children isEmpty.
	self deny: (combinator queries includes: wrapper)
]

{ #category : #tests }
FQQueriesCombinatorTest >> testaddUnionQueryBetweenAnd [
	| query1 query2 unionQuery |
	query1 := self addBooleanQuery.
	query2 := self addTypeQuery.
	unionQuery := combinator addUnionQueryBetween: query1 and: query2.
	
	self assert: unionQuery class identicalTo: FQCombinatorQueryWrapper.
	self
		assertCollection: unionQuery parents
		hasSameElements:
			{query1.
			query2}.
	self assert: (query1 children includes: unionQuery).
	self assert: (query2 children includes: unionQuery)
]