Class {
	#name : #FQStringQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #helpers }
FQStringQueryTest >> actualClass [
	^ FQStringQuery
]

{ #category : #'tests - available parameters' }
FQStringQueryTest >> testAvailablePropertiesFor [
	| availableProperties |
	query := self actualClass new.
	availableProperties := query
		availablePropertiesFor: classesAndMethods.
		
	availableProperties
		do: [ :propertySelector | 
			self assert: propertySelector isSymbol.
			classesAndMethods
				do:
					[ :entity | self assert: ((entity perform: propertySelector) isKindOf: String) ] ]
]

{ #category : #'tests - printing' }
FQStringQueryTest >> testDisplayOn [
	query := FQStringQuery forProperty: #name comparator: #includesSubstring:  withValue: 'LANP'.

	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup select: [ :entity | entity name includesSubstring: ''LANP'' ]'
]

{ #category : #tests }
FQStringQueryTest >> testEquals [
	query := self actualClass
		forProperty: #name
		comparator: #includesSubstring:
		withValue: 'LAN'.

	"Same query"
	self
		assert: query
		equals:
			(self actualClass
				forProperty: #name
				comparator: #includesSubstring:
				withValue: 'LAN').

	"Different property"
	self
		deny: query
		equals:
			(self actualClass
				forProperty: #selector
				comparator: #includesSubstring:
				withValue: 'LAN').

	"Different comparator"
	self
		deny: query
		equals:
			(self actualClass
				forProperty: #name
				comparator: #beginsWith:
				withValue: 'LAN').

	"Different value to compare"
	self
		deny: query
		equals:
			(self actualClass
				forProperty: #name
				comparator: #includesSubstring:
				withValue: 'Toto').

	"Different class of query"
	self deny: query equals: (FQBooleanQuery forProperty: #isAbstract)
]

{ #category : #tests }
FQStringQueryTest >> testIsValid [
	query := self actualClass
		forProperty: #name
		comparator: #includesSubString:
		withValue: 'LAN'.
	self assert: query isValid.

	query := self actualClass
		forProperty: 'Not a selector'
		comparator: #includesSubString:
		withValue: 'LAN'.
	self deny: query isValid.

	query := self actualClass
		forProperty: #name
		comparator: 'Not a comparator'
		withValue: 'LAN'.
	self deny: query isValid.

	query := self actualClass
		forProperty: #name
		comparator: #includesSubString:
		withValue: 10.
	self deny: query isValid.
	
	query := self actualClass new.
	self deny: query isValid
]

{ #category : #tests }
FQStringQueryTest >> testName [
	query := self actualClass
		forProperty: #name
		comparator: #includesSubstring:
		withValue: 'LAN'.
	self
		assert: query name
		equals: 'name includesSubstring: ''LAN'''.
	query := self actualClass new.
	self assert: query name equals: 'Invalid String Query'
]

{ #category : #tests }
FQStringQueryTest >> testPrintOn [
	query := self actualClass
		forProperty: #name
		comparator: #includesSubstring:
		withValue: 'LAN'.
	self
		assert: query printString
		equals: 'a FQStringQuery (name includesSubstring: ''LAN'')'
]

{ #category : #'tests - running' }
FQStringQueryTest >> testRunOn [
	| classes queryResult expectedResult |	
	classes := model allModelClasses select: #isInstanceSide.
	
	query := self actualClass forProperty: #name comparator: #includesSubstring:  withValue: 'LANP'.
	queryResult := query runOn: classes.
	
	expectedResult := #('LANPool' 'LANPacket' 'LANPrintServer').
	
	self assert: queryResult size equals: expectedResult size.
	self
		assertCollection: (queryResult collect: #name)
		hasSameElements: expectedResult
]

{ #category : #'tests - printing' }
FQStringQueryTest >> testStoreOn [
	| generatedQuery |
	query := self actualClass new.
	query property: (query availablePropertiesFor: model allModelClasses) first.
	query comparator: query availableComparators first.
	query valueToCompare: 'pattern'.
	
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	
	self assert: generatedQuery class equals: self actualClass.
	self assert: generatedQuery property equals: query property.
	self assert: generatedQuery comparator equals: query comparator.
	self assert: generatedQuery valueToCompare equals: query valueToCompare
]
