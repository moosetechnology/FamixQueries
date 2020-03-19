Class {
	#name : #FQUnionQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'childrenQueries'
	],
	#category : #'Famix-Queries-Combinator'
}

{ #category : #'instance creation' }
FQUnionQuery class >> forQueries: aCollectionOfQueries [
	^ self new
		childrenQueries: aCollectionOfQueries asOrderedCollection;
		yourself
]

{ #category : #accessing }
FQUnionQuery >> childrenQueries [
	^ childrenQueries
]

{ #category : #accessing }
FQUnionQuery >> childrenQueries: anObject [
	childrenQueries := anObject
]

{ #category : #running }
FQUnionQuery >> displayOn: aStream with: aString [
	self childrenQueries size = 1
		ifTrue: [ self childrenQueries first displayOn: aStream with: aString.
			^ self ].
	aStream << '('.
	self childrenQueries
		allButLastDo: [ :query | 
			query displayOn: aStream with: aString.
			aStream << ') | (' ].
	self childrenQueries last displayOn: aStream with: aString.
	aStream << ')'
]

{ #category : #running }
FQUnionQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	| childrenResults |
	childrenResults := self childrenQueries
		collect: [ :query | query runOn: aMooseGroup ].
	^ MooseGroup
		withAll:
			(childrenResults
				fold:
					[ :currentResult :otherResult | currentResult union: otherResult ])
]
