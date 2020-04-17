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
	queryBuilder changeQueryDirection: FQScopeDownDirection.
	self
		assert: queryBuilder query direction
		identicalTo: FQScopeDownDirection
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
		assert: (queryBuilder query direction inheritsFrom: FQAbstractScopeDirection).
	self assert: queryBuilder query scope isNotNil.
	self
		assert: (queryBuilder availableScopes includes: queryBuilder query scope)
]
