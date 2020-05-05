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
FQAbstractPropertyQueryBuilderTest >> entities [
	^ helper classesAndMethods
]
