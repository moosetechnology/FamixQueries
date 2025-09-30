Class {
	#name : 'FQScopeDirectionTest',
	#superclass : 'TestCase',
	#instVars : [
		'helper'
	],
	#category : 'Famix-Queries-Tests-Tools',
	#package : 'Famix-Queries-Tests',
	#tag : 'Tools'
}

{ #category : 'running' }
FQScopeDirectionTest >> setUp [
	super setUp.
	helper := FQTestsHelper new
]

{ #category : 'tests - available scopes' }
FQScopeDirectionTest >> testAvailableScopesDown [
	| directionStrategy |
	directionStrategy := FQScopeDown.
	self
		assertCollection: (directionStrategy availableScopesFor: helper classes)
		hasSameElements: (helper classes first allChildrenTypes reject: #isTrait)
]

{ #category : 'tests - available scopes' }
FQScopeDirectionTest >> testAvailableScopesIncludesNoTrait [

	| directionStrategy |
	directionStrategy := FQScopeUp.
	self assert: ((directionStrategy availableScopesFor: helper classes) noneSatisfy: #isTrait).

	directionStrategy := FQScopeDown.
	self assert: ((directionStrategy availableScopesFor: helper classes) noneSatisfy: #isTrait)
]

{ #category : 'tests - available scopes' }
FQScopeDirectionTest >> testAvailableScopesUp [
	| directionStrategy |
	directionStrategy := FQScopeUp.
	self
		assertCollection: (directionStrategy availableScopesFor: helper classes)
		hasSameElements: (helper classes first allParentTypes reject: #isTrait)
]

{ #category : 'tests' }
FQScopeDirectionTest >> testScopeOn [

	| direction |
	direction := FQScopeUp.
	(direction scope: FamixStPackage on: helper methods anyOne) do: [ :result | self assert: result class identicalTo: FamixStPackage ].

	direction := FQScopeDown.
	(direction scope: FamixStMethod on: helper classes anyOne) do: [ :result | self assert: result class identicalTo: FamixStMethod ]
]
