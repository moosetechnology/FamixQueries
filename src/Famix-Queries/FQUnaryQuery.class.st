Class {
	#name : #FQUnaryQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'parent'
	],
	#category : #'Famix-Queries-Core'
}

{ #category : #running }
FQUnaryQuery >> computeResult [
	^ self computeResultFromParent
]

{ #category : #running }
FQUnaryQuery >> computeResultFromParent [
	^ self runOn: parent result
]

{ #category : #accessing }
FQUnaryQuery >> parent [
	^ parent
]

{ #category : #accessing }
FQUnaryQuery >> parent: anObject [
	parent := anObject
]

{ #category : #removing }
FQUnaryQuery >> prepareRemoval [
	parent removeChild: self.
	parent := nil
]
