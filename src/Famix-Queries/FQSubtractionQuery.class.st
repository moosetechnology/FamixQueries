Class {
	#name : #FQSubtractionQuery,
	#superclass : #FQBinaryQuery,
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
	^ self parents first name , ' \ ' , self parents second name
]

{ #category : #printing }
FQSubtractionQuery >> operator [
	^ $\
]

{ #category : #reversing }
FQSubtractionQuery >> reverseParents [
	self parents: self parents reverse.
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
