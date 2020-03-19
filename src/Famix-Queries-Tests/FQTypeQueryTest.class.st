Class {
	#name : #FQTypeQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQTypeQueryTest >> actualClass [
	^ FQTypeQuery
]

{ #category : #tests }
FQTypeQueryTest >> testDisplayOn [
	query := self actualClass forType: FamixTClass.
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals: 'aMooseGroup allUsing: FamixTClass'
]

{ #category : #tests }
FQTypeQueryTest >> testRunOn [
	| queryResult expectedResult |
	
	query := self actualClass forType: FamixTClass.
	
	queryResult := query runOn: model.
	expectedResult := model allUsing: FamixTClass.
	
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]
