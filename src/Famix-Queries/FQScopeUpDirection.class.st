Class {
	#name : #FQScopeUpDirection,
	#superclass : #FQAbstractScopeDirection,
	#category : #'Famix-Queries-Utils'
}

{ #category : #'available scopes' }
FQScopeUpDirection class >> availableScopesForEntity: entity [
	^ entity allParentTypes
]

{ #category : #scoping }
FQScopeUpDirection class >> scope: aFamixClass on: aMooseGroup [
	^ ((MooseObjectQueryResult withAll: aMooseGroup) atScope: aFamixClass)
		asMooseGroup
]

{ #category : #acessing }
FQScopeUpDirection class >> scopingSelector [
	^ #atScope:
]
