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
	self testDisplayOnTrait.
	self testDisplayOnClass
]

{ #category : #tests }
FQTypeQueryTest >> testDisplayOnClass [
	query := self actualClass forType: FamixStClass.
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals: 'aMooseGroup allWithType: FamixStClass'
]

{ #category : #tests }
FQTypeQueryTest >> testDisplayOnTrait [
	query := self actualClass forType: FamixTClass.
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals: 'aMooseGroup allUsing: FamixTClass'
]

{ #category : #tests }
FQTypeQueryTest >> testRunOn [
	self testRunOnTrait.
	self testRunOnClass
]

{ #category : #tests }
FQTypeQueryTest >> testRunOnClass [
	| queryResult expectedResult |
	
	query := self actualClass forType: FamixStClass.
	
	queryResult := query runOn: model.
	expectedResult := model allWithType: FamixStClass.
	
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]

{ #category : #tests }
FQTypeQueryTest >> testRunOnTrait [
	| queryResult expectedResult |
	
	query := self actualClass forType: FamixTClass.
	
	queryResult := query runOn: model.
	expectedResult := model allUsing: FamixTClass.
	
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]
