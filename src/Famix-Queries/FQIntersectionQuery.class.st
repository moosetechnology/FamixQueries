"
I make the intersection operation for all my subqueries (can be more than two) between them.

See `FQIntersectionQuery>>#runOn:`
"
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

	^ 'Intersection Query'
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
FQIntersectionQuery >> runOn: mooseGroups [

	^ mooseGroups fold: [ :a :b | a intersection: b ]
]
