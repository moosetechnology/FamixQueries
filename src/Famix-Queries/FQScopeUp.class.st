Class {
	#name : #FQScopeUp,
	#superclass : #FQAbstractScopeDirection,
	#category : #'Famix-Queries-Scope-Strategies'
}

{ #category : #'available scopes' }
FQScopeUp class >> availableScopesForEntity: entity [
	^ entity allParentTypes
]

{ #category : #'as yet unclassified' }
FQScopeUp class >> label [
	^ 'Up'
]

{ #category : #scoping }
FQScopeUp class >> scope: aFamixClass on: aMooseGroup [
	^ ((MooseObjectQueryResult withAll: aMooseGroup) atScope: aFamixClass)
		asMooseGroup
]

{ #category : #acessing }
FQScopeUp class >> scopingSelector [
	^ #atScope:
]
