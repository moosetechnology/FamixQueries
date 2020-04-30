Class {
	#name : #FQCombinatorQueryWrapper,
	#superclass : #FQAbstractQueryWrapper,
	#instVars : [
		'parents'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQCombinatorQueryWrapper >> parents [
	^ parents
]

{ #category : #accessing }
FQCombinatorQueryWrapper >> parents: anObject [
	parents := anObject
]
