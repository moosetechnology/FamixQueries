Class {
	#name : #FQIntersectionQuery,
	#superclass : #FQCommutativeQuery,
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

{ #category : #printing }
FQIntersectionQuery >> defaultName [
	^ 'Intersection'
]

{ #category : #printing }
FQIntersectionQuery >> operator [
	^ $&
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
