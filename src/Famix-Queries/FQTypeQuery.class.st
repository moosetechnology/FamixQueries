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
FQTypeQuery >> allWantedIn: aMooseGroup [
	^ self type isTrait
		ifTrue: [ aMooseGroup allUsing: self type ]
		ifFalse: [ aMooseGroup allWithType: self type ]
]

{ #category : #accessing }
FQTypeQuery >> availableTypesFor: aMooseGroup [
	^ ((aMooseGroup allUsing: FamixTNamedEntity) collect: #class)
		removeDuplicates;
		sort: [ :type1 :type2 | type1 name < type2 name ]
]

{ #category : #running }
FQTypeQuery >> displayOn: aStream with: aString [
	aStream << aString << (self selectorString , self type name)
]

{ #category : #running }
FQTypeQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ (self allWantedIn: aMooseGroup) asMooseGroup
		ifEmpty: [ MooseGroup new ]
]

{ #category : #running }
FQTypeQuery >> selectorString [
	^ self type isTrait
		ifTrue: [ ' allUsing: ' ]
		ifFalse: [ ' allWithType: ' ]
]

{ #category : #accessing }
FQTypeQuery >> type [
	^ type
]

{ #category : #accessing }
FQTypeQuery >> type: anObject [
	type := anObject
]
