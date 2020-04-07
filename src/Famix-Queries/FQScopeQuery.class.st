Class {
	#name : #FQScopeQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'scope',
		'direction'
	],
	#category : #'Famix-Queries-Terminal'
}

{ #category : #'instance creation' }
FQScopeQuery class >> forScope: aFamixClass direction: aDirectionStrategy [
	^ self new
		scope: aFamixClass;
		direction: aDirectionStrategy;
		yourself
]

{ #category : #'available scopes' }
FQScopeQuery >> availableDirections [
	^ FQAbstractScopeDirection availableDirections
]

{ #category : #'available scopes' }
FQScopeQuery >> availableScopesFor: aMooseGroup [
	^ self direction availableScopesFor: aMooseGroup
]

{ #category : #accessing }
FQScopeQuery >> direction [
	^ direction
]

{ #category : #accessing }
FQScopeQuery >> direction: anObject [
	direction := anObject
]

{ #category : #running }
FQScopeQuery >> displayOn: aStream with: aString [
	aStream << '(MooseObjectQueryResult withAll: ' << aString << ') '
		<< self direction scopingSelector asString.
	aStream
		space;
		<< self scope name
]

{ #category : #running }
FQScopeQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ self direction scope: self scope on: aMooseGroup
]

{ #category : #accessing }
FQScopeQuery >> scope [
	^ scope
]

{ #category : #accessing }
FQScopeQuery >> scope: anObject [
	scope := anObject
]
