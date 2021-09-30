Class {
	#name : #FQComplementQueryTest,
	#superclass : #FQAbstractQueryTest,
	#instVars : [
		'queryToNegate'
	],
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #running }
FQComplementQueryTest >> actualClass [
	^ FQComplementQuery
]

{ #category : #running }
FQComplementQueryTest >> expectedPrintOnString [
	^ 'a FQComplementQuery ((isInstanceSide) not)'
]

{ #category : #tests }
FQComplementQueryTest >> expectedResult [

	^ helper classes copyWithoutAll: (queryToNegate runOn: helper classes)
]

{ #category : #running }
FQComplementQueryTest >> newQuery [

	queryToNegate := FQBooleanQuery new property: #isInstanceSide.
	^ self unConfiguredQuery queryToNegate: queryToNegate
]

{ #category : #tests }
FQComplementQueryTest >> newQueryToNegate [

	^ FQRootQuery new result: helper classes
]

{ #category : #'tests - printing' }
FQComplementQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			(String
				streamContents: [ :s | 
					s << 'aMooseGroup copyWithoutAll: ('.
					queryToNegate displayOn: s.
					s << ')' ])
]

{ #category : #tests }
FQComplementQueryTest >> testIsValid [

	super testIsValid.
	query prepareRemoval.
	self deny: query isValid.
	query queryToNegate: FQBooleanQuery new.
	self deny: query isValid
]

{ #category : #'tests - printing' }
FQComplementQueryTest >> testName [
	self assert: query name equals: '(isInstanceSide) not'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Negation Query'
]

{ #category : #tests }
FQComplementQueryTest >> testParentSequence [

	self assert: query parentSequence equals: #(  )
]

{ #category : #tests }
FQComplementQueryTest >> testPrepareRemoval [

	| tempQueryToNegate |
	tempQueryToNegate := self differentTypeOfQuery.
	query queryToNegate: tempQueryToNegate.

	query prepareRemoval.
	self assert: query queryToNegate isNil
]

{ #category : #tests }
FQComplementQueryTest >> testQueryToNegate [

	| tmpQueryToNegate |
	tmpQueryToNegate := self differentTypeOfQuery.
	query queryToNegate: tmpQueryToNegate.
	self assert: query queryToNegate equals: tmpQueryToNegate
]

{ #category : #tests }
FQComplementQueryTest >> testResult [

	| tempQuery |
	tempQuery := FQBooleanQuery property: #isStub.
	tempQuery beChildOf: self newQueryToNegate.
	query queryToNegate: tempQuery.

	self assertEmpty: tempQuery result.
	"Since the result of the query to negate is empty, the complement query should contain the complement of empty which is all. So, it is the same as the result of the root query"
	self
		assertCollection: query result
		hasSameElements: (query runOn: self newQueryToNegate result).
	self
		assertCollection: query result
		hasSameElements: self newQueryToNegate result
]

{ #category : #'tests - running' }
FQComplementQueryTest >> testRunOn [
	self assert: self expectedResult isNotEmpty.
	self
		assertCollection: (query runOn: helper classes)
		hasSameElements: self expectedResult
]

{ #category : #'tests - printing' }
FQComplementQueryTest >> testStoreOn [

	| generatedQuery |
	generatedQuery := self evaluate:
		                  (String streamContents: [ :s | query storeOn: s ]).
	self assert: generatedQuery class identicalTo: self actualClass.
	self assert: (generatedQuery hasSameParametersAs: query)
]
