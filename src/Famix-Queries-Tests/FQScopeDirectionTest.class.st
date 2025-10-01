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
FQScopeDirectionTest >> testAvailableContainedEntitiesScopes [

	| directionStrategy |
	directionStrategy := FQScopeContainedEntities.
	self assertCollection: (directionStrategy availableScopesFor: helper classes) hasSameElements: (helper classes first allContainedEntityTypes reject: #isTrait)
]

{ #category : 'tests - available scopes' }
FQScopeDirectionTest >> testAvailableContainersScopes [

	| directionStrategy |
	directionStrategy := FQScopeContainers.
	self assertCollection: (directionStrategy availableScopesFor: helper classes) hasSameElements: (helper classes first allContainerTypes reject: #isTrait)
]

{ #category : 'tests - available scopes' }
FQScopeDirectionTest >> testAvailableScopesIncludesNoTrait [

	| directionStrategy |
	directionStrategy := FQScopeContainers.
	self assert: ((directionStrategy availableScopesFor: helper classes) noneSatisfy: #isTrait).

	directionStrategy := FQScopeContainedEntities.
	self assert: ((directionStrategy availableScopesFor: helper classes) noneSatisfy: #isTrait)
]

{ #category : 'tests' }
FQScopeDirectionTest >> testScopeOn [

	| direction |
	direction := FQScopeContainers.
	(direction scope: FamixStPackage on: helper methods anyOne) do: [ :result | self assert: result class identicalTo: FamixStPackage ].

	direction := FQScopeContainedEntities.
	(direction scope: FamixStMethod on: helper classes anyOne) do: [ :result | self assert: result class identicalTo: FamixStMethod ]
]
