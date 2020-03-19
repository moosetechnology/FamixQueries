Class {
	#name : #FQSubstractionQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'childrenQueries'
	],
	#category : #'Famix-Queries-Combinator'
}

{ #category : #'instance creation' }
FQSubstractionQuery class >> forQueries: aCollectionOfQueries [
	^ self new
		childrenQueries: aCollectionOfQueries asOrderedCollection;
		yourself
]

{ #category : #accessing }
FQSubstractionQuery >> childrenQueries [
	^ childrenQueries
]

{ #category : #accessing }
FQSubstractionQuery >> childrenQueries: anObject [
	childrenQueries := anObject
]

{ #category : #running }
FQSubstractionQuery >> displayOn: aStream with: aString [
	self childrenQueries size = 1
		ifTrue: [ self childrenQueries first displayOn: aStream with: aString.
			^ self ].
	aStream << '('.
	self childrenQueries
		allButLastDo: [ :query | 
			query displayOn: aStream with: aString.
			aStream << ') \ (' ].
	self childrenQueries last displayOn: aStream with: aString.
	aStream << ')'
]

{ #category : #running }
FQSubstractionQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ MooseGroup
		withAll:
			(self childrenQueries allButFirst
				inject: (self childrenQueries first runOn: aMooseGroup)
				into:
					[ :queryResult :otherQuery | queryResult difference: (otherQuery runOn: aMooseGroup) ])
]
