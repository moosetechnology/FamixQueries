Class {
	#name : #FQIntersectionQuery,
	#superclass : #FQBinaryQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #testing }
FQIntersectionQuery class >> isCommutative [
	^ true
]

{ #category : #accessing }
FQIntersectionQuery class >> label [
	^ 'Intersection'
]

{ #category : #printing }
FQIntersectionQuery >> defaultName [
	^ parents first name , ' & ' , parents second name
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
