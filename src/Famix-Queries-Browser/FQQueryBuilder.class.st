Class {
	#name : #FQQueryBuilder,
	#superclass : #Object,
	#instVars : [
		'query',
		'entities',
		'scopingDirections'
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
	^ MooseGroup withAll: model
]

{ #category : #scope }
FQQueryBuilder >> availableScopes [
	^ query availableScopesFor: entities
]

{ #category : #scope }
FQQueryBuilder >> buildScopeQuery: aDirectionSymbol [
	self
		flag: 'nil. Will not work when we want to display queries dinamically'.
	query := FQScopeQuery
		forScope: nil
		direction: (scopingDirections at: aDirectionSymbol)
]

{ #category : #scope }
FQQueryBuilder >> changeQueryScope: aScope [
	query scope: aScope
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
	self initializeScopingDirections
]

{ #category : #initialization }
FQQueryBuilder >> initializeScopingDirections [
	scopingDirections := Dictionary
		newFromPairs:
			{#up.
			FQScopeUpDirection.
			#upAndDown.
			FQScopeUpDownDirection.
			#down.
			FQScopeDownDirection}
]

{ #category : #accessing }
FQQueryBuilder >> query [
	^ query
]

{ #category : #accessing }
FQQueryBuilder >> query: anObject [
	query := anObject
]
