Class {
	#name : #FQBinaryQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'parents'
	],
	#category : #'Famix-Queries-Core'
}

{ #category : #adding }
FQBinaryQuery >> addToParentsSequence: sequence [
	self flag: #FQImprove , 'Need for a specific order ?'.
	parents do: [ :parent | parent addToParentsSequence: sequence ].
	sequence addLast: self.
	^ sequence
]

{ #category : #adding }
FQBinaryQuery >> beChildOf: parentQueries [
	parents ifNotEmpty: [ self prepareRemoval ].
	self parents: parentQueries.
	parentQueries do: [ :newParent | newParent addChild: self ]
]

{ #category : #running }
FQBinaryQuery >> computeResult [
	^ self computeResultFromParents
]

{ #category : #running }
FQBinaryQuery >> computeResultFromParents [
	^ self runOn: (parents collect: #result)
]

{ #category : #comparing }
FQBinaryQuery >> hasSameParentsHas: aQuery [
	^ parents = aQuery parents
]

{ #category : #initialization }
FQBinaryQuery >> initialize [
	super initialize.
	parents := Set new
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
	parents := Set new
]
