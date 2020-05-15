Class {
	#name : #FQBooleanQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #helpers }
FQBooleanQueryTest >> actualClass [
	^ FQBooleanQuery
]

{ #category : #'tests - available parameters' }
FQBooleanQueryTest >> testAvailablePropertiesFor [
	| availableProperties |
	query := self actualClass new.
	availableProperties := query
		availablePropertiesFor: classesAndMethods.
		
	availableProperties
		do: [ :propertySelector | 
			self assert: propertySelector isSymbol.
			classesAndMethods
				do:
					[ :entity | self assert: ((entity perform: propertySelector) isKindOf: Boolean) ] ]
]

{ #category : #'tests - printing' }
FQBooleanQueryTest >> testDisplayOn [
	query := self actualClass forProperty: #isInstanceSide.
	
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup select: [ :entity | entity isInstanceSide ]'
]

{ #category : #tests }
FQBooleanQueryTest >> testEquals [
	query := self actualClass forProperty: #isInstanceSide.
	
	"Same query"
	self
		assert: query
		equals: (self actualClass forProperty: #isInstanceSide).

	"Different property"
	self deny: query equals: (self actualClass forProperty: #isAbstract).
	
	"Different class of query"
	self
		deny: query
		equals:
			(FQNumericQuery
				forProperty: #numberOfMethods
				comparator: #<=
				withValue: 5)
]

{ #category : #tests }
FQBooleanQueryTest >> testIsValid [
	query := self actualClass forProperty: #isAbstract.
	self assert: query isValid.

	query property: 'Not a selector'.
	self deny: query isValid.

	query := self actualClass new.
	self deny: query isValid
]

{ #category : #'tests - printing' }
FQBooleanQueryTest >> testName [
	query := self actualClass forProperty: #isAbstract.
	self assert: query name equals: 'isAbstract'.
	query := self actualClass new.
	self assert: query name equals: 'Invalid Boolean Query'
]

{ #category : #'tests - printing' }
FQBooleanQueryTest >> testPrintOn [
	query := self actualClass forProperty: #isAbstract.
	self
		assert: query printString
		equals: 'a FQBooleanQuery (isAbstract)'
]

{ #category : #'tests - running' }
FQBooleanQueryTest >> testRunOn [
	| queryResult expectedResult |
	
	query := self actualClass forProperty: #isAbstract.
	queryResult := query runOn: classesAndMethods.
	
	expectedResult := classesAndMethods select: #isAbstract.
	
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]

{ #category : #'tests - printing' }
FQBooleanQueryTest >> testStoreOn [
	| generatedQuery |
	query := self actualClass new.
	query property: (query availablePropertiesFor: classesAndMethods) first.
	
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	
	self assert: generatedQuery class equals: self actualClass.
	self assert: generatedQuery property equals: query property
]
