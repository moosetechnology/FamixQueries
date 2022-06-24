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
FQScopeDown class >> availableScopesForEntity: class in: model [
	^ self allChildrenScopesOf: class in: model
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
FQScopeDown class >> scope: aFamixClass on: entity [

	^ entity query descendants ofType: aFamixClass
]

{ #category : #scoping }
FQScopeDown class >> scope: aFamixClass recursively: aBoolean on: entity [

	^ (entity query descendants isRecursive: aBoolean) ofType:
		  aFamixClass
]

{ #category : #printing }
FQScopeDown class >> scopingSelector [
	^ #toScope:
]
