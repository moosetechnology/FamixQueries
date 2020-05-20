Class {
	#name : #FQSubstractionQuery,
	#superclass : #FQNonCommutativeQuery,
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #'instance creation' }
FQSubstractionQuery class >> forQueries: aCollectionOfQueries [
	^ self new
		parents: aCollectionOfQueries asOrderedCollection;
		yourself
]

{ #category : #accessing }
FQSubstractionQuery class >> label [
	^ 'Substraction'
]

{ #category : #printing }
FQSubstractionQuery >> defaultName [
	^ 'Substraction'
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
