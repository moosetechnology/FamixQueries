Class {
	#name : #FQQueryBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'entities'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #running }
FQQueryBuilderTest >> setUp [
	super setUp.
	entities
		ifNil: [ | model |
			model := FamixStModel new.
			MoosePharoImporterTask new
				importerClass: SmalltalkImporter;
				model: model;
				addFromPackageNamed: #'Moose-TestResources-LAN';
				run.
			entities := MooseGroup withAll: model ]
]

{ #category : #tests }
FQQueryBuilderTest >> testAvailableScopes [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildScopeQuery: #down.
	self assert: (builder availableScopes noneSatisfy: #isTrait)
]

{ #category : #tests }
FQQueryBuilderTest >> testBuildScopeQuery [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildScopeQuery: #down.
	self assert: builder query class identicalTo: FQScopeQuery
]

{ #category : #tests }
FQQueryBuilderTest >> testChangeQueryScope [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	
	builder buildScopeQuery: #up.
	self 
		assert: builder query direction 
		identicalTo: FQScopeUpDirection.
	
	builder buildScopeQuery: #upAndDown.
	self
		assert: builder query direction
		identicalTo: FQScopeUpDownDirection.
	
	builder buildScopeQuery: #down.
	self
		assert: builder query direction
		identicalTo: FQScopeDownDirection
]
