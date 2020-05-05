Class {
	#name : #FQCombinatorQueryWrapper,
	#superclass : #FQAbstractQueryWrapper,
	#instVars : [
		'parents'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQCombinatorQueryWrapper >> computeResult [
	self
		flag: 'A CHOICE MUST BE MADE, TO USE COMBINATOR QUERIES OR NOT'.
	^ parents first result union: parents second result
]

{ #category : #accessing }
FQCombinatorQueryWrapper >> parent [
	^ parents anyOne
]

{ #category : #accessing }
FQCombinatorQueryWrapper >> parents [
	^ parents
]

{ #category : #accessing }
FQCombinatorQueryWrapper >> parents: anObject [
	parents := anObject
]

{ #category : #removing }
FQCombinatorQueryWrapper >> prepareRemoval [
	parents do: [ :parent | parent removeChild: self ].
	parents := OrderedCollection new
]
