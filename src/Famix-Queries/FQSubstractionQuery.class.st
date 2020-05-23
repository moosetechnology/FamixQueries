Class {
	#name : #FQSubstractionQuery,
	#superclass : #FQNonCommutativeQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #accessing }
FQSubstractionQuery class >> label [
	^ 'Substraction'
]

{ #category : #printing }
FQSubstractionQuery >> defaultName [
	^ firstParent name , ' \ ' , secondParent name
]

{ #category : #printing }
FQSubstractionQuery >> operator [
	^ $\
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
