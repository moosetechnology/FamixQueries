Class {
	#name : #FQBinaryQuery,
	#superclass : #FQAbstractQuery,
	#category : #'Famix-Queries-Core'
}

{ #category : #'as yet unclassified' }
FQBinaryQuery class >> availableCombinations [
	^ {FQUnionQuery.
	FQIntersectionQuery.
	FQSubstractionQuery}
]

{ #category : #adding }
FQBinaryQuery >> addToParentsSequence: sequence [
	self flag: #FQImprove , 'Need for a specific order ?'.
	self parents do: [ :parent | parent addToParentsSequence: sequence ].
	sequence addLast: self.
	^ sequence
]

{ #category : #adding }
FQBinaryQuery >> beChildOf: parentQueries [
	self parents ifNotEmpty: [ self prepareRemoval ].
	self parents: parentQueries.
	parentQueries do: [ :newParent | newParent addChild: self ]
]

{ #category : #running }
FQBinaryQuery >> computeResult [
	^ self computeResultFromParents
]

{ #category : #running }
FQBinaryQuery >> computeResultFromParents [
	^ self runOn: (self parents collect: #result)
]

{ #category : #printing }
FQBinaryQuery >> displayOn: aStream with: aString [
	self parents size = 1
		ifTrue: [ self parents first displayOn: aStream with: aString.
			^ self ].
	aStream << '('.
	self parents
		allButLastDo: [ :query | 
			query displayOn: aStream with: aString.
			aStream << (self operator join: {') ' . ' ('}) ].
	self parents last displayOn: aStream with: aString.
	aStream << ')'
]

{ #category : #comparing }
FQBinaryQuery >> hasSameParametersAs: aQuery [
	^ true
]

{ #category : #comparing }
FQBinaryQuery >> hasSameParentsHas: aQuery [
	^ self parents = aQuery parents
]

{ #category : #testing }
FQBinaryQuery >> isValid [
	^ self parents allSatisfy: #isValid
]

{ #category : #printing }
FQBinaryQuery >> operator [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQBinaryQuery >> parents [
	self subclassResponsibility
]

{ #category : #accessing }
FQBinaryQuery >> parents: anObject [
	self subclassResponsibility
]

{ #category : #removing }
FQBinaryQuery >> prepareRemoval [
	self parents do: [ :parent | parent removeChild: self ].
	self resetParents
]

{ #category : #removing }
FQBinaryQuery >> resetParents [
	self subclassResponsibility
]
