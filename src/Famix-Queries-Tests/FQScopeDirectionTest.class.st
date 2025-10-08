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

	self
		assertCollection: (MQScopeContainedEntitiesStrategy availableScopesFor: helper classes)
		hasSameElements: (helper classes first allContainedEntityTypes reject: #isTrait)
]

{ #category : 'tests - available scopes' }
FQScopeDirectionTest >> testAvailableContainersScopes [

	self
		assertCollection: (MQScopeContainersStrategy availableScopesFor: helper classes)
		hasSameElements: (helper classes first allContainerTypes reject: #isTrait)
]

{ #category : 'tests - available scopes' }
FQScopeDirectionTest >> testAvailableScopesIncludesNoTrait [

	| directionStrategy |
	directionStrategy := MQScopeContainersStrategy.
	self assert: ((directionStrategy availableScopesFor: helper classes) noneSatisfy: #isTrait).

	directionStrategy := MQScopeContainedEntitiesStrategy.
	self assert: ((directionStrategy availableScopesFor: helper classes) noneSatisfy: #isTrait)
]

{ #category : 'tests' }
FQScopeDirectionTest >> testScopeOn [

	| direction |
	direction := MQScopeContainersStrategy.
	(direction scope: FamixStPackage on: helper methods anyOne) do: [ :result | self assert: result class identicalTo: FamixStPackage ].

	direction := MQScopeContainedEntitiesStrategy.
	(direction scope: FamixStMethod on: helper classes anyOne) do: [ :result | self assert: result class identicalTo: FamixStMethod ]
]
