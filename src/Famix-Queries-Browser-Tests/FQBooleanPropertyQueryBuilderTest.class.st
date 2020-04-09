Class {
	#name : #FQBooleanPropertyQueryBuilderTest,
	#superclass : #FQAbstractPropertyQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

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
FQBooleanPropertyQueryBuilderTest >> testErrorOnInitializeQuery [
	self impossibleInitializationShouldRaiseAnError
]

{ #category : #tests }
FQBooleanPropertyQueryBuilderTest >> testInitializeQuery [
	self assert: queryBuilder query class identicalTo: FQBooleanQuery.
	self
		assert:
			(queryBuilder availableProperties
				includes: queryBuilder query property)
]
