"
Abstract class for `and`, `or` and `difference` queries. I can receive several subqueries, not only two.
"
Class {
	#name : #FQNAryQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'subqueries'
	],
	#category : #'Famix-Queries-Queries-N-ary'
}

{ #category : #'available parameters' }
FQNAryQuery class >> availableCombinations [
	self flag: #FQImprove.
	^ {FQUnionQuery.
	FQIntersectionQuery.
	FQSubtractionQuery}
]

{ #category : #testing }
FQNAryQuery class >> isCommutative [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQNAryQuery class >> subqueries: twoQueries [
	^ self new
		beChildOf: twoQueries;
		yourself
]

{ #category : #adding }
FQNAryQuery >> addToParentsSequence: sequence [
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
FQNAryQuery >> beChildOf: parentQueries [
	self subqueries ifNotEmpty: [ self prepareRemoval ].
	self subqueries: parentQueries.
	parentQueries do: [ :newParent | newParent addChild: self ]
]

{ #category : #running }
FQNAryQuery >> computeResult [
	self isValid
		ifFalse: [ ^ MooseGroup new ].
	^ self runOn: (self subqueries collect: #result)
]

{ #category : #printing }
FQNAryQuery >> displayOn: aStream [
	aStream << '('.
	self subqueries
		allButLastDo: [ :query | 
			query displayOn: aStream.
			aStream << (self operator join: {') ' . ' ('}) ].
	self subqueries last displayOn: aStream.
	aStream << ')'
]

{ #category : #testing }
FQNAryQuery >> hasNoParent [
	^ self subqueries isEmpty
]

{ #category : #comparing }
FQNAryQuery >> hasSameParametersAs: aQuery [
	self subqueries
		with: aQuery subqueries
		do: [ :parent :comparedParent | 
			(parent hasSameParametersAs: comparedParent)
				ifFalse: [ ^ false ] ].
	^ true
]

{ #category : #comparing }
FQNAryQuery >> hasSameParentsAs: aQuery [
	^ self subqueries = aQuery subqueries
]

{ #category : #initialization }
FQNAryQuery >> initialize [
	super initialize.
	subqueries := OrderedCollection new
]

{ #category : #testing }
FQNAryQuery >> isValid [
	^ self subqueries isNotEmpty
		and: [ self subqueries
				allSatisfy: [ :parent | parent isNotNil and: [ parent isValid ] ] ]
]

{ #category : #printing }
FQNAryQuery >> operator [
	^ self subclassResponsibility
]

{ #category : #printing }
FQNAryQuery >> storeOn: aStream [
	aStream << '('.
	self subqueries first storeOn: aStream.
	aStream << ') ' << self operator << ' ('.
	self subqueries second storeOn: aStream.
	aStream << ' )'
]

{ #category : #printing }
FQNAryQuery >> storeOn: aStream withParentsIn: queries [
	(queries includesAll: subqueries)
		ifFalse: [ ^ self storeOn: aStream ].
	aStream << '('.
	self subqueries first storeOn: aStream withParentsIn: queries.
	aStream << ') ' << self operator << ' ('.
	self subqueries second storeOn: aStream withParentsIn: queries.
	aStream << ' )'
]

{ #category : #accessing }
FQNAryQuery >> subqueries [
	^ subqueries
]

{ #category : #accessing }
FQNAryQuery >> subqueries: anObject [
	subqueries := anObject
]
