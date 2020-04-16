Class {
	#name : #FQAbstractPropertyQueryBuilderTest,
	#superclass : #FQAbstractQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #testing }
FQAbstractPropertyQueryBuilderTest class >> isAbstract [
	^ self == FQAbstractPropertyQueryBuilderTest
]

{ #category : #running }
FQAbstractPropertyQueryBuilderTest >> setQueryBuilder [
	queryBuilder := self queryBuilderClass
		newWithEntities:
			(MooseGroup
				withAll:
					{self model allModelClasses.
					self model allModelMethods} flatten)
]
