Class {
	#name : #FQTypeQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'types'
	],
	#category : #'Famix-Queries-Terminal'
}

{ #category : #'instance creation' }
FQTypeQuery class >> forType: aType [
	^ self new
		types: {aType} asOrderedCollection;
		yourself
]

{ #category : #'instance creation' }
FQTypeQuery class >> forTypes: aTypesCollection [
	^ self new
		types: aTypesCollection asOrderedCollection;
		yourself
]

{ #category : #running }
FQTypeQuery >> allWantedIn: aMooseGroup [
	^ self types
		flatCollectAsSet: [ :type | 
			type isTrait
				ifTrue: [ aMooseGroup allUsing: type ]
				ifFalse: [ aMooseGroup allWithType: type ] ]
]

{ #category : #accessing }
FQTypeQuery >> availableTypesFor: aMooseGroup [
	^ ((aMooseGroup allUsing: FamixTNamedEntity) collect: #class)
		removeDuplicates;
		sort: [ :type1 :type2 | type1 name < type2 name ]
]

{ #category : #running }
FQTypeQuery >> displayOn: aStream with: aString [
	self types size == 1
		ifTrue:
			[ aStream << aString << (self displayStringForType: self types first) ]
		ifFalse: [ self types
				allButLastDo:
					[ :type | aStream << $( << aString << (self displayStringForType: type) << ') | ' ].
			aStream << $( << aString
				<< (self displayStringForType: self types last) << $) ]
]

{ #category : #running }
FQTypeQuery >> displayStringForType: aType [
	^ (aType isTrait
		ifTrue: [ ' allUsing: ' ]
		ifFalse: [ ' allWithType: ' ]) , aType name
]

{ #category : #running }
FQTypeQuery >> initialize [
	super initialize.
	types := OrderedCollection new
]

{ #category : #running }
FQTypeQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ MooseGroup withAll: (self allWantedIn: aMooseGroup)
]

{ #category : #accessing }
FQTypeQuery >> types [
	^ types
]

{ #category : #accessing }
FQTypeQuery >> types: anObject [
	types := anObject
]
