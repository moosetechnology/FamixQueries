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
FQAbstractPropertyQueryBuilderTest >> preUpdateConfiguration [
	"Setting the initial query so its result is not empty and is different from the result after update"

	self subclassResponsibility
]
