Class {
	#name : #FQBinaryQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'parents'
	],
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
	self isValid
		ifFalse: [ ^ MooseGroup new ].
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

{ #category : #testing }
FQBinaryQuery >> hasNoParent [
	^ self parents isEmpty
]

{ #category : #comparing }
FQBinaryQuery >> hasSameParametersAs: aQuery [
	self parents
		with: aQuery parents
		do: [ :parent :comparedParent | 
			(parent hasSameParametersAs: comparedParent)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #comparing }
FQBinaryQuery >> hasSameParentsAs: aQuery [
	^ self parents = aQuery parents
]

{ #category : #initialization }
FQBinaryQuery >> initialize [
	super initialize.
	parents := OrderedCollection new
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
	^ parents
]

{ #category : #accessing }
FQBinaryQuery >> parents: anObject [
	parents := anObject
]

{ #category : #removing }
FQBinaryQuery >> prepareRemoval [
	self parents do: [ :parent | parent removeChild: self ].
	self resetParents
]

{ #category : #replacing }
FQBinaryQuery >> replace: anotherQuery [
	(anotherQuery isKindOf: FQBinaryQuery)
		ifFalse: [ self inform: 'Cannot replace a unary query with a binary query'.
			^ anotherQuery ].
	self beChildOf: anotherQuery parents.
	anotherQuery prepareRemoval.
	anotherQuery children
		do: [ :childQuery | 
			childQuery
				resetResult;
				replaceParent: anotherQuery with: self ]
]

{ #category : #removing }
FQBinaryQuery >> replaceParent: aParentQuery with: anotherQuery [
	(self parents includes: aParentQuery)
		ifFalse: [ ^ self ].
	aParentQuery removeChild: self.
	anotherQuery addChild: self.
	self parents
		at: (self parents indexOf: aParentQuery)
		put: anotherQuery
]

{ #category : #removing }
FQBinaryQuery >> resetParents [
	parents := OrderedCollection new
]

{ #category : #printing }
FQBinaryQuery >> storeOn: aStream [
	aStream << '('.
	self parents first storeOn: aStream.
	aStream << ') ' << self operator << ' ('.
	self parents second storeOn: aStream.
	aStream << ' )'
]

{ #category : #printing }
FQBinaryQuery >> storeOn: aStream withParentsIn: queries [
	(queries includesAll: parents)
		ifFalse: [ ^ self storeOn: aStream ].
	aStream << '('.
	self parents first storeOn: aStream withParentsIn: queries.
	aStream << ') ' << self operator << ' ('.
	self parents second storeOn: aStream withParentsIn: queries.
	aStream << ' )'
]
