Class {
	#name : #FQQueryBuilder,
	#superclass : #Object,
	#instVars : [
		'query',
		'entities',
		'scopingDirections',
		'propertyQueriesTypes',
		'navigationAssociations'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQQueryBuilder class >> default [
	^ self new
		entities: self entities;
		yourself
]

{ #category : #'plugin interface' }
FQQueryBuilder class >> entities [
	| model |
	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run.
	^ MooseGroup withAll: model allModelClasses
]

{ #category : #navigation }
FQQueryBuilder >> addAssociation: anAssociation [
	navigationAssociations add: anAssociation.
	self changeQueryAssociation
]

{ #category : #type }
FQQueryBuilder >> addTypeToQuery: aType [
	query addType: aType
]

{ #category : #navigation }
FQQueryBuilder >> availableAssociations [
	^ query availableAssociations
]

{ #category : #navigation }
FQQueryBuilder >> availableDirections [
	^ query availableDirections
]

{ #category : #properties }
FQQueryBuilder >> availableProperties [
	^ query availablePropertiesFor: entities
]

{ #category : #scope }
FQQueryBuilder >> availableScopes [
	^ query availableScopesFor: entities
]

{ #category : #type }
FQQueryBuilder >> availableTypes [
	^ query availableTypesFor: entities
]

{ #category : #navigation }
FQQueryBuilder >> buildNavigationQuery [
	query := FQNavigationQuery new
]

{ #category : #properties }
FQQueryBuilder >> buildPropertyQueryTyped: aType [
	query := (propertyQueriesTypes at: aType) new
]

{ #category : #scope }
FQQueryBuilder >> buildScopeQuery: aDirectionSymbol [
	self
		flag: 'nil. Will not work when we want to display queries dinamically'.
	query := FQScopeQuery
		forScope: nil
		direction: (scopingDirections at: aDirectionSymbol)
]

{ #category : #type }
FQQueryBuilder >> buildTypeQuery [
	query := FQTypeQuery new
]

{ #category : #navigation }
FQQueryBuilder >> changeQueryAssociation [
	(navigationAssociations includesAll: self availableAssociations)
		ifTrue: [ query association: FQAllAssociationsNavigationQueryStrategy new ]
		ifFalse: [ query
				association: (FQAssociationNavigationQueryStrategy withAll: navigationAssociations) ]
]

{ #category : #properties }
FQQueryBuilder >> changeQueryComparator: aComparator [
	^ query comparator: aComparator
]

{ #category : #navigation }
FQQueryBuilder >> changeQueryNavigationDirection: aDirection [
	query direction: aDirection
]

{ #category : #properties }
FQQueryBuilder >> changeQueryProperty: aPropertyName [
	^ query property: aPropertyName
]

{ #category : #scope }
FQQueryBuilder >> changeQueryScope: aScope [
	query scope: aScope
]

{ #category : #type }
FQQueryBuilder >> changeQueryType: aType [
	query type: aType
]

{ #category : #properties }
FQQueryBuilder >> changeQueryValueToCompare: aValue [
	^ query valueToCompare: aValue
]

{ #category : #running }
FQQueryBuilder >> createQuery [
	^ String streamContents: [ :s | query displayOn: s ]
]

{ #category : #accessing }
FQQueryBuilder >> entities [
	^ entities
]

{ #category : #accessing }
FQQueryBuilder >> entities: anObject [
	entities := anObject
]

{ #category : #initialization }
FQQueryBuilder >> initialize [
	super initialize.
	self initializeScopingDirections.
	self initializePropertyQueriesTypes.
	navigationAssociations := Set new
]

{ #category : #initialization }
FQQueryBuilder >> initializePropertyQueriesTypes [
	self flag: 'Should maybe be in query class and not here'.
	propertyQueriesTypes := OrderedDictionary
		newFromPairs:
			{#boolean.
			FQBooleanQuery.
			#number.
			FQNumericQuery.
			#string.
			FQStringQuery}
]

{ #category : #initialization }
FQQueryBuilder >> initializeScopingDirections [
	self flag: 'Should maybe be in query class and not here'.
	scopingDirections := Dictionary
		newFromPairs:
			{#up.
			FQScopeUpDirection.
			#upAndDown.
			FQScopeUpDownDirection.
			#down.
			FQScopeDownDirection}
]

{ #category : #properties }
FQQueryBuilder >> propertyTypes [
	^ propertyQueriesTypes keys
]

{ #category : #accessing }
FQQueryBuilder >> query [
	^ query
]

{ #category : #accessing }
FQQueryBuilder >> query: anObject [
	query := anObject
]

{ #category : #navigation }
FQQueryBuilder >> removeAssociation: anAssociation [
	navigationAssociations remove: anAssociation.
	self changeQueryAssociation
]

{ #category : #type }
FQQueryBuilder >> removeTypeFromQuery: aType [
	query removeType: aType
]
