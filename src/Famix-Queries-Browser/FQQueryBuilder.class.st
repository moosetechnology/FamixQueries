Class {
	#name : #FQQueryBuilder,
	#superclass : #Object,
	#instVars : [
		'query',
		'entities',
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
	^ query availableAssociationsFor: entities
]

{ #category : #navigation }
FQQueryBuilder >> availableDirections [
	^ query availableDirections
]

{ #category : #properties }
FQQueryBuilder >> availableProperties [
	^ query availablePropertiesFor: entities
]

{ #category : #properties }
FQQueryBuilder >> availablePropertyQueryTypes [
	^ query availablePropertyQueryTypes
]

{ #category : #scope }
FQQueryBuilder >> availableScopeDirections [
	^ query availableDirections
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
FQQueryBuilder >> buildPropertyQuery [
	query := FQBooleanQuery new
]

{ #category : #properties }
FQQueryBuilder >> buildPropertyQuery: aTypeQueryClass [
	query := aTypeQueryClass new
]

{ #category : #scope }
FQQueryBuilder >> buildScopeQuery [
	query := FQScopeQuery new.
	query direction: query availableDirections first
]

{ #category : #scope }
FQQueryBuilder >> buildScopeQueryWithDirection: aDirection [
	self
		flag: 'nil. Will not work when we want to display queries dinamically'.
	query := FQScopeQuery forScope: nil direction: aDirection
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

{ #category : #navigation }
FQQueryBuilder >> defaultAssociations [
	^ query defaultAssociations
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
	navigationAssociations := Set new
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
