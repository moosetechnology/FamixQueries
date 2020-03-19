Class {
	#name : #FQAbstractScopeDirection,
	#superclass : #Object,
	#category : #'Famix-Queries-Utils'
}

{ #category : #default }
FQAbstractScopeDirection class >> defaultDirection [
	^ FQScopeUpDownDirection
]

{ #category : #scoping }
FQAbstractScopeDirection class >> scope: aFamixClass on: aMooseGroup [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQAbstractScopeDirection class >> scopingSelector [
	^ self subclassResponsibility
]
