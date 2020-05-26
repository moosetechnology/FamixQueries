Class {
	#name : #FQScopeQueryBuilderTest,
	#superclass : #FQAbstractQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #running }
FQScopeQueryBuilderTest >> queryBuilderClass [
	^ FQScopeQueryBuilder
]

{ #category : #tests }
FQScopeQueryBuilderTest >> testChangeQueryDirection [
	queryBuilder changeQueryDirection: FQScopeDown.
	self
		assert: queryBuilder query directionStrategy
		identicalTo: FQScopeDown
]

{ #category : #tests }
FQScopeQueryBuilderTest >> testChangeQueryScope [
	queryBuilder changeQueryScope: FamixStAttribute.
	self assert: queryBuilder query scope identicalTo: FamixStAttribute
]

{ #category : #tests }
FQScopeQueryBuilderTest >> testInitializeQuery [
	super testInitializeQuery.
	self
		assert: (queryBuilder query directionStrategy inheritsFrom: FQAbstractScopeDirection).
	self assert: queryBuilder query scope isNotNil.
	self
		assert: (queryBuilder availableScopes includes: queryBuilder query scope)
]

{ #category : #tests }
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
