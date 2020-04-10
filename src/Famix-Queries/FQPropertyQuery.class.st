Class {
	#name : #FQPropertyQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'property',
		'valueToCompare',
		'comparator'
	],
	#category : #'Famix-Queries-Terminal'
}

{ #category : #accessing }
FQPropertyQuery class >> availablePropertyTypes [
	^ FQPropertyQuery allSubclasses
]

{ #category : #'available properties' }
FQPropertyQuery >> availablePropertiesFor: aMooseGroup [
	| collectedProperties |
	collectedProperties := aMooseGroup entities
		collect: [ :entity | 
			entity mooseDescription allPrimitiveProperties
				select: [ :prop | prop type class == self type ] ].
	^ collectedProperties
		ifNotEmpty: [ (collectedProperties
				fold:
					[ :availableProperties :entityProperties | availableProperties & entityProperties ])
				collect: #name ]
]

{ #category : #accessing }
FQPropertyQuery >> comparator [
	^ comparator
]

{ #category : #accessing }
FQPropertyQuery >> comparator: anObject [
	comparator := anObject
]

{ #category : #running }
FQPropertyQuery >> displayOn: aStream with: aString [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQPropertyQuery >> property [
	^ property
]

{ #category : #accessing }
FQPropertyQuery >> property: anObject [
	property := anObject
]

{ #category : #running }
FQPropertyQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ self subclassResponsibility
]

{ #category : #printing }
FQPropertyQuery >> storeOn: aStream [
	aStream << self className << ' new property: '.
	self property storeOn: aStream.
	aStream << '; comparator: '.
	self comparator storeOn: aStream.
	aStream
		<< '; valueToCompare: ';
		<< self valueToCompareAsString;
		<< '; yourself'
]

{ #category : #'available properties' }
FQPropertyQuery >> type [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQPropertyQuery >> valueToCompare [
	^ valueToCompare
		ifNil: [ valueToCompare := self class defaultValueToCompare ]
]

{ #category : #accessing }
FQPropertyQuery >> valueToCompare: anObject [
	valueToCompare := anObject
]
