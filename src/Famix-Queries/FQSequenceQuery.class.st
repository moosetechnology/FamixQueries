Class {
	#name : #FQSequenceQuery,
	#superclass : #FQBinaryQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #'instance creation' }
FQSequenceQuery class >> forQueries: aCollectionOfQueries [
	^ self new
		parents: aCollectionOfQueries asOrderedCollection;
		yourself
]

{ #category : #comparing }
FQSequenceQuery >> = aQuery [
	^ aQuery class == self class and: [ aQuery parents = parents ]
]

{ #category : #printing }
FQSequenceQuery >> defaultName [
	^ 'Sequence'
]

{ #category : #running }
FQSequenceQuery >> displayOn: aStream with: aString [
	1 to: parents size - 1 do: [ :i | aStream << '(' ].
	parents first displayOn: aStream.
	parents
		allButFirstDo: [ :query | 
			aStream
				<<
					')
	'.
			query displayOn: aStream with: '' ]
]

{ #category : #testing }
FQSequenceQuery >> isValid [
	^ parents allSatisfy: #isValid
]

{ #category : #running }
FQSequenceQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ MooseGroup
		withAll:
			(parents allButFirst
				inject: (parents first runOn: aMooseGroup)
				into: [ :queryResult :otherQuery | otherQuery runOn: queryResult ])
]
