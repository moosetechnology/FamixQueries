Class {
	#name : #FQIntersectionQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'childrenQueries'
	],
	#category : #'Famix-Queries-Combinator'
}

{ #category : #'instance creation' }
FQIntersectionQuery class >> forQueries: aCollectionOfQueries [
	^ self new
		childrenQueries: aCollectionOfQueries asOrderedCollection;
		yourself
]

{ #category : #accessing }
FQIntersectionQuery >> childrenQueries [
	^ childrenQueries
]

{ #category : #accessing }
FQIntersectionQuery >> childrenQueries: anObject [
	childrenQueries := anObject
]

{ #category : #running }
FQIntersectionQuery >> displayOn: aStream with: aString [
	self childrenQueries size = 1
		ifTrue: [ self childrenQueries first displayOn: aStream.
			^ self ].
	aStream << '('.
	self childrenQueries
		allButLastDo: [ :query | 
			query displayOn: aStream with: aString.
			aStream << ') & (' ].
	self childrenQueries last displayOn: aStream with: aString.
	aStream << ')'
]

{ #category : #running }
FQIntersectionQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	| childrenResults |
	childrenResults := self childrenQueries
		collect: [ :query | query runOn: aMooseGroup ].
	^ MooseGroup
		withAll:
			(childrenResults
				fold:
					[ :currentResult :otherResult | currentResult intersection: otherResult ])
]
