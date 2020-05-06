Class {
	#name : #FQTypeQueryBuilderTest,
	#superclass : #FQAbstractQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #initialization }
FQTypeQueryBuilderTest >> queryBuilderClass [
	^ FQTypeQueryBuilder 
]

{ #category : #tests }
FQTypeQueryBuilderTest >> testAddTypeToQuery [
	queryBuilder addTypeToQuery: FamixStMethod.
	self assert: (queryBuilder currentQueryTypes includes: FamixStMethod)
]

{ #category : #tests }
FQTypeQueryBuilderTest >> testInitializeQuery [
	self assert: queryBuilder query class identicalTo: FQTypeQuery.
	self
		assertCollection: queryBuilder currentQueryTypes
		hasSameElements: queryBuilder availableTypes
]

{ #category : #tests }
FQTypeQueryBuilderTest >> testRemoveTypeFromQuery [
	queryBuilder removeTypeFromQuery: FamixStMethod.
	self deny: (queryBuilder currentQueryTypes includes: FamixStMethod)
]

{ #category : #tests }
FQTypeQueryBuilderTest >> testUpdateQueryResult [
	| previousResult |
	previousResult := queryBuilder query result copy.
	queryBuilder removeTypeFromQuery: FamixStMethod.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult
]
