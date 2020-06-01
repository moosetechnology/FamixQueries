Class {
	#name : #FQBinaryQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Binary'
}

{ #category : #testing }
FQBinaryQueryTest class >> isAbstract [
	^ self == FQBinaryQueryTest
]

{ #category : #running }
FQBinaryQueryTest >> expectedResult [
	^ self subclassResponsibility
]

{ #category : #parents }
FQBinaryQueryTest >> firstParentOfQuery [
	^ query parents first
]

{ #category : #parents }
FQBinaryQueryTest >> newBooleanParent [
	^ FQBooleanQuery new property: #isAbstract
]

{ #category : #parents }
FQBinaryQueryTest >> newInvalidParent [
	^ FQBooleanQuery new
]

{ #category : #parents }
FQBinaryQueryTest >> newNavigationParent [
	^ FQNavigationQuery new
		direction: #Incoming;
		association: #Reference;
		association: #Inheritance
]

{ #category : #running }
FQBinaryQueryTest >> newQuery [
	"This gives different, non-empty results for each binary query"

	| firstParentQuery secondParentQuery |
	firstParentQuery := self newNavigationParent.
	secondParentQuery := self newTypeParent.
	^ self unConfiguredQuery
		beChildOf:
			{firstParentQuery.
			secondParentQuery}
]

{ #category : #parents }
FQBinaryQueryTest >> newTypeParent [
	^ FQTypeQuery new type: FamixStClass
]

{ #category : #tests }
FQBinaryQueryTest >> parentQueriesResult [
	^ {self firstParentOfQuery.
	self secondParentOfQuery}
		collect: [ :q | q runOn: helper classesAndMethods ]
]

{ #category : #parents }
FQBinaryQueryTest >> secondParentOfQuery [
	^ query parents second
]

{ #category : #tests }
FQBinaryQueryTest >> testBeChildOf [
	| parents |
	parents := {self newBooleanParent.
	self newTypeParent}.
	query := self unConfiguredQuery beChildOf: parents.

	self assertCollection: query parents hasSameElements: parents.

	self assert: (parents first children includes: query).
	self assert: (parents second children includes: query)
]

{ #category : #tests }
FQBinaryQueryTest >> testEquals [
	super testEquals.
	
	"Different children"
	self
		deny: query
		equals:
			(self actualClass new
				beChildOf:
					{self newBooleanParent.
					self newTypeParent})
]

{ #category : #tests }
FQBinaryQueryTest >> testIsValid [
	self
		deny:
			(self unConfiguredQuery
				beChildOf:
					{self newTypeParent.
					self newInvalidParent}) isValid
]

{ #category : #tests }
FQBinaryQueryTest >> testParentSequence [
	"One generation"
	self
		assertCollection: query parentSequence
		hasSameElements:
			{self firstParentOfQuery.
			self secondParentOfQuery.
			query}.

	"Two generations"
	query parents do: [ :parent | parent beChildOf: FQMockQuery new ].
	self
		assertCollection: query parentSequence
		hasSameElements:
			{self firstParentOfQuery parent.
			self firstParentOfQuery.
			self secondParentOfQuery parent.
			self secondParentOfQuery.
			query}
]

{ #category : #tests }
FQBinaryQueryTest >> testParents [
	| newParents previousParents |
	newParents := {self newBooleanParent.
	self newBooleanParent}.
	previousParents := query parents.

	query parents: newParents.
	self assert: query parents equals: newParents.
	self deny: (query parents includesAny: previousParents)
]

{ #category : #tests }
FQBinaryQueryTest >> testPrepareRemoval [
	| parents |
	parents := query parents.

	query prepareRemoval.
	
	self assert: query parents isEmpty.
	parents
		do: [ :parent | self deny: (parent children includes: query) ]
]

{ #category : #tests }
FQBinaryQueryTest >> testResetParents [
	query resetParents.
	self assert: query parents isEmpty
]

{ #category : #tests }
FQBinaryQueryTest >> testResult [
	query parents
		do:
			[ :parent | parent parent: (FQMockQuery new result: helper classesAndMethods) ].
	self
		assertCollection: query result
		hasSameElements: (query runOn: self parentQueriesResult)
]

{ #category : #tests }
FQBinaryQueryTest >> testRunOn [
	self assert: self expectedResult isNotEmpty.
	self
		assertCollection:
			(query runOn: self parentQueriesResult)
		hasSameElements: self expectedResult
]