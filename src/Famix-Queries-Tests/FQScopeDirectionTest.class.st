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
	self assertCollection: (MQScopeDownStrategy availableScopesFor: helper classes) hasSameElements: (helper classes first allChildrenTypes reject: #isTrait)
]

{ #category : #'tests - available scopes' }
FQScopeDirectionTest >> availableScopesUpDownTest [
	self
		assertCollection: (MQScopeAllStrategy availableScopesFor: helper classes)
		hasSameElements: ({helper classes first allParentTypes . helper classes first allChildrenTypes} flatten asSet reject: #isTrait)
]

{ #category : #'tests - available scopes' }
FQScopeDirectionTest >> availableScopesUpTest [
	self assertCollection: (MQScopeUpStrategy availableScopesFor: helper classes) hasSameElements: (helper classes first allParentTypes reject: #isTrait)
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
	directionStrategy := MQScopeUpStrategy.
	self
		assert:
			((directionStrategy availableScopesFor: helper classes)
				noneSatisfy: #isTrait).
	
	directionStrategy := MQScopeAllStrategy.
	self
		assert:
			((directionStrategy availableScopesFor: helper classes)
				noneSatisfy: #isTrait).

	directionStrategy := MQScopeDownStrategy.
	self
		assert:
			((directionStrategy availableScopesFor: helper classes)
				noneSatisfy: #isTrait)
]

{ #category : #tests }
FQScopeDirectionTest >> testScopeOn [
	| direction |
	direction := MQScopeUpStrategy.
	(direction scope: FamixStPackage on: helper methods)
		do: [ :result | self assert: result class identicalTo: FamixStPackage ].
	
	direction := MQScopeAllStrategy.
	(direction scope: FamixStClass on: helper methods)
		do: [ :result | self assert: result class identicalTo: FamixStClass ].
	
	direction := MQScopeDownStrategy.
	(direction scope: FamixStMethod on: helper classes)
		do: [ :result | self assert: result class identicalTo: FamixStMethod ]
]
