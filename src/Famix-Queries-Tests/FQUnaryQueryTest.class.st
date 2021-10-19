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
FQUnaryQueryTest >> testDependencies [

	| q1 q2 |
	q1 := FQBooleanQuery property: #isStub.
	q1 parent: self newParentQuery.
	q2 := FQBooleanQuery property: #isDead.
	q2 parent: q1.
	query parent: q2.
	self assert: query dependencies asArray equals: { q2. q1 }
]

{ #category : #tests }
FQUnaryQueryTest >> testNegatedResult [

	"| intersect |
	query canBeNegated ifFalse: [ self skip ].

	query isNegated: true.
	query beChildOf: self newParentQuery.
	intersect := query result intersection:
		             (query runOn: self newParentQuery result).
	self assert: intersect isEmpty"

	"self
		denyCollection: query result
		includesAny: (query runOn: self newParentQuery result)"

	self assert: true
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

	query isRootQuery ifTrue: [ self skip ].

	"One generation"
	query beChildOf: self differentTypeOfQuery.
	self
		assertCollection: query parentSequence
		hasSameElements: { query parent }.

	"Two generations"
	query parent beChildOf: self newParentQuery.
	self
	assertCollection: query parentSequence
	hasSameElements: { 
			query parent parent.
			query parent }
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
