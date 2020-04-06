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

{ #category : #navigation }
FQQueryBuilderTest >> testAddAllAssociation [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildNavigationQuery.
	builder query availableAssociations
		do: [ :assoc | builder addAssociation: assoc ].
	self
		assert: builder query association class
		identicalTo: FQAllAssociationsNavigationQueryStrategy
]

{ #category : #navigation }
FQQueryBuilderTest >> testAddAssociation [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildNavigationQuery.
	builder addAssociation: FamixTInheritance.
	self
		assert: builder query association associations
		equals: {FamixTInheritance} asSet
]

{ #category : #navigation }
FQQueryBuilderTest >> testBuildNavigationQuery [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildNavigationQuery.
	self assert: builder query class identicalTo: FQNavigationQuery
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

{ #category : #navigation }
FQQueryBuilderTest >> testChangeQueryNavigationDirection [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildNavigationQuery.
	builder
		changeQueryNavigationDirection: FQIncomingNavigationQueryStrategy.
	self
		assert: builder query direction
		identicalTo: FQIncomingNavigationQueryStrategy
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

{ #category : #navigation }
FQQueryBuilderTest >> testRemoveAssociation [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildNavigationQuery.
	builder query availableAssociations
		do: [ :assoc | builder addAssociation: assoc ].
	builder removeAssociation: FamixTInvocation.
	self
		assert: builder query association class
		identicalTo: FQAssociationNavigationQueryStrategy.
	self
		assert: builder query association associations
		equals:
			{FamixTAccess.
			FamixTReference.
			FamixTInheritance} asSet
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
