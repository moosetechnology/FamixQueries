Class {
	#name : #FQScopeDown,
	#superclass : #FQAbstractScopeDirection,
	#category : #'Famix-Queries-Scope-Strategies'
}

{ #category : #'available scopes' }
FQScopeDown class >> availableScopesForEntity: entity [
	^ entity allChildrenTypes
]

{ #category : #'as yet unclassified' }
FQScopeDown class >> label [
	^ 'Down'
]

{ #category : #scoping }
FQScopeDown class >> scope: aFamixClass on: aMooseGroup [
	^ ((MooseObjectQueryResult withAll: aMooseGroup) toScope: aFamixClass)
		asMooseGroup
]

{ #category : #accessing }
FQScopeDown class >> scopingSelector [
	^ #toScope:
]
