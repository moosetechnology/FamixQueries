Class {
	#name : #FQUnaryQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'parent'
	],
	#category : #'Famix-Queries-Core'
}

{ #category : #adding }
FQUnaryQuery >> addToParentsSequence: sequence [
	parent ifNotNil: [ parent addToParentsSequence: sequence ].
	sequence addLast: self.
	^ sequence
]

{ #category : #adding }
FQUnaryQuery >> beChildOf: aQuery [
	parent ifNotNil: [ self prepareRemoval ].
	self parent: aQuery.
	aQuery addChild: self
]

{ #category : #running }
FQUnaryQuery >> computeResult [
	^ self computeResultFromParent
]

{ #category : #running }
FQUnaryQuery >> computeResultFromParent [
	^ self runOn: parent result
]

{ #category : #comparing }
FQUnaryQuery >> hasSameParentsHas: aQuery [
	^ parent = aQuery parent
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
