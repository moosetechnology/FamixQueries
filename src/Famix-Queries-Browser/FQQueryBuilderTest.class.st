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

{ #category : #properties }
FQQueryBuilderTest >> testBuildPropertyQueryTyped [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildPropertyQueryTyped: #boolean.
	self assert: builder query class identicalTo: FQBooleanQuery.
	builder buildPropertyQueryTyped: #number.
	self assert: builder query class identicalTo: FQNumericQuery.
	builder buildPropertyQueryTyped: #string.
	self assert: builder query class identicalTo: FQStringQuery
]

{ #category : #scope }
FQQueryBuilderTest >> testBuildScopeQuery [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildScopeQuery: #down.
	self assert: builder query class identicalTo: FQScopeQuery
]

{ #category : #scope }
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

{ #category : #properties }
FQQueryBuilderTest >> testchangeQueryComparator [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildPropertyQueryTyped: #number.
	builder changeQueryComparator: #<=.
	self assert: builder query comparator equals: #<=
]

{ #category : #properties }
FQQueryBuilderTest >> testchangeQueryProperty [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildPropertyQueryTyped: #boolean.
	builder changeQueryProperty: #isAbstract.
	self assert: builder query property equals: #isAbstract
]

{ #category : #properties }
FQQueryBuilderTest >> testchangeQueryValueToCompare [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildPropertyQueryTyped: #string.
	builder changeQueryValueToCompare: 'pattern'.
	self assert: builder query valueToCompare equals: 'pattern'
]
