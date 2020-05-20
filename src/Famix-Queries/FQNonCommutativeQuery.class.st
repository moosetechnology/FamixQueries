Class {
	#name : #FQNonCommutativeQuery,
	#superclass : #FQBinaryQuery,
	#instVars : [
		'firstParent',
		'secondParent'
	],
	#category : #'Famix-Queries-Core'
}

{ #category : #testing }
FQNonCommutativeQuery class >> isCommutative [
	^ false
]

{ #category : #accessing }
FQNonCommutativeQuery >> parents [
	^ {firstParent.
	secondParent} copyWithout: nil
]

{ #category : #accessing }
FQNonCommutativeQuery >> parents: twoParentQueries [
	firstParent := twoParentQueries first.
	secondParent := twoParentQueries second
]

{ #category : #removing }
FQNonCommutativeQuery >> resetParents [
	firstParent := nil.
	secondParent := nil
]

{ #category : #'as yet unclassified' }
FQNonCommutativeQuery >> reverseParents [
	self parents: self parents reverse.
	self resetResult
]
