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

{ #category : #'adding - removing' }
FQTypeQuery >> addType: aType [
	(self types includes: aType)
		ifTrue: [ ^ self ].
	self types add: aType
]

{ #category : #running }
FQTypeQuery >> allWantedIn: aMooseGroup [
	^ self types
		flatCollectAsSet: [ :type | 
			type isTrait
				ifTrue: [ aMooseGroup allUsing: type ]
				ifFalse: [ aMooseGroup allWithType: type ] ]
]

{ #category : #'available parameters' }
FQTypeQuery >> availableTypesFor: aMooseGroup [
	^ ((aMooseGroup allUsing: FamixTNamedEntity) collect: #class)
		removeDuplicates asOrderedCollection
		sort: [ :type1 :type2 | type1 name < type2 name ]
]

{ #category : #printing }
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

{ #category : #printing }
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

{ #category : #testing }
FQTypeQuery >> isValid [
	^ self types isNotEmpty
]

{ #category : #'adding - removing' }
FQTypeQuery >> removeType: aType [
	self types size = 1
		ifTrue: [ FQTypeQueryMustHaveAtLeastOneType
				signal: 'Removing the last type of a ' , self className , ' is forbidden' ].
	self types remove: aType
]

{ #category : #running }
FQTypeQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ MooseGroup withAll: (self allWantedIn: aMooseGroup)
]

{ #category : #printing }
FQTypeQuery >> storeOn: aStream [
	aStream << self className << ' new types:' << '{'.
	self types allButLast do: [ :type | aStream << type name << '. ' ].
	aStream << self types last name << '}; yourself'
]

{ #category : #accessing }
FQTypeQuery >> types [
	^ types
]

{ #category : #accessing }
FQTypeQuery >> types: aCollection [
	types := aCollection asOrderedCollection
]
