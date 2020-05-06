Class {
	#name : #FQUnaryQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'parent'
	],
	#category : #'Famix-Queries-Core'
}

{ #category : #'as yet unclassified' }
FQUnaryQuery >> addToParentsSequence: sequence [
	parent ifNotNil: [ parent addToParentsSequence: sequence ].
	sequence addLast: self.
	^ sequence
]

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

{ #category : #'as yet unclassified' }
FQUnaryQuery >> parentSequence [
	| sequence |
	sequence := OrderedCollection new.
	self addToParentsSequence: sequence.
	^ sequence
]

{ #category : #removing }
FQUnaryQuery >> prepareRemoval [
	parent removeChild: self.
	parent := nil
]
