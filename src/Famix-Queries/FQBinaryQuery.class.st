Class {
	#name : #FQBinaryQuery,
	#superclass : #FQAbstractQuery,
	#category : #'Famix-Queries-Core'
}

{ #category : #'available parameters' }
FQBinaryQuery class >> availableCombinations [
	self flag: #FQImprove.
	^ {FQUnionQuery.
	FQIntersectionQuery.
	FQSubstractionQuery}
]

{ #category : #testing }
FQBinaryQuery class >> isCommutative [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQBinaryQuery class >> parents: twoQueries [
	^ self new
		beChildOf: twoQueries;
		yourself
]

{ #category : #adding }
FQBinaryQuery >> addToParentsSequence: sequence [
	self flag: #FQImprove , 'Need for a specific order ?'.
	self parents do: [ :parent | parent addToParentsSequence: sequence ].
	(sequence includes: self)
		ifTrue: [ children
				do:
					[ :child | (sequence detect: [ :query | query = self ]) addChild: child ] ]
		ifFalse: [ sequence addLast: self ].
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
	^ self runOn: (self parents collect: #result)
]

{ #category : #printing }
FQBinaryQuery >> displayOn: aStream [
	aStream << '('.
	self parents
		allButLastDo: [ :query | 
			query displayOn: aStream.
			aStream << (self operator join: {') ' . ' ('}) ].
	self parents last displayOn: aStream.
	aStream << ')'
]

{ #category : #comparing }
FQBinaryQuery >> hasSameParentsAs: aQuery [
	^ self parents = aQuery parents
]

{ #category : #testing }
FQBinaryQuery >> isValid [
	^ self parents isNotEmpty
		and: [ self parents
				allSatisfy: [ :parent | parent isNotNil and: [ parent isValid ] ] ]
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

{ #category : #printing }
FQBinaryQuery >> storeOn: aStream [
	aStream << self className << ' parents: { '.
	self parents first storeOn: aStream.
	aStream << '. '.
	self parents second storeOn: aStream.
	aStream << ' }'
]

{ #category : #printing }
FQBinaryQuery >> storeWithParentsOn: aStream [
	aStream << self className << ' new beChildOf: { '.
	self parents first storeWithParentsOn: aStream.
	aStream << '. '.
	self parents second storeWithParentsOn: aStream.
	aStream << ' }'
]
