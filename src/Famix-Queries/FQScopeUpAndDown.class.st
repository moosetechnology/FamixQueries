Class {
	#name : #FQScopeUpAndDown,
	#superclass : #FQAbstractScopeDirection,
	#category : #'Famix-Queries-Scope-Strategies'
}

{ #category : #'available scopes' }
FQScopeUpAndDown class >> availableScopesForEntity: entity [
	^ {entity allParentTypes.
	entity allChildrenTypes} flatten
]

{ #category : #'as yet unclassified' }
FQScopeUpAndDown class >> label [
	^ 'Up and Down'
]

{ #category : #scoping }
FQScopeUpAndDown class >> scope: aFamixClass on: aMooseGroup [
	^ ((MooseObjectQueryResult withAll: aMooseGroup)
		withScope: aFamixClass) asMooseGroup
]

{ #category : #acessing }
FQScopeUpAndDown class >> scopingSelector [
	^ #withScope:
]
