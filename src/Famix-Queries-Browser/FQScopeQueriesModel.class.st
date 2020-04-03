Class {
	#name : #FQScopeQueriesModel,
	#superclass : #FQQueriesModel,
	#instVars : [
		'directions',
		'accessibleScopes',
		'query'
	],
	#category : #'Famix-Queries-Browser-Models'
}

{ #category : #accessing }
FQScopeQueriesModel class >> default [
	^ self new
		accessibleScopes: self defaultAccessibleScopes;
		directions: self directions;
		yourself
]

{ #category : #'as yet unclassified' }
FQScopeQueriesModel class >> defaultAccessibleScopes [
	^ Dictionary
		newFromPairs:
			{#up.
			{'Package' . 'Namespace'}.
			#upAndDown.
			{'Package' . 'Namespace' . 'Method' . 'Attribute'}.
			#down.
			{'Method' . 'Attribute'}}
]

{ #category : #'as yet unclassified' }
FQScopeQueriesModel class >> directions [
	^ Dictionary
		newFromPairs: {#up . 'Up' . #upAndDown . 'Up and Down' . #down . 'Down'}
]

{ #category : #accessing }
FQScopeQueriesModel >> accessibleScopes [
	^ accessibleScopes
]

{ #category : #accessing }
FQScopeQueriesModel >> accessibleScopes: anObject [
	accessibleScopes := anObject
]

{ #category : #'query creation' }
FQScopeQueriesModel >> chooseDirection: aDirectionKey [
	query := (Array new: 2)
		at: 1 put: aDirectionKey;
		yourself
]

{ #category : #'query creation' }
FQScopeQueriesModel >> chooseScope: aScope [
	query at: 2 put: aScope
]

{ #category : #'query creation' }
FQScopeQueriesModel >> createQuery [
	^ query printString
]

{ #category : #accessing }
FQScopeQueriesModel >> currentPossibleScopes [
	^ self accessibleScopes at: query first
]

{ #category : #accessing }
FQScopeQueriesModel >> directions [
	^ directions
]

{ #category : #accessing }
FQScopeQueriesModel >> directions: anObject [
	directions := anObject
]

{ #category : #initialization }
FQScopeQueriesModel >> initialize [
	super initialize.
	self chooseDirection: #upAndDown
]
