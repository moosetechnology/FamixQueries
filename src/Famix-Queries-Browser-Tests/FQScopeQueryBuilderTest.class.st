Class {
	#name : #FQScopeQueryBuilderTest,
	#superclass : #FQAbstractQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #initialization }
FQScopeQueryBuilderTest >> queryBuilderClass [
	^ FQScopeQueryBuilder
]

{ #category : #initialization }
FQScopeQueryBuilderTest >> testChangeQueryDirection [
	queryBuilder changeQueryDirection: FQScopeDown.
	self
		assert: queryBuilder query directionStrategy
		identicalTo: FQScopeDown
]

{ #category : #initialization }
FQScopeQueryBuilderTest >> testChangeQueryScope [
	queryBuilder changeQueryScope: FamixStAttribute.
	self assert: queryBuilder query scope identicalTo: FamixStAttribute
]

{ #category : #initialization }
FQScopeQueryBuilderTest >> testInitializeQuery [
	self assert: queryBuilder query class identicalTo: FQScopeQuery.
	self
		assert: (queryBuilder query directionStrategy inheritsFrom: FQAbstractScopeDirection).
	self assert: queryBuilder query scope isNotNil.
	self
		assert: (queryBuilder availableScopes includes: queryBuilder query scope)
]

{ #category : #initialization }
FQScopeQueryBuilderTest >> testUpdateQueryResult [
	| previousResult |
	
	previousResult := queryBuilder query result copy.
	queryBuilder changeQueryDirection: FQScopeDown.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult.
	
	previousResult := queryBuilder query result copy.
	queryBuilder changeQueryScope: FamixStAttribute.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult
]
