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
FQScopeQuery class >> forScope: aFamixClass direction: aScopeDirectionClass [
	^ self new
		scope: aFamixClass;
		direction: aScopeDirectionClass;
		yourself
]

{ #category : #comparing }
FQScopeQuery >> = aQuery [
	^ self class == aQuery class
		and: [ direction == aQuery direction and: [ scope == aQuery scope ] ]
]

{ #category : #'available parameters' }
FQScopeQuery >> availableDirections [
	^ FQAbstractScopeDirection availableDirections
]

{ #category : #'available parameters' }
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

{ #category : #testing }
FQScopeQuery >> isValid [
	^ (self direction inheritsFrom: FQAbstractScopeDirection)
		and: [ self scope isNotNil ]
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

{ #category : #printing }
FQScopeQuery >> storeOn: aStream [
	aStream << self simpleClassName << ' new direction: '
		<< self direction name << '; scope: ' << self scope name
]
