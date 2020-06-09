Class {
	#name : #FQUnaryQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #testing }
FQUnaryQueryTest class >> isAbstract [
	^ self == FQUnaryQueryTest
]

{ #category : #'instance creation' }
FQUnaryQueryTest >> newParentQuery [
	^ FQRootQuery new result: helper classes
]

{ #category : #tests }
FQUnaryQueryTest >> testBeChildOf [
	| parent |
	parent := self differentTypeOfQuery.
	query beChildOf: parent.
	self assert: query parent identicalTo: parent.
	self assert: (parent children includes: query)
]

{ #category : #tests }
FQUnaryQueryTest >> testParent [
	| parent |
	parent := self newParentQuery.
	query parent: parent.
	self assert: query parent equals: parent
]

{ #category : #tests }
FQUnaryQueryTest >> testParentSequence [
	query isRootQuery
		ifTrue: [ self skip ].
		
	"One generation"
	query beChildOf: self differentTypeOfQuery.
	self
		assertCollection: query parentSequence
		hasSameElements:
			{query parent.
			query}.

	"Two generations"
	query parent beChildOf: self newParentQuery.
	self
		assertCollection: query parentSequence
		hasSameElements:
			{query parent parent.
			query parent.
			query}
]

{ #category : #tests }
FQUnaryQueryTest >> testPrepareRemoval [
	| parent |
	query isRootQuery
		ifTrue: [ self skip ].

	parent := self differentTypeOfQuery.
	query beChildOf: parent.

	query prepareRemoval.
	self assert: query parent isNil.
	self deny: (parent children includes: query)
]

{ #category : #tests }
FQUnaryQueryTest >> testResult [
	query beChildOf: self newParentQuery.
	self
		assertCollection: query result
		hasSameElements: (query runOn: self newParentQuery result)
]
