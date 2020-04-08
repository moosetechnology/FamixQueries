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

{ #category : #accessing }
FQScopeQueryBuilder >> queryClass [
	^ FQScopeQuery
]
