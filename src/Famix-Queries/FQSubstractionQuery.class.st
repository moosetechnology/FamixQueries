Class {
	#name : #FQSubstractionQuery,
	#superclass : #FQBinaryQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #'instance creation' }
FQSubstractionQuery class >> forQueries: aCollectionOfQueries [
	^ self new
		parents: aCollectionOfQueries asOrderedCollection;
		yourself
]

{ #category : #accessing }
FQSubstractionQuery class >> label [
	^ 'Substraction'
]

{ #category : #comparing }
FQSubstractionQuery >> = aQuery [
	^ aQuery class == self class and: [ aQuery parents = parents ]
]

{ #category : #printing }
FQSubstractionQuery >> defaultName [
	^ 'Substraction'
]

{ #category : #running }
FQSubstractionQuery >> displayOn: aStream with: aString [
	parents size = 1
		ifTrue: [ parents first displayOn: aStream with: aString.
			^ self ].
	aStream << '('.
	parents
		allButLastDo: [ :query | 
			query displayOn: aStream with: aString.
			aStream << ') \ (' ].
	parents last displayOn: aStream with: aString.
	aStream << ')'
]

{ #category : #testing }
FQSubstractionQuery >> isValid [
	^ parents allSatisfy: #isValid
]

{ #category : #running }
FQSubstractionQuery >> runOn: twoMooseGroups [
	^ twoMooseGroups first difference: twoMooseGroups second

	"^ MooseGroup
		withAll:
			(self childrenQueries allButFirst
				inject: (self childrenQueries first runOn: aMooseGroup)
				into:
					[ :queryResult :otherQuery | queryResult difference: (otherQuery runOn: aMooseGroup) ])"
]
