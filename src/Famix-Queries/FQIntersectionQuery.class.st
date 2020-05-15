Class {
	#name : #FQIntersectionQuery,
	#superclass : #FQBinaryQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #'instance creation' }
FQIntersectionQuery class >> forQueries: aCollectionOfQueries [
	^ self new
		parents: aCollectionOfQueries asOrderedCollection;
		yourself
]

{ #category : #accessing }
FQIntersectionQuery class >> label [
	^ 'Intersection'
]

{ #category : #comparing }
FQIntersectionQuery >> = aQuery [
	^ aQuery class == self class and: [ aQuery parents = parents ]
]

{ #category : #printing }
FQIntersectionQuery >> defaultName [
	^ 'Intersection'
]

{ #category : #running }
FQIntersectionQuery >> displayOn: aStream with: aString [
	parents size = 1
		ifTrue: [ parents first displayOn: aStream.
			^ self ].
	aStream << '('.
	parents
		allButLastDo: [ :query | 
			query displayOn: aStream with: aString.
			aStream << ') & (' ].
	parents last displayOn: aStream with: aString.
	aStream << ')'
]

{ #category : #testing }
FQIntersectionQuery >> isValid [
	^ parents allSatisfy: #isValid
]

{ #category : #running }
FQIntersectionQuery >> runOn: twoMooseGroups [
	^ twoMooseGroups first intersection: twoMooseGroups second
	
	"| childrenResults |
	childrenResults := self childrenQueries
		collect: [ :query | query runOn: aMooseGroup ].
	^ MooseGroup
		withAll:
			(childrenResults
				fold:
					[ :currentResult :otherResult | currentResult intersection: otherResult ])"
]
