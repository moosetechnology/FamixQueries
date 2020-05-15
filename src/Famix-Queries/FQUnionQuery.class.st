Class {
	#name : #FQUnionQuery,
	#superclass : #FQBinaryQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #'instance creation' }
FQUnionQuery class >> forQueries: aCollectionOfQueries [
	^ self new
		parents: aCollectionOfQueries asOrderedCollection;
		yourself
]

{ #category : #accessing }
FQUnionQuery class >> label [
	^ 'Union'
]

{ #category : #comparing }
FQUnionQuery >> = aQuery [
	^ aQuery class == self class and: [ aQuery parents = parents ]
]

{ #category : #printing }
FQUnionQuery >> defaultName [
	^ 'Union'
]

{ #category : #printing }
FQUnionQuery >> displayOn: aStream with: aString [
	parents size = 1
		ifTrue: [ parents first displayOn: aStream with: aString.
			^ self ].
	aStream << '('.
	parents
		allButLastDo: [ :query | 
			query displayOn: aStream with: aString.
			aStream << ') | (' ].
	parents last displayOn: aStream with: aString.
	aStream << ')'
]

{ #category : #testing }
FQUnionQuery >> isValid [
	^ parents allSatisfy: #isValid
]

{ #category : #running }
FQUnionQuery >> runOn: twoMooseGroups [
	^ twoMooseGroups first union: twoMooseGroups second

	"| childrenResults |
	childrenResults := parents
		collect: [ :query | query runOn: aMooseGroup ].
	^ MooseGroup
		withAll:
			(childrenResults
				fold: [ :currentResult :otherResult | currentResult union: otherResult ])"
]
