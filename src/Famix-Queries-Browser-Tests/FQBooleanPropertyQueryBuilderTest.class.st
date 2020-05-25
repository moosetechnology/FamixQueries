Class {
	#name : #FQBooleanPropertyQueryBuilderTest,
	#superclass : #FQAbstractPropertyQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #tests }
FQBooleanPropertyQueryBuilderTest >> preUpdateConfiguration [
	queryBuilder := self queryBuilderClass
		newWithParentQuery: (FQMockQuery new result: helper classes).
	queryBuilder changeQueryProperty: #isInstanceSide.

	self deny: queryBuilder queryResult isEmpty
]

{ #category : #initialization }
FQBooleanPropertyQueryBuilderTest >> queryBuilderClass [
	^ FQBooleanPropertyQueryBuilder
]

{ #category : #tests }
FQBooleanPropertyQueryBuilderTest >> testChangeQueryProperty [
	queryBuilder changeQueryProperty: #isAbstract.
	self assert: queryBuilder query property equals: #isAbstract
]

{ #category : #tests }
FQBooleanPropertyQueryBuilderTest >> testInitializeQuery [
	self assert: queryBuilder query class identicalTo: FQBooleanQuery.
	self
		assert:
			(queryBuilder availableProperties
				includes: queryBuilder query property)
]

{ #category : #tests }
FQBooleanPropertyQueryBuilderTest >> testUpdateQueryResult [
	| previousResult |
	self preUpdateConfiguration.
	previousResult := queryBuilder query result copy.
	
	"Change Property"
	queryBuilder changeQueryProperty: #isAbstract.	
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult
]
