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
	self assert: builder query class == FQScopeQuery
]
