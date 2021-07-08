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
	^ query subqueries first
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
	^ FQNavigationQuery incoming
		associations:
			{FamixStReference.
			FamixStInheritance}
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
FQBinaryQueryTest >> newStringParent [
	^ FQStringQuery new
		property: #name;
		comparator: #beginsWith:;
		valueToCompare: 'LANP'
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
	^ query subqueries second
]

{ #category : #tests }
FQBinaryQueryTest >> testBeChildOf [
	| parents |
	parents := {self newBooleanParent.
	self newTypeParent}.
	query := self unConfiguredQuery beChildOf: parents.

	self assertCollection: query subqueries hasSameElements: parents.

	self assert: (parents first children includes: query).
	self assert: (parents second children includes: query)
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
	query subqueries first beChildOf: self newBooleanParent.
	query subqueries second beChildOf: self newStringParent.
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
	previousParents := query subqueries.

	query subqueries: newParents.
	self assert: query subqueries equals: newParents.
	self deny: (query subqueries includesAny: previousParents)
]

{ #category : #tests }
FQBinaryQueryTest >> testResult [
	query subqueries
		do:
			[ :parent | parent parent: (FQRootQuery new result: helper classesAndMethods) ].
	self
		assertCollection: query result
		hasSameElements: (query runOn: self parentQueriesResult)
]

{ #category : #'tests - running' }
FQBinaryQueryTest >> testRunOn [
	self assert: self expectedResult isNotEmpty.
	self
		assertCollection:
			(query runOn: self parentQueriesResult)
		hasSameElements: self expectedResult
]
