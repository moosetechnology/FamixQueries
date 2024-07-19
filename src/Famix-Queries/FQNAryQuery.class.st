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
FQNAryQuery class >> isAbstract [

	^ self == FQNAryQuery
]

{ #category : #testing }
FQNAryQuery class >> isCommutative [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQNAryQuery class >> subqueries: aCollection [

	^ self new
		  subqueries: aCollection;
		  yourself
]

{ #category : #running }
FQNAryQuery >> computeResult [

	^ result := self isValid
		            ifTrue: [ 
		            self runOn: (self subqueries collect: #result) ]
		            ifFalse: [ MooseGroup new ]
]

{ #category : #accessing }
FQNAryQuery >> dependencies [

	"Queries by default don't have any dependency"

	^ subqueries
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
FQNAryQuery >> hasSameSubqueriesAs: aQuery [

	^ self subqueries = aQuery subqueries
]

{ #category : #comparing }
FQNAryQuery >> hash [

	^ super hash bitXor: subqueries hash
]

{ #category : #initialization }
FQNAryQuery >> initialize [
	super initialize.
	subqueries := OrderedCollection new
]

{ #category : #testing }
FQNAryQuery >> isValid [

	^ self subqueries isNotEmpty and: [ 
		  self subqueries allSatisfy: [ :subquery | 
			  subquery isNotNil and: [ subquery isValid ] ] ]
]

{ #category : #printing }
FQNAryQuery >> operator [

	^ self subclassResponsibility
]

{ #category : #accessing }
FQNAryQuery >> parentSequence [

	"This query has no parent"

	^ #(  )
]

{ #category : #removing }
FQNAryQuery >> prepareRemoval [

	subqueries := nil
]

{ #category : #execution }
FQNAryQuery >> rootQuery: aFQRootQuery [

	self subqueries do: [ :subquery | subquery rootQuery: aFQRootQuery ]
]

{ #category : #printing }
FQNAryQuery >> storeOn: aStream [

	self subqueries
		do: [ :subquery | 
			aStream << '('.
			subquery storeOn: aStream.
			aStream << ')' ]
		separatedBy: [ aStream << ' ' << self operator << ' ' ]
]

{ #category : #printing }
FQNAryQuery >> storeWithParentsOn: aStream [

	self subqueries
		do: [ :subquery | 
			aStream << '('.
			subquery storeWithParentsOn: aStream.
			aStream << ')' ]
		separatedBy: [ aStream << ' ' << self operator << ' ' ]
]

{ #category : #accessing }
FQNAryQuery >> subqueries [
	^ subqueries
]

{ #category : #accessing }
FQNAryQuery >> subqueries: anObject [
	subqueries := anObject
]
