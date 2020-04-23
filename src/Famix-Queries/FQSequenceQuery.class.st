Class {
	#name : #FQSequenceQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'childrenQueries'
	],
	#category : #'Famix-Queries-Combinator'
}

{ #category : #'instance creation' }
FQSequenceQuery class >> forQueries: aCollectionOfQueries [
	^ self new
		childrenQueries: aCollectionOfQueries asOrderedCollection;
		yourself
]

{ #category : #comparing }
FQSequenceQuery >> = aQuery [
	^ aQuery class == self class
		and: [ aQuery childrenQueries = childrenQueries ]
]

{ #category : #accessing }
FQSequenceQuery >> childrenQueries [
	^ childrenQueries
]

{ #category : #accessing }
FQSequenceQuery >> childrenQueries: anObject [
	childrenQueries := anObject
]

{ #category : #running }
FQSequenceQuery >> displayOn: aStream with: aString [
	1 to: self childrenQueries size - 1 do: [ :i | aStream << '(' ].
	self childrenQueries first displayOn: aStream.
	self childrenQueries
		allButFirstDo: [ :query | 
			aStream
				<<')
	'.
			query displayOn: aStream with: '' ]
]

{ #category : #testing }
FQSequenceQuery >> isValid [
	^ childrenQueries allSatisfy: #isValid
]

{ #category : #running }
FQSequenceQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ MooseGroup
		withAll:
			(self childrenQueries allButFirst
				inject: (self childrenQueries first runOn: aMooseGroup)
				into: [ :queryResult :otherQuery | otherQuery runOn: queryResult ])
]
