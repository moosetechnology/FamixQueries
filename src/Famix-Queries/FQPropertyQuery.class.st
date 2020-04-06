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

{ #category : #'available properties' }
FQPropertyQuery >> availablePropertiesFor: aMooseGroup [
	| collectedProperties |
	collectedProperties := aMooseGroup entities
		collect: [ :entity | 
			entity mooseDescription allPrimitiveProperties
				select: [ :prop | prop type class == self type ] ].
	^ (collectedProperties
		fold:
			[ :availableProperties :entityProperties | availableProperties & entityProperties ])
		collect: #name
]

{ #category : #accessing }
FQPropertyQuery >> comparator [
	^ comparator
]

{ #category : #accessing }
FQPropertyQuery >> comparator: anObject [
	comparator := anObject
]

{ #category : #accessing }
FQPropertyQuery >> property [
	^ property
]

{ #category : #accessing }
FQPropertyQuery >> property: anObject [
	property := anObject
]

{ #category : #'available properties' }
FQPropertyQuery >> type [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQPropertyQuery >> valueToCompare [
	^ valueToCompare
]

{ #category : #accessing }
FQPropertyQuery >> valueToCompare: anObject [
	valueToCompare := anObject
]
