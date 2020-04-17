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
	^ helper modelExample
]

{ #category : #initialization }
FQAbstractQueryBuilderTest >> queryBuilderClass [
	^ self subclassResponsibility
]

{ #category : #running }
FQAbstractQueryBuilderTest >> setUp [
	helper := FQBrowserTestsHelper new.
	queryBuilder := self queryBuilderClass newWithEntities: self entities
]

{ #category : #tests }
FQAbstractQueryBuilderTest >> testErrorOnInitializeQuery [
	self
		should: [ self queryBuilderClass newWithEntities: helper noEntities ]
		raise: ImpossibleQuery
]
