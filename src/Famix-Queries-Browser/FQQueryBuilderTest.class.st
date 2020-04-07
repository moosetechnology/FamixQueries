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
FQQueryBuilderTest >> testBuildPropertyQuery [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildPropertyQuery: FQBooleanQuery.
	self assert: builder query class identicalTo: FQBooleanQuery.
	builder buildPropertyQuery: FQNumericQuery.
	self assert: builder query class identicalTo: FQNumericQuery.
	builder buildPropertyQuery: FQStringQuery.
	self assert: builder query class identicalTo: FQStringQuery
]

{ #category : #scope }
FQQueryBuilderTest >> testBuildScopeQueryWithDirection [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildScopeQueryWithDirection: FQScopeDownDirection.
	self assert: builder query class identicalTo: FQScopeQuery.
	self
		assert: builder query direction
		identicalTo: FQScopeDownDirection
]

{ #category : #type }
FQQueryBuilderTest >> testBuildTypeQuery [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildTypeQuery.
	self assert: builder query class identicalTo: FQTypeQuery
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
	
	builder buildScopeQueryWithDirection: FQScopeUpDirection.
	self 
		assert: builder query direction 
		identicalTo: FQScopeUpDirection.
	
	builder buildScopeQueryWithDirection: FQScopeUpDownDirection.
	self
		assert: builder query direction
		identicalTo: FQScopeUpDownDirection.
	
	builder buildScopeQueryWithDirection: FQScopeDownDirection.
	self
		assert: builder query direction
		identicalTo: FQScopeDownDirection
]

{ #category : #type }
FQQueryBuilderTest >> testChangeQueryType [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildTypeQuery.
	builder changeQueryType: FamixStClass.
	self assert: builder query type identicalTo: FamixStClass
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
	builder buildPropertyQuery: FQNumericQuery.
	builder changeQueryComparator: #<=.
	self assert: builder query comparator equals: #<=
]

{ #category : #properties }
FQQueryBuilderTest >> testchangeQueryProperty [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildPropertyQuery: FQBooleanQuery.
	builder changeQueryProperty: #isAbstract.
	self assert: builder query property equals: #isAbstract
]

{ #category : #properties }
FQQueryBuilderTest >> testchangeQueryValueToCompare [
	| builder |
	builder := FQQueryBuilder new
		entities: entities;
		yourself.
	builder buildPropertyQuery: FQStringQuery.
	builder changeQueryValueToCompare: 'pattern'.
	self assert: builder query valueToCompare equals: 'pattern'
]
