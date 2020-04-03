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
		newFromKeys: {#up . #upAndDown . #down}
		andValues:
			{FQScopeUpDirection.
			FQScopeUpDownDirection.
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
