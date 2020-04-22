Class {
	#name : #FQTypeQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQTypeQueryTest >> actualClass [
	^ FQTypeQuery
]

{ #category : #'tests - adding - removing' }
FQTypeQueryTest >> testAddType [
	query := self actualClass forType: FamixStClass.
	query addType: FamixStMethod.
	self assert: (query types includes: FamixStMethod).
	query addType: FamixStMethod.
	self assert: (query types occurrencesOf: FamixStMethod) equals: 1
]

{ #category : #'tests - available parameters' }
FQTypeQueryTest >> testAvailableTypesFor [
	| availableTypes |
	query := self actualClass new.
	availableTypes := query availableTypesFor: model.
	self
		assertCollection: availableTypes
		includesAll: ((model allUsing: FamixTNamedEntity) collect: #class).
	availableTypes
		do:
			[ :type | self assert: (availableTypes occurrencesOf: type) equals: 1 ]
]

{ #category : #'tests - printing' }
FQTypeQueryTest >> testDisplayOn [
	self testDisplayOnTrait.
	self testDisplayOnClass.
	self testDisplayOnSeveralTypes
]

{ #category : #'tests - printing' }
FQTypeQueryTest >> testDisplayOnClass [
	query := self actualClass forType: FamixStClass.
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals: 'aMooseGroup allWithType: FamixStClass'
]

{ #category : #'tests - printing' }
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

{ #category : #'tests - printing' }
FQTypeQueryTest >> testDisplayOnTrait [
	query := self actualClass forType: FamixTClass.
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals: 'aMooseGroup allUsing: FamixTClass'
]

{ #category : #tests }
FQTypeQueryTest >> testEquals [
	query := self actualClass forType: FamixStClass.

	"Same query"
	self assert: query equals: (self actualClass forType: FamixStClass).

	"Different types"
	self
		deny: query
		equals:
			(self actualClass
				forTypes:
					{FamixStClass.
					FamixStMethod}).

	"Different class of query"
	self
		deny: query
		equals:
			(FQNumericQuery
				forProperty: #numberOfMethods
				comparator: #<=
				withValue: 5)
]

{ #category : #'tests - adding - removing' }
FQTypeQueryTest >> testRemoveType [
	query := self actualClass
		forTypes:
			{FamixStClass.
			FamixStMethod}.
	query removeType: FamixStMethod.
	self deny: (query types includes: FamixStMethod).
	self
		should: [ query removeType: FamixStClass ]
		raise: FQTypeQueryMustHaveAtLeastOneType
]

{ #category : #'tests - running' }
FQTypeQueryTest >> testRunOn [
	self testRunOnTrait.
	self testRunOnClass.
	self testRunOnSeveralTypes
]

{ #category : #'tests - running' }
FQTypeQueryTest >> testRunOnClass [
	| queryResult expectedResult |
	
	query := self actualClass forType: FamixStClass.
	
	queryResult := query runOn: model.
	expectedResult := model allWithType: FamixStClass.
	
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]

{ #category : #'tests - running' }
FQTypeQueryTest >> testRunOnSeveralTypes [
	| queryResult expectedResult |
	
	query := self actualClass forTypes: {FamixStClass. FamixTMethod}.
	
	queryResult := query runOn: model.
	expectedResult := (model allWithType: FamixStClass) | (model allUsing: FamixTMethod).
	
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]

{ #category : #'tests - running' }
FQTypeQueryTest >> testRunOnTrait [
	| queryResult expectedResult |
	
	query := self actualClass forType: FamixTClass.
	
	queryResult := query runOn: model.
	expectedResult := model allUsing: FamixTClass.
	
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]

{ #category : #'tests - printing' }
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
