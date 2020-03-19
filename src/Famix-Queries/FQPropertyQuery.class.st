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

{ #category : #accessing }
FQPropertyQuery >> valueToCompare [
	^ valueToCompare
]

{ #category : #accessing }
FQPropertyQuery >> valueToCompare: anObject [
	valueToCompare := anObject
]
