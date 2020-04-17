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
	^ query availableScopesFor: entities
]

{ #category : #'changing parameters' }
FQScopeQueryBuilder >> changeQueryDirection: aDirection [
	self flag: 'Manage this better'.
	query direction: aDirection.
	query scope: nil.
	self availableScopes
		ifEmpty: [ ImpossibleQuery signal: 'No scope available' ].
	query scope: self availableScopes first
]

{ #category : #'changing parameters' }
FQScopeQueryBuilder >> changeQueryScope: aScope [
	query
		scope: (aScope ifNil: [ self availableScopes first ] ifNotNil: [ aScope ])
]

{ #category : #initialization }
FQScopeQueryBuilder >> initializeQuery [
	super initializeQuery.
	query direction: self availableScopeDirections first.
	self availableScopes
		ifEmpty: [ (ImpossibleQuery new builder: self) signal ].
	query scope: self availableScopes first
]
