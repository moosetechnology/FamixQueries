Class {
	#name : #FQComposedQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'queries',
		'leaf',
		'roots'
	],
	#category : #'Famix-Queries-Library'
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
	queries
		with: aQuery queries
		do: [ :query :otherQuery | 
			(query hasSameParametersAs: otherQuery)
				ifFalse: [ ^ false ] ].
	^ true
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

{ #category : #copying }
FQComposedQuery >> postCopy [
	| newQueries |
	super postCopy.
	newQueries := self queries veryDeepCopy.
	newQueries
		select: [ :q | self roots includes: q ]
		thenDo: #resetParents.
	self queries: newQueries.
	self reset
]

{ #category : #accessing }
FQComposedQuery >> queries [
	^ queries
]

{ #category : #accessing }
FQComposedQuery >> queries: aSequenceOfQueries [
	queries := (aSequenceOfQueries reject: #isRootQuery)
		asOrderedCollection.
	queries do: #resetResult.
	roots := aSequenceOfQueries
		select: [ :query | 
			(query isKindOf: FQUnaryQuery)
				and: [ query hasNoParent or: [ query parent isRootQuery ] ] ].
	self roots
		do:
			[ :root | parent ifNotNil: [ root parent: parent ] ifNil: [ root resetParents ] ].
	leaf := aSequenceOfQueries last
		resetChildren;
		yourself
]

{ #category : #reset }
FQComposedQuery >> resetChildren [
	super resetChildren.
	leaf resetChildren
]

{ #category : #reset }
FQComposedQuery >> resetParents [
	super resetParents.
	self roots do: #resetParents
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
	"aStream << self className << ' queries: '.
	leaf storeOn: aStream withParentsIn: queries"

	(FQLibrary current registryAt: self name)
		ifNil: [ FQLibrary current addNewQuery: self ].
	aStream << 'FQLibrary queryNamed: '
		<< self name surroundedBySingleQuotes
]
