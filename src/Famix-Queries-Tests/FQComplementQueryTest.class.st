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

{ #category : #tests }
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
FQComplementQueryTest >> testEquals [
	super testEquals.

	"Different parent"
	self
		deny: query
		equals: (self unConfiguredQuery beChildOf: self differentTypeOfQuery)
]

{ #category : #tests }
FQComplementQueryTest >> testIsValid [
	super testIsValid.
	query prepareRemoval.
	self deny: query isValid.
	query beChildOf: FQBooleanQuery new.
	self deny: query isValid
]

{ #category : #tests }
FQComplementQueryTest >> testName [
	self assert: query name equals: '(isInstanceSide) not'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Complement Query'
]

{ #category : #tests }
FQComplementQueryTest >> testRunOn [
	self assert: self expectedResult isNotEmpty.
	self
		assertCollection: (query runOn: helper classes)
		hasSameElements: self expectedResult
]
