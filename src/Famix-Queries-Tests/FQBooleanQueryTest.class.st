Class {
	#name : #FQBooleanQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
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
	query := self actualClass fromProperty: #isInstanceSide.
	
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup select: [ :entity | entity isInstanceSide ]'
]

{ #category : #'tests - available parameters' }
FQBooleanQueryTest >> testNoAvailableProperties [
	| availableProperties |
	query := self actualClass new.
	availableProperties := query availablePropertiesFor: model.
	
	self assert: availableProperties isEmpty
]

{ #category : #'tests - running' }
FQBooleanQueryTest >> testRunOn [
	| grp queryResult expectedResult |
	grp := classesAndMethods.
	
	query := self actualClass fromProperty: #isAbstract .
	queryResult := query runOn: grp.
	
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
