Class {
	#name : #FQSubstractionQuery,
	#superclass : #FQBinaryQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #testing }
FQSubstractionQuery class >> isCommutative [
	^ false
]

{ #category : #accessing }
FQSubstractionQuery class >> label [
	^ 'Substraction'
]

{ #category : #printing }
FQSubstractionQuery >> defaultName [
	^ self parents first name , ' \ ' , self parents second name
]

{ #category : #printing }
FQSubstractionQuery >> operator [
	^ $\
]

{ #category : #reversing }
FQSubstractionQuery >> reverseParents [
	self parents: self parents reverse.
	self resetResult
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
