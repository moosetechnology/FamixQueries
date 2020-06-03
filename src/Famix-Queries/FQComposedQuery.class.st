Class {
	#name : #FQComposedQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'queries',
		'root',
		'leaf'
	],
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #accessing }
FQComposedQuery class >> label [
	^ 'Composed Query'
]

{ #category : #running }
FQComposedQuery >> beChildOf: aQuery [
	super beChildOf: aQuery.
	root parent: aQuery
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

{ #category : #running }
FQComposedQuery >> queries [
	^ queries
]

{ #category : #running }
FQComposedQuery >> queries: aSequenceOfQueries [
	self
		flag:
			#FQImprove
				,
					'Check if all queries are in the last child parentSequence AND if first query is unary'.
	queries := aSequenceOfQueries asOrderedCollection.
	root := aSequenceOfQueries first.
	leaf := aSequenceOfQueries last
]

{ #category : #running }
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
	aStream << self className << ' new queries: ('.
	leaf storeWithParentsOn: aStream.
	aStream << ') parentSequence'
]
