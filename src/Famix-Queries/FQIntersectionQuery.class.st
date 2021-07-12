Class {
	#name : #FQIntersectionQuery,
	#superclass : #FQNAryQuery,
	#category : #'Famix-Queries-Queries-N-ary'
}

{ #category : #testing }
FQIntersectionQuery class >> isCommutative [
	^ true
]

{ #category : #accessing }
FQIntersectionQuery class >> label [

	^ 'And Query'
]

{ #category : #printing }
FQIntersectionQuery >> defaultName [
	^ subqueries first name , ' & ' , subqueries second name
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
