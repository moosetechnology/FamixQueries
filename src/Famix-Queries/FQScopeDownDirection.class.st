Class {
	#name : #FQScopeDownDirection,
	#superclass : #FQAbstractScopeDirection,
	#category : #'Famix-Queries-Utils'
}

{ #category : #'available scopes' }
FQScopeDownDirection class >> availableScopesForEntity: entity [
	^ entity allChildrenTypes
]

{ #category : #scoping }
FQScopeDownDirection class >> scope: aFamixClass on: aMooseGroup [
	^ ((MooseObjectQueryResult withAll: aMooseGroup) toScope: aFamixClass)
		asMooseGroup
]

{ #category : #accessing }
FQScopeDownDirection class >> scopingSelector [
	^ #toScope:
]
