Class {
	#name : #FQScopeDirectionTest,
	#superclass : #TestCase,
	#instVars : [
		'helper'
	],
	#category : #'Famix-Queries-Tests-Tools'
}

{ #category : #'tests - available scopes' }
FQScopeDirectionTest >> availableScopesDownTest [
	| directionStrategy |
	directionStrategy := FQScopeDown.
	self
		assertCollection: (directionStrategy availableScopesFor: helper classes)
		hasSameElements: (helper classes first allChildrenTypes reject: #isTrait)
]

{ #category : #'tests - available scopes' }
FQScopeDirectionTest >> availableScopesUpDownTest [
	| directionStrategy |
	directionStrategy := FQScopeUpAndDown.
	self
		assertCollection: (directionStrategy availableScopesFor: helper classes)
		hasSameElements:
			({helper classes first allParentTypes.
			helper classes first allChildrenTypes} flatten asSet
				reject: #isTrait)
]

{ #category : #'tests - available scopes' }
FQScopeDirectionTest >> availableScopesUpTest [
	| directionStrategy |
	directionStrategy := FQScopeUp.
	self
		assertCollection: (directionStrategy availableScopesFor: helper classes)
		hasSameElements: (helper classes first allParentTypes reject: #isTrait)
]

{ #category : #running }
FQScopeDirectionTest >> setUp [
	super setUp.
	helper := FQTestsHelper current
]

{ #category : #'tests - available scopes' }
FQScopeDirectionTest >> testAvailableScopesFor [
	self availableScopesUpTest.
	self availableScopesUpDownTest.
	self availableScopesDownTest
]

{ #category : #'tests - available scopes' }
FQScopeDirectionTest >> testAvailableScopesIncludesNoTrait [
	| directionStrategy |
	directionStrategy := FQScopeUp.
	self
		assert:
			((directionStrategy availableScopesFor: helper classes)
				noneSatisfy: #isTrait).
	
	directionStrategy := FQScopeUpAndDown.
	self
		assert:
			((directionStrategy availableScopesFor: helper classes)
				noneSatisfy: #isTrait).

	directionStrategy := FQScopeDown.
	self
		assert:
			((directionStrategy availableScopesFor: helper classes)
				noneSatisfy: #isTrait)
]

{ #category : #tests }
FQScopeDirectionTest >> testScopeOn [
	| direction |
	direction := FQScopeUp.
	(direction scope: FamixStPackage on: helper methods)
		do: [ :result | self assert: result class identicalTo: FamixStPackage ].
	
	direction := FQScopeUpAndDown.
	(direction scope: FamixStClass on: helper methods)
		do: [ :result | self assert: result class identicalTo: FamixStClass ].
	
	direction := FQScopeDown.
	(direction scope: FamixStMethod on: helper classes)
		do: [ :result | self assert: result class identicalTo: FamixStMethod ]
]
