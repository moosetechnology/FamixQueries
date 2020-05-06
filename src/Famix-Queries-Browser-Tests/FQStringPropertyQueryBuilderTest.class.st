Class {
	#name : #FQStringPropertyQueryBuilderTest,
	#superclass : #FQAbstractPropertyQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #tests }
FQStringPropertyQueryBuilderTest >> preUpdateConfiguration [
	queryBuilder := self queryBuilderClass
		newWithParentQuery: (FQMockQuery new result: helper modelExample allModelMethods).
	queryBuilder changeQueryProperty: #name.
	queryBuilder changeQueryValueToCompare: 'int'
]

{ #category : #initialization }
FQStringPropertyQueryBuilderTest >> queryBuilderClass [
	^ FQStringPropertyQueryBuilder
]

{ #category : #tests }
FQStringPropertyQueryBuilderTest >> testChangeQueryComparator [
	queryBuilder changeQueryComparator: #matchesRegex:.
	self assert: queryBuilder query comparator equals: #matchesRegex:
]

{ #category : #tests }
FQStringPropertyQueryBuilderTest >> testChangeQueryProperty [
	queryBuilder changeQueryProperty: #modifiers.
	self assert: queryBuilder query property equals: #modifiers
]

{ #category : #tests }
FQStringPropertyQueryBuilderTest >> testChangeQueryValueToCompare [
	queryBuilder changeQueryValueToCompare: 'LAN'.
	self assert: queryBuilder query valueToCompare equals: 'LAN'
]

{ #category : #tests }
FQStringPropertyQueryBuilderTest >> testInitializeQuery [
	self assert: queryBuilder query class identicalTo: FQStringQuery.
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
FQStringPropertyQueryBuilderTest >> testUpdateQueryResult [
	| previousResult |
	self preUpdateConfiguration.
	
	"Change property"
	previousResult := queryBuilder query result copy.
	queryBuilder changeQueryProperty: #protocol.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult.
	
	"Change comparator"
	previousResult := queryBuilder query result copy.
	queryBuilder changeQueryComparator: #beginsWith:.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult.
	
	"Change value to compare"
	previousResult := queryBuilder query result copy.
	queryBuilder changeQueryValueToCompare: 'ini'.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult
]
