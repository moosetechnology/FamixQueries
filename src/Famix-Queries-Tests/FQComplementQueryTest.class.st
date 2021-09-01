Class {
	#name : #FQComplementQueryTest,
	#superclass : #FQUnaryQueryTest,
	#instVars : [
		'parentQuery'
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
	^ helper classes copyWithoutAll: (parentQuery runOn: helper classes)
]

{ #category : #running }
FQComplementQueryTest >> newQuery [

	parentQuery := FQBooleanQuery new property: #isInstanceSide.
	^ self unConfiguredQuery beChildOf: parentQuery
]

{ #category : #'tests - printing' }
FQComplementQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			(String
				streamContents: [ :s | 
					s << 'aMooseGroup copyWithoutAll: ('.
					parentQuery displayOn: s.
					s << ')' ])
]

{ #category : #tests }
FQComplementQueryTest >> testIsValid [
	super testIsValid.
	query prepareRemoval.
	self deny: query isValid.
	query beChildOf: FQBooleanQuery new.
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
FQComplementQueryTest >> testResult [

	| tempQuery |
	tempQuery := FQBooleanQuery property: #isStub.
	tempQuery beChildOf: self newParentQuery.
	query queryToNegate: tempQuery.

	self assertEmpty: tempQuery result.
	"Since the result of the query to negate is empty, the complement query should contain the complement of empty which is all. So, it is the same as the result of the root query"
	self
		assertCollection: query result
		hasSameElements: (query runOn: self newParentQuery result)
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
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	self assert: generatedQuery class identicalTo: self actualClass.
	self assert: (generatedQuery hasSameParametersAs: query)
]
