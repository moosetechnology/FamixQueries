Class {
	#name : #FQUnionQuery,
	#superclass : #FQNaryQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #testing }
FQUnionQuery class >> isCommutative [
	^ true
]

{ #category : #accessing }
FQUnionQuery class >> label [

	^ 'Or Query'
]

{ #category : #printing }
FQUnionQuery >> defaultName [
	^ self subqueries first name , ' | ' , self subqueries second name
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
