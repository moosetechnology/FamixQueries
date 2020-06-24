Class {
	#name : #FQAbstractQueryTest,
	#superclass : #TestCase,
	#instVars : [
		'query',
		'helper'
	],
	#category : #'Famix-Queries-Tests-Core'
}

{ #category : #testing }
FQAbstractQueryTest class >> isAbstract [
	^ self = FQAbstractQueryTest
]

{ #category : #testing }
FQAbstractQueryTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #running }
FQAbstractQueryTest >> actualClass [
	^ self subclassResponsibility
]

{ #category : #running }
FQAbstractQueryTest >> differentTypeOfQuery [
	^ FQBooleanQuery new property: #isAbstract
]

{ #category : #running }
FQAbstractQueryTest >> evaluate: aString [
	^ self actualClass readFrom: aString
]

{ #category : #running }
FQAbstractQueryTest >> expectedPrintOnString [
	^ self subclassResponsibility
]

{ #category : #running }
FQAbstractQueryTest >> newQuery [
	^ self subclassResponsibility
]

{ #category : #running }
FQAbstractQueryTest >> setUp [
	super setUp.
	helper := FQTestsHelper current.
	query := self newQuery
]

{ #category : #tests }
FQAbstractQueryTest >> testAddChild [
	| child |
	child := self differentTypeOfQuery.
	query addChild: child.
	self assert: (query children includes: child)
]

{ #category : #tests }
FQAbstractQueryTest >> testBeChildOf [
	self subclassResponsibility
]

{ #category : #'tests - printing' }
FQAbstractQueryTest >> testDisplayOn [
	self subclassResponsibility
]

{ #category : #tests }
FQAbstractQueryTest >> testIsValid [
	self assert: query isValid.
	self deny: self unConfiguredQuery isValid
]

{ #category : #'tests - printing' }
FQAbstractQueryTest >> testName [
	self subclassResponsibility
]

{ #category : #tests }
FQAbstractQueryTest >> testParentSequence [
	self subclassResponsibility
]

{ #category : #tests }
FQAbstractQueryTest >> testPrepareRemoval [
	self subclassResponsibility
]

{ #category : #'tests - printing' }
FQAbstractQueryTest >> testPrintOn [
	self assert: query printString equals: self expectedPrintOnString.
	self
		assert: self unConfiguredQuery printString
		equals: 'a ' , self actualClass name , ' (invalid)'
]

{ #category : #tests }
FQAbstractQueryTest >> testRemoveChild [
	| child |
	child := self differentTypeOfQuery.
	child beChildOf: query.
	query removeChild: child.
	self deny: (query children includes: child)
]

{ #category : #tests }
FQAbstractQueryTest >> testResult [
	self subclassResponsibility
]

{ #category : #'tests - running' }
FQAbstractQueryTest >> testRunOn [
	self subclassResponsibility
]

{ #category : #'tests - printing' }
FQAbstractQueryTest >> testStoreOn [
	| generatedQuery |
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	self assert: generatedQuery class identicalTo: self actualClass.
	self assert: (generatedQuery hasSameParametersAs: query)
]

{ #category : #running }
FQAbstractQueryTest >> unConfiguredQuery [
	^ self actualClass new
]
