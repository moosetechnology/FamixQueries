Class {
	#name : #FQScopeUpDownDirection,
	#superclass : #FQAbstractScopeDirection,
	#category : #'Famix-Queries-Utils'
}

{ #category : #scoping }
FQScopeUpDownDirection class >> scope: aFamixClass on: aMooseGroup [
	^ ((MooseObjectQueryResult withAll: aMooseGroup)
		withScope: aFamixClass) asMooseGroup
]

{ #category : #acessing }
FQScopeUpDownDirection class >> scopingSelector [
	^ #withScope:
]
