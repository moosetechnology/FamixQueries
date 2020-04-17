Class {
	#name : #FQNumericPropertyQueryBuilderTest,
	#superclass : #FQAbstractPropertyQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

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
