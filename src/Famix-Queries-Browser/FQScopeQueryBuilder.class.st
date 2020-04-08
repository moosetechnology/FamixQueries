Class {
	#name : #FQScopeQueryBuilder,
	#superclass : #FQAbstractQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

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
	query direction: aDirection
]

{ #category : #'changing parameters' }
FQScopeQueryBuilder >> changeQueryScope: aScope [
	query scope: aScope
]

{ #category : #initialization }
FQScopeQueryBuilder >> initializeQuery [
	super initializeQuery.
	query direction: self availableScopeDirections first.
	query scope: self availableScopes first
]

{ #category : #accessing }
FQScopeQueryBuilder >> queryClass [
	^ FQScopeQuery
]
