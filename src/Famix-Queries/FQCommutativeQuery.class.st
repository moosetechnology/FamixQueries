Class {
	#name : #FQCommutativeQuery,
	#superclass : #FQBinaryQuery,
	#instVars : [
		'parents'
	],
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #testing }
FQCommutativeQuery class >> isCommutative [
	^ true
]

{ #category : #initialization }
FQCommutativeQuery >> initialize [
	super initialize.
	parents := Set new
]

{ #category : #accessing }
FQCommutativeQuery >> parents [
	^ parents
]

{ #category : #accessing }
FQCommutativeQuery >> parents: anObject [
	parents := anObject
]

{ #category : #removing }
FQCommutativeQuery >> resetParents [
	parents := Set new
]
