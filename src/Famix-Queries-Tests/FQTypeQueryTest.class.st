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
	self testDisplayOnClass.
	self testDisplayOnSeveralTypes
]

{ #category : #tests }
FQTypeQueryTest >> testDisplayOnClass [
	query := self actualClass forType: FamixStClass.
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals: 'aMooseGroup allWithType: FamixStClass'
]

{ #category : #tests }
FQTypeQueryTest >> testDisplayOnSeveralTypes [
	query := self actualClass
		forTypes:
			{FamixStClass.
			FamixTMethod}.
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals:
			'(aMooseGroup allWithType: FamixStClass) | (aMooseGroup allUsing: FamixTMethod)'
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
	self testRunOnClass.
	self testRunOnSeveralTypes
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
FQTypeQueryTest >> testRunOnSeveralTypes [
	| queryResult expectedResult |
	
	query := self actualClass forTypes: {FamixStClass. FamixTMethod}.
	
	queryResult := query runOn: model.
	expectedResult := (model allWithType: FamixStClass) | (model allUsing: FamixTMethod).
	
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

{ #category : #tests }
FQTypeQueryTest >> testStoreOn [
	| generatedQuery |
	query := self actualClass new.
	query types: (query availableTypesFor: model).
	
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	
	self assert: generatedQuery class equals: self actualClass.
	self
		assertCollection: generatedQuery types
		hasSameElements: query types
]
