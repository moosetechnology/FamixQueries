Class {
	#name : #FQScopeQueryBuilder,
	#superclass : #FQAbstractQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQScopeQueryBuilder class >> queryClass [
	^ FQScopeQuery
]

{ #category : #'available parameters' }
FQScopeQueryBuilder >> availableScopeDirections [
	^ query availableDirections
]

{ #category : #'available parameters' }
FQScopeQueryBuilder >> availableScopes [
	^ query availableScopesFor: self entities
]

{ #category : #'changing parameters' }
FQScopeQueryBuilder >> changeQueryDirection: aDirection [
	query directionStrategy: aDirection.
	query scope: nil.
	self availableScopes
		ifEmpty: [ FQImpossibleQuery signal: 'No scope available' ].
	query scope: self availableScopes first.
	self resetResult
]

{ #category : #'changing parameters' }
FQScopeQueryBuilder >> changeQueryScope: aScope [
	query
		scope: (aScope ifNil: [ self availableScopes first ] ifNotNil: [ aScope ]).
	self resetResult
]

{ #category : #initialization }
FQScopeQueryBuilder >> initializeQuery [
	super initializeQuery.
	query directionStrategy: self availableScopeDirections first.
	self availableScopes
		ifEmpty: [ (FQImpossibleQuery new builder: self) signal ].
	query scope: self availableScopes first
]

{ #category : #initialization }
FQScopeQueryBuilder >> initializeQueryFromParent: aQuery [
	super initializeQueryFromParent: aQuery.
	query directionStrategy: self availableScopeDirections first.
	self availableScopes
		ifEmpty: [ (FQImpossibleQuery new builder: self) signal ].
	query scope: self availableScopes first
]
