Class {
	#name : #FQNonCommutativeQuery,
	#superclass : #FQBinaryQuery,
	#instVars : [
		'firstParent',
		'secondParent'
	],
	#category : #'Famix-Queries-Queries-Binary'
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

{ #category : #replacing }
FQNonCommutativeQuery >> replaceParent: aParentQuery with: anotherQuery [
	(self parents includes: aParentQuery)
		ifFalse: [ ^ self ].
	aParentQuery removeChild: self.
	anotherQuery addChild: self.
	firstParent == aParentQuery
		ifTrue: [ firstParent := anotherQuery ].
	secondParent == aParentQuery
		ifTrue: [ secondParent := anotherQuery ]
]

{ #category : #removing }
FQNonCommutativeQuery >> resetParents [
	firstParent := nil.
	secondParent := nil
]

{ #category : #reversing }
FQNonCommutativeQuery >> reverseParents [
	self parents: self parents reverse.
	self resetResult
]
