Class {
	#name : #FQSequenceQuery,
	#superclass : #FQNonCommutativeQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #'instance creation' }
FQSequenceQuery class >> forQueries: aCollectionOfQueries [
	^ self new
		parents: aCollectionOfQueries asOrderedCollection;
		yourself
]

{ #category : #printing }
FQSequenceQuery >> defaultName [
	^ 'Sequence'
]

{ #category : #running }
FQSequenceQuery >> displayOn: aStream with: aString [
	1 to: self parents size - 1 do: [ :i | aStream << '(' ].
	firstParent displayOn: aStream.
	self parents
		allButFirstDo: [ :query | 
			aStream
				<<
					')
	'.
			query displayOn: aStream with: '' ]
]

{ #category : #running }
FQSequenceQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ MooseGroup
		withAll:
			(self parents allButFirst
				inject: (self parents first runOn: aMooseGroup)
				into: [ :queryResult :otherQuery | otherQuery runOn: queryResult ])
]
