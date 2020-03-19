Class {
	#name : #FQNumericQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQNumericQueryTest >> actualClass [
	^ FQNumericQuery
]

{ #category : #tests }
FQNumericQueryTest >> testDisplayOn [
	query := self actualClass fromProperty: #numberOfMethods comparator: #> withValue: 10.

	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup select: [ :entity | entity numberOfMethods > 10 ]'
]

{ #category : #tests }
FQNumericQueryTest >> testRunOn [
	| classes queryResult expectedResult |	
	classes := model allModelClasses.
	
	query := self actualClass fromProperty: #numberOfMethods comparator: #> withValue: 10.
	queryResult := query runOn: classes.
	
	expectedResult := model allModelClasses
		select: [ :class | class numberOfMethods > 10 ].
	
	self assert: queryResult size equals: expectedResult size.
	self
		assertCollection: (query runOn: classes)
		hasSameElements: expectedResult
]
