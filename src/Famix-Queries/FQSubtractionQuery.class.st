"
I make the subtraction operation for all my subqueries (can be more than two) between them.

See `FQSubtractionQuery>>#runOn:`
"
Class {
	#name : #FQSubtractionQuery,
	#superclass : #FQNAryQuery,
	#category : #'Famix-Queries-Queries-N-ary'
}

{ #category : #testing }
FQSubtractionQuery class >> isCommutative [
	^ false
]

{ #category : #accessing }
FQSubtractionQuery class >> label [

	^ 'Difference Query'
]

{ #category : #printing }
FQSubtractionQuery >> defaultName [
	^ self subqueries first name , ' \ ' , self subqueries second name
]

{ #category : #printing }
FQSubtractionQuery >> operator [
	^ $\
]

{ #category : #reversing }
FQSubtractionQuery >> reverseParents [
	self subqueries: self subqueries reverse.
	self resetResult
]

{ #category : #running }
FQSubtractionQuery >> runOn: mooseGroups [

	^ mooseGroups fold: [ :a :b | a difference: b ]

	"^ MooseGroup
		withAll:
			(self childrenQueries allButFirst
				inject: (self childrenQueries first runOn: aMooseGroup)
				into:
					[ :queryResult :otherQuery | queryResult difference: (otherQuery runOn: aMooseGroup) ])"
]
