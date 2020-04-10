Class {
	#name : #FQScopeQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQScopeQueryTest >> actualClass [
	^ FQScopeQuery
]

{ #category : #tests }
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

{ #category : #tests }
FQScopeQueryTest >> testStoreOn [
	| generatedQuery |
	query := self actualClass new.
	query direction: query availableDirections first.
	query scope: (query availableScopesFor: model) first.
	
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	
	self assert: generatedQuery class identicalTo: self actualClass.
	self assert: generatedQuery direction identicalTo: query direction.
	self assert: generatedQuery scope identicalTo: query scope
]
