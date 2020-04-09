Class {
	#name : #FQStringPropertyQueryBuilderTest,
	#superclass : #FQAbstractPropertyQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #initialization }
FQStringPropertyQueryBuilderTest >> queryBuilderClass [
	^ FQStringPropertyQueryBuilder
]

{ #category : #tests }
FQStringPropertyQueryBuilderTest >> testChangeQueryComparator [
	queryBuilder changeQueryProperty: #matchesRegex:.
	self assert: queryBuilder query property equals: #matchesRegex:
]

{ #category : #tests }
FQStringPropertyQueryBuilderTest >> testChangeQueryProperty [
	queryBuilder changeQueryProperty: #modifiers.
	self assert: queryBuilder query property equals: #modifiers
]

{ #category : #tests }
FQStringPropertyQueryBuilderTest >> testErrorOnInitializeQuery [
	self impossibleInitializationShouldRaiseAnError
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
