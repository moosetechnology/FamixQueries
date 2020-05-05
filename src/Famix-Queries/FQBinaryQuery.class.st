Class {
	#name : #FQBinaryQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'parents'
	],
	#category : #'Famix-Queries-Core'
}

{ #category : #running }
FQBinaryQuery >> computeResult [
	^ self computeResultFromParents
]

{ #category : #running }
FQBinaryQuery >> computeResultFromParents [
	^ self runOn: (parents collect: #result)
]

{ #category : #accessing }
FQBinaryQuery >> parents [
	^ parents
]

{ #category : #accessing }
FQBinaryQuery >> parents: anObject [
	parents := anObject
]

{ #category : #removing }
FQBinaryQuery >> prepareRemoval [
	parents do: [ :parent | parent removeChild: self ].
	parents := OrderedCollection new
]
