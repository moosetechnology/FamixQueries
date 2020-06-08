"
I am a direction strategy used by FQScopeQuery to scope entities.

I am responsible for a call to MooseQuery to navigate containment.

See my Class side.

My main method is #scope:on:
	- It takes as argument a scope; i.e. a Famix**Entity class (** depends on the meta-model)
	and an input MooseGroup.
	- It collects, for each entities of the input, the entities
		- that are contained in the input entity
		- which type is the scope.
		
I also provide #availableScopesForEntity: method.
It returns the types of the entities that are contained in the input entity.
"
Class {
	#name : #FQScopeDown,
	#superclass : #FQAbstractScopeDirection,
	#category : #'Famix-Queries-Scope-Strategies'
}

{ #category : #'available scopes' }
FQScopeDown class >> availableScopesForEntity: entity [
	^ entity allChildrenTypes
]

{ #category : #printing }
FQScopeDown class >> label [
	^ 'Down'
]

{ #category : #accessing }
FQScopeDown class >> priority [
	^ 20
]

{ #category : #scoping }
FQScopeDown class >> scope: aFamixClass on: aMooseGroup [
	^ ((MooseObjectQueryResult withAll: aMooseGroup) toScope: aFamixClass)
		asMooseGroup
]

{ #category : #printing }
FQScopeDown class >> scopingSelector [
	^ #toScope:
]
