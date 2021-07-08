Class {
	#name : #FQSubtractionQuery,
	#superclass : #FQNaryQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #testing }
FQSubtractionQuery class >> isCommutative [
	^ false
]

{ #category : #accessing }
FQSubtractionQuery class >> label [

	^ 'Difference'
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
FQSubtractionQuery >> runOn: twoMooseGroups [
	^ twoMooseGroups first difference: twoMooseGroups second

	"^ MooseGroup
		withAll:
			(self childrenQueries allButFirst
				inject: (self childrenQueries first runOn: aMooseGroup)
				into:
					[ :queryResult :otherQuery | queryResult difference: (otherQuery runOn: aMooseGroup) ])"
]
