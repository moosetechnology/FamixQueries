Class {
	#name : #FQAbstractQueryBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'queryBuilder',
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #testing }
FQAbstractQueryBuilderTest class >> isAbstract [
	^ self == FQAbstractQueryBuilderTest
]

{ #category : #running }
FQAbstractQueryBuilderTest >> entities [
	^ helper classesAndMethods
]

{ #category : #running }
FQAbstractQueryBuilderTest >> queryBuilderClass [
	^ self subclassResponsibility
]

{ #category : #running }
FQAbstractQueryBuilderTest >> setUp [
	helper := FQTestsHelper current.
	queryBuilder := self queryBuilderClass
		newWithParentQuery: (FQMockQuery new result: self entities)
]

{ #category : #tests }
FQAbstractQueryBuilderTest >> testErrorOnInitializeQuery [
	self
		should: [ self queryBuilderClass
				newWithParentQuery: (FQMockQuery new result: helper noEntities) ]
		raise: FQImpossibleQuery
]
