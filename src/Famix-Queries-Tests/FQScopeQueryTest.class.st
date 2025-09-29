Class {
	#name : 'FQScopeQueryTest',
	#superclass : 'FQUnaryQueryTest',
	#category : 'Famix-Queries-Tests-Unary',
	#package : 'Famix-Queries-Tests',
	#tag : 'Unary'
}

{ #category : 'running' }
FQScopeQueryTest >> actualClass [
	^ FQScopeQuery
]

{ #category : 'running' }
FQScopeQueryTest >> expectedPrintOnString [
	^ 'a FQScopeQuery (Up to Methods)'
]

{ #category : 'running' }
FQScopeQueryTest >> expectedResult [
	^ ((MooseQueryResult new newObjectResultWith: helper classes)
		atScope: FamixStMethod) asMooseGroup
]

{ #category : 'running' }
FQScopeQueryTest >> newQuery [
	^ self unConfiguredQuery
		scope: FamixStMethod;
		directionStrategy: FQAbstractScopeDirection defaultDirection
]

{ #category : 'tests - available parameters' }
FQScopeQueryTest >> testAvailableScopesFor [
	| availableScopes |
	availableScopes := query availableScopesFor: helper modelExample.
	self deny: (availableScopes anySatisfy: #isTrait).
	availableScopes
		do: [ :scope | 
			self assert: (scope inheritsFrom: FamixStEntity).
			self assert: (availableScopes occurrencesOf: scope) equals: 1 ]
]

{ #category : 'tests - available parameters' }
FQScopeQueryTest >> testDirectionStrategies [
	self
		assertCollection: self unConfiguredQuery directionStrategies
		includesAll: FQAbstractScopeDirection allSubclasses
]

{ #category : 'tests - printing' }
FQScopeQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			'(MooseObjectQueryResult withAll: aMooseGroup) atScope: FamixStMethod'
]

{ #category : 'tests' }
FQScopeQueryTest >> testIsValid [
	super testIsValid.
	self assert: (self newQuery scope: 'Not a scope') isValid.
	self
		deny: (self newQuery directionStrategy: 'Not a direction') isValid
]

{ #category : 'tests - printing' }
FQScopeQueryTest >> testName [
	self assert: query name equals: 'Up to Methods'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Scope Query'
]

{ #category : 'tests - running' }
FQScopeQueryTest >> testRunOn [

	self assertCollection: (query runOn: helper classes) hasSameElements: self expectedResult
]

{ #category : 'tests' }
FQScopeQueryTest >> testSyntacticSugar [
	query := self actualClass up scope: FamixStClass.
	self assert: query directionStrategy identicalTo: FQScopeUp.
	self assert: query scope identicalTo: FamixStClass
]
