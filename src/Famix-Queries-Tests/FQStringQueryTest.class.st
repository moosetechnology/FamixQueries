Class {
	#name : #FQStringQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
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
	query := FQStringQuery fromProperty: #name comparator: #includesSubstring:  withValue: 'LANP'.

	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup select: [ :entity | entity name includesSubstring: ''LANP'' ]'
]

{ #category : #tests }
FQStringQueryTest >> testEquals [
	query := self actualClass
		fromProperty: #name
		comparator: #includesSubstring:
		withValue: 'LAN'.

	"Same query"
	self
		assert: query
		equals:
			(self actualClass
				fromProperty: #name
				comparator: #includesSubstring:
				withValue: 'LAN').

	"Different property"
	self
		deny: query
		equals:
			(self actualClass
				fromProperty: #selector
				comparator: #includesSubstring:
				withValue: 'LAN').

	"Different comparator"
	self
		deny: query
		equals:
			(self actualClass
				fromProperty: #name
				comparator: #beginsWith:
				withValue: 'LAN').

	"Different value to compare"
	self
		deny: query
		equals:
			(self actualClass
				fromProperty: #name
				comparator: #includesSubstring:
				withValue: 'Toto').

	"Different class of query"
	self deny: query equals: (FQBooleanQuery fromProperty: #isAbstract)
]

{ #category : #'tests - running' }
FQStringQueryTest >> testRunOn [
	| classes queryResult expectedResult |	
	classes := model allModelClasses select: #isInstanceSide.
	
	query := FQStringQuery fromProperty: #name comparator: #includesSubstring:  withValue: 'LANP'.
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
