Class {
	#name : #FQStringQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQStringQueryTest >> actualClass [
	^ FQStringQuery
]

{ #category : #tests }
FQStringQueryTest >> testDisplayOn [
	query := FQStringQuery fromProperty: #name comparator: #includesSubstring:  withValue: 'LANP'.

	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup select: [ :entity | entity name includesSubstring: ''LANP'' ]'
]

{ #category : #tests }
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

{ #category : #tests }
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
