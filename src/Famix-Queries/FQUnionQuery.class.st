"
I make the union operation for all my subqueries (can be more than two) between them.

See `FQUnionQuery>>#runOn:`
"
Class {
	#name : #FQUnionQuery,
	#superclass : #FQNAryQuery,
	#category : #'Famix-Queries-Queries-N-ary'
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
FQUnionQuery >> rawRunOn: mooseGroups [

	^ mooseGroups fold: [ :a :b | a union: b ]
]
