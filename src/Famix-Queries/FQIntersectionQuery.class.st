"
I make the intersection operation for all my subqueries (can be more than two) between them.

See `FQIntersectionQuery>>#runOn:`
"
Class {
	#name : 'FQIntersectionQuery',
	#superclass : 'FQNAryQuery',
	#category : 'Famix-Queries-Queries-N-ary',
	#package : 'Famix-Queries',
	#tag : 'Queries-N-ary'
}

{ #category : 'testing' }
FQIntersectionQuery class >> isCommutative [
	^ true
]

{ #category : 'accessing' }
FQIntersectionQuery class >> label [

	^ 'And Query'
]

{ #category : 'printing' }
FQIntersectionQuery >> defaultName [
	^ subqueries first name , ' & ' , subqueries second name
]

{ #category : 'printing' }
FQIntersectionQuery >> operator [
	^ $&
]

{ #category : 'running' }
FQIntersectionQuery >> rawRunOn: mooseGroups [

	^ mooseGroups fold: [ :a :b | a intersection: b ]
]
