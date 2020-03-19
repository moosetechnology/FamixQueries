Class {
	#name : #FQBooleanQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQBooleanQueryTest >> actualClass [
	^ FQBooleanQuery
]

{ #category : #tests }
FQBooleanQueryTest >> testDisplayOn [
	query := self actualClass fromProperty: #isInstanceSide.
	
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup select: [ :entity | entity isInstanceSide ]'
]

{ #category : #tests }
FQBooleanQueryTest >> testRunOn [
	| grp queryResult expectedResult |
	grp := model allModelClasses.
	
	query := self actualClass fromProperty: #isInstanceSide.
	queryResult := query runOn: grp.
	
	expectedResult := model allModelClasses select: #isInstanceSide.
	
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]
