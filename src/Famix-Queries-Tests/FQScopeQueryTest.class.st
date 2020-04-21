Class {
	#name : #FQScopeQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQScopeQueryTest >> actualClass [
	^ FQScopeQuery
]

{ #category : #'tests - available parameters' }
FQScopeQueryTest >> testAvailableDirections [
	query := self actualClass new.
	self
		assertCollection: query availableDirections
		includesAll: FQAbstractScopeDirection allSubclasses
]

{ #category : #'tests - available parameters' }
FQScopeQueryTest >> testAvailableScopesFor [
	| availableScopes |
	query := self actualClass new directionStrategy: FQScopeUpDownDirection.
	availableScopes := query availableScopesFor: model.
	self deny: (availableScopes anySatisfy: #isTrait).
	self
		assert:
			(availableScopes
				allSatisfy: [ :scope | scope inheritsFrom: FamixStEntity ]).
	availableScopes
		do:
			[ :scope | self assert: (availableScopes occurrencesOf: scope) equals: 1 ]
]

{ #category : #'tests - printing' }
FQScopeQueryTest >> testDisplayOn [
	query := FQScopeQuery
		forScope: FamixStMethod
		direction: FQAbstractScopeDirection defaultDirection.
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			'(MooseObjectQueryResult withAll: aMooseGroup) withScope: FamixStMethod'
]

{ #category : #tests }
FQScopeQueryTest >> testEquals [
	query := FQScopeQuery
		forScope: FamixStMethod
		direction: FQAbstractScopeDirection defaultDirection.

	"Same query"
	self
		assert: query
		equals:
			(FQScopeQuery
				forScope: FamixStMethod
				direction: FQAbstractScopeDirection defaultDirection).

	"Different direction"
	self
		deny: query
		equals:
			(FQScopeQuery
				forScope: FamixStClass
				direction: FQAbstractScopeDirection defaultDirection).

	"Different association"
	self
		deny: query
		equals:
			(FQScopeQuery forScope: FamixStMethod direction: FQScopeDownDirection).

	"Different class of query"
	self deny: query equals: (FQBooleanQuery fromProperty: #isAbstract)
]

{ #category : #'tests - running' }
FQScopeQueryTest >> testRunOn [
	| classes queryResult expectedResult |
	classes := model allModelClasses.

	query := FQScopeQuery
		forScope: FamixStMethod
		direction: FQScopeDownDirection.
	queryResult := query runOn: classes.

	expectedResult := ((MooseQueryResult new newObjectResultWith: classes)
		toScope: FamixStMethod) asMooseGroup.

	self assert: expectedResult isNotEmpty.
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]

{ #category : #'tests - printing' }
FQScopeQueryTest >> testStoreOn [
	| generatedQuery |
	query := self actualClass new.
	query directionStrategy: query availableDirections first.
	query scope: (query availableScopesFor: model) first.
	
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	
	self assert: generatedQuery class identicalTo: self actualClass.
	self assert: generatedQuery direction identicalTo: query direction.
	self assert: generatedQuery scope identicalTo: query scope
]
