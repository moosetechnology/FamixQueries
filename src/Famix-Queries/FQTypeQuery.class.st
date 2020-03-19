Class {
	#name : #FQTypeQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'type'
	],
	#category : #'Famix-Queries-Terminal'
}

{ #category : #'instance creation' }
FQTypeQuery class >> forType: aType [
	^ self new
		type: aType;
		yourself
]

{ #category : #running }
FQTypeQuery >> displayOn: aStream with: aString [
	aStream << aString << (' allUsing: ' , self type name)
]

{ #category : #running }
FQTypeQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."
self flag: 'Clotilde: Currently using Traits to define types. Maybe we should use the hierarchy (withType: FamixStClass instead of using: FamixTClass'.
	^ (self type isTrait
		ifTrue: [ aMooseGroup allUsing: type ]) asMooseGroup
		ifEmpty: [ MooseGroup new ]
]

{ #category : #accessing }
FQTypeQuery >> type [
	^ type
]

{ #category : #accessing }
FQTypeQuery >> type: anObject [
	type := anObject
]
