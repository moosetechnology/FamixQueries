Class {
	#name : #FQUnionQuery,
	#superclass : #FQCommutativeQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #accessing }
FQUnionQuery class >> label [
	^ 'Union'
]

{ #category : #printing }
FQUnionQuery >> defaultName [
	^ self parents first name , ' | ' , self parents second name
]

{ #category : #printing }
FQUnionQuery >> operator [
	^ $|
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
