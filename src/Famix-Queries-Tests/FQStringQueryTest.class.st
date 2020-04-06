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
