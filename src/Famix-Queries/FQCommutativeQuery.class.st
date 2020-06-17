Class {
	#name : #FQCommutativeQuery,
	#superclass : #FQBinaryQuery,
	#instVars : [
		'parents'
	],
	#category : #'Famix-Queries-Queries-Binary'
}

{ #category : #testing }
FQCommutativeQuery class >> isCommutative [
	^ true
]

{ #category : #initialization }
FQCommutativeQuery >> initialize [
	super initialize.
	parents := Set new
]

{ #category : #accessing }
FQCommutativeQuery >> parents [
	^ parents
]

{ #category : #accessing }
FQCommutativeQuery >> parents: anObject [
	parents := anObject
]

{ #category : #replacing }
FQCommutativeQuery >> replaceParent: aParentQuery with: anotherQuery [
	aParentQuery removeChild: self.
	self parents
		remove: aParentQuery;
		add: anotherQuery.
	anotherQuery addChild: self
]

{ #category : #removing }
FQCommutativeQuery >> resetParents [
	parents := Set new
]
