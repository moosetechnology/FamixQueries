Class {
	#name : #FQNumericPropertyQueryBuilderTest,
	#superclass : #FQAbstractPropertyQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #tests }
FQNumericPropertyQueryBuilderTest >> preUpdateConfiguration [
	queryBuilder := self queryBuilderClass
		newWithParentQuery: (FQMockQuery new result: helper modelExample allModelClasses).
	queryBuilder changeQueryProperty: #numberOfMethods.
	queryBuilder changeQueryValueToCompare: 3
]

{ #category : #initialization }
FQNumericPropertyQueryBuilderTest >> queryBuilderClass [
	^ FQNumericPropertyQueryBuilder
]

{ #category : #tests }
FQNumericPropertyQueryBuilderTest >> testChangeQueryComparator [
	queryBuilder changeQueryProperty: #<=.
	self assert: queryBuilder query property equals: #<=
]

{ #category : #tests }
FQNumericPropertyQueryBuilderTest >> testChangeQueryProperty [
	queryBuilder changeQueryProperty: #numberOfChildren.
	self assert: queryBuilder query property equals: #numberOfChildren
]

{ #category : #tests }
FQNumericPropertyQueryBuilderTest >> testChangeQueryValueToCompare [
	queryBuilder changeQueryValueToCompare: 10.
	self assert: queryBuilder query valueToCompare equals: 10
]

{ #category : #tests }
FQNumericPropertyQueryBuilderTest >> testInitializeQuery [
	self assert: queryBuilder query class identicalTo: FQNumericQuery.
	self
		assert:
			(queryBuilder availableProperties
				includes: queryBuilder query property).
	self
		assert:
			(queryBuilder availableComparators
				includes: queryBuilder query comparator)
]

{ #category : #tests }
FQNumericPropertyQueryBuilderTest >> testUpdateQueryResult [
	| previousResult |
	self preUpdateConfiguration.
	
	"Change property"
	previousResult := queryBuilder query result copy.
	queryBuilder changeQueryProperty: #numberOfChildren.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult.
	
	"Change comparator"
	previousResult := queryBuilder query result copy.
	queryBuilder changeQueryComparator: #<=.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult.
	
	"Change value to compare"
	previousResult := queryBuilder query result copy.
	queryBuilder changeQueryValueToCompare: 5.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult
]
