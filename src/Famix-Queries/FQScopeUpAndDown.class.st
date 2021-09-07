"
I am a direction strategy used by FQScopeQuery to scope entities.

I am responsible for a call to MooseQuery to navigate containment.

See my Class side.

My main method is #scope:on:
	- It takes as argument a scope; i.e. a Famix**Entity class (** depends on the meta-model)
	and an input MooseGroup.
	- It collects, for each entities of the input, the entities
		- that have a containment relation (both containing and being contained) with the input entity
		- which type is the scope.
		
I also provide #availableScopesForEntity: method.
It returns the types of the entities that have a containment relation (both containing and being contained) with the input entity.
"
Class {
	#name : #FQScopeUpAndDown,
	#superclass : #FQAbstractScopeDirection,
	#category : #'Famix-Queries-Scope-Strategies'
}

{ #category : #'available scopes' }
FQScopeUpAndDown class >> availableScopesForEntity: class in: model [
	^ (self allChildrenScopesOf: class in: model) , (self allParentsScopesOf: class in: model)
]

{ #category : #printing }
FQScopeUpAndDown class >> label [
	^ 'Up and Down'
]

{ #category : #accessing }
FQScopeUpAndDown class >> priority [
	^ 15
]

{ #category : #scoping }
FQScopeUpAndDown class >> scope: aFamixClass on: entity [

	^ entity query lineage ofType: aFamixClass
]

{ #category : #printing }
FQScopeUpAndDown class >> scopingSelector [
	^ #withScope:
]
