"
Abstract class for `and`, `or` and `difference` queries. 
"
Class {
	#name : #FQNaryQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'subqueries'
	],
	#category : #'Famix-Queries-Core'
}

{ #category : #'available parameters' }
FQNaryQuery class >> availableCombinations [
	self flag: #FQImprove.
	^ {FQUnionQuery.
	FQIntersectionQuery.
	FQSubtractionQuery}
]

{ #category : #testing }
FQNaryQuery class >> isCommutative [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQNaryQuery class >> subqueries: twoQueries [
	^ self new
		beChildOf: twoQueries;
		yourself
]

{ #category : #adding }
FQNaryQuery >> addToParentsSequence: sequence [
	self flag: #FQImprove , 'Need for a specific order ?'.
	self subqueries do: [ :parent | parent addToParentsSequence: sequence ].
	(sequence includes: self)
		ifTrue: [ children
				do:
					[ :child | (sequence detect: [ :query | query = self ]) addChild: child ] ]
		ifFalse: [ sequence addLast: self ].
	^ sequence
]

{ #category : #adding }
FQNaryQuery >> beChildOf: parentQueries [
	self subqueries ifNotEmpty: [ self prepareRemoval ].
	self subqueries: parentQueries.
	parentQueries do: [ :newParent | newParent addChild: self ]
]

{ #category : #running }
FQNaryQuery >> computeResult [
	self isValid
		ifFalse: [ ^ MooseGroup new ].
	^ self runOn: (self subqueries collect: #result)
]

{ #category : #printing }
FQNaryQuery >> displayOn: aStream [
	aStream << '('.
	self subqueries
		allButLastDo: [ :query | 
			query displayOn: aStream.
			aStream << (self operator join: {') ' . ' ('}) ].
	self subqueries last displayOn: aStream.
	aStream << ')'
]

{ #category : #testing }
FQNaryQuery >> hasNoParent [
	^ self subqueries isEmpty
]

{ #category : #comparing }
FQNaryQuery >> hasSameParametersAs: aQuery [
	self subqueries
		with: aQuery subqueries
		do: [ :parent :comparedParent | 
			(parent hasSameParametersAs: comparedParent)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #comparing }
FQNaryQuery >> hasSameParentsAs: aQuery [
	^ self subqueries = aQuery subqueries
]

{ #category : #initialization }
FQNaryQuery >> initialize [
	super initialize.
	subqueries := OrderedCollection new
]

{ #category : #testing }
FQNaryQuery >> isValid [
	^ self subqueries isNotEmpty
		and: [ self subqueries
				allSatisfy: [ :parent | parent isNotNil and: [ parent isValid ] ] ]
]

{ #category : #printing }
FQNaryQuery >> operator [
	^ self subclassResponsibility
]

{ #category : #printing }
FQNaryQuery >> storeOn: aStream [
	aStream << '('.
	self subqueries first storeOn: aStream.
	aStream << ') ' << self operator << ' ('.
	self subqueries second storeOn: aStream.
	aStream << ' )'
]

{ #category : #printing }
FQNaryQuery >> storeOn: aStream withParentsIn: queries [
	(queries includesAll: subqueries)
		ifFalse: [ ^ self storeOn: aStream ].
	aStream << '('.
	self subqueries first storeOn: aStream withParentsIn: queries.
	aStream << ') ' << self operator << ' ('.
	self subqueries second storeOn: aStream withParentsIn: queries.
	aStream << ' )'
]

{ #category : #accessing }
FQNaryQuery >> subqueries [
	^ subqueries
]

{ #category : #accessing }
FQNaryQuery >> subqueries: anObject [
	subqueries := anObject
]
