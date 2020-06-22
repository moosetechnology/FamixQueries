Class {
	#name : #FQComposedQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'queries',
		'leaf',
		'roots'
	],
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #accessing }
FQComposedQuery class >> label [
	^ 'Composed Query'
]

{ #category : #accessing }
FQComposedQuery class >> queries: aQuery [
	^ self new
		queries: aQuery parentSequence;
		yourself
]

{ #category : #running }
FQComposedQuery >> beChildOf: aQuery [
	super beChildOf: aQuery.
	roots do: [ :root | root parent: aQuery ]
]

{ #category : #default }
FQComposedQuery >> beDefaultForParent [
	"Nothing to do"

	
]

{ #category : #running }
FQComposedQuery >> computeResult [
	^ leaf result
]

{ #category : #printing }
FQComposedQuery >> defaultName [
	^ 'No name'
]

{ #category : #printing }
FQComposedQuery >> displayOn: aStream with: aString [
	^ leaf displayOn: aStream
]

{ #category : #comparing }
FQComposedQuery >> hasSameParametersAs: aQuery [
	^ queries = aQuery queries
]

{ #category : #initialization }
FQComposedQuery >> initialize [
	super initialize.
	queries := OrderedCollection new
]

{ #category : #testing }
FQComposedQuery >> isValid [
	^ queries notEmpty and: [ queries allSatisfy: #isValid ]
]

{ #category : #accessing }
FQComposedQuery >> queries [
	^ queries
]

{ #category : #accessing }
FQComposedQuery >> queries: aSequenceOfQueries [
	self
		flag:
			#FQImprove
				,
					'Check if all queries are in the last child parentSequence AND if first query is unary'.
	queries := aSequenceOfQueries asOrderedCollection.
	roots := aSequenceOfQueries select: #hasNoParent.
	leaf := aSequenceOfQueries last
]

{ #category : #reset }
FQComposedQuery >> resetResult [
	super resetResult.
	queries do: #resetResult
]

{ #category : #running }
FQComposedQuery >> runOn: aMooseGroup [
	self resetResult.
	self beChildOf: (FQRootQuery new result: aMooseGroup).
	^ self result
]

{ #category : #printing }
FQComposedQuery >> storeOn: aStream [
	aStream << self className << ' queries: '.
	leaf storeOn: aStream withParentsIn: queries
]
