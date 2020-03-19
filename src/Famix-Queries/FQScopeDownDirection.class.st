Class {
	#name : #FQScopeDownDirection,
	#superclass : #FQAbstractScopeDirection,
	#category : #'Famix-Queries-Utils'
}

{ #category : #scoping }
FQScopeDownDirection class >> scope: aFamixClass on: aMooseGroup [
	^ ((MooseObjectQueryResult withAll: aMooseGroup) toScope: aFamixClass)
		asMooseGroup
]

{ #category : #acessing }
FQScopeDownDirection class >> scopingSelector [
	^ #toScope:
]
