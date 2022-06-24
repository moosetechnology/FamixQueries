"
I am a direction strategy used by FQScopeQuery to scope entities.

I am responsible for a call to MooseQuery to navigate containment.

See my Class side.

My main method is #scope:on:
	- It takes as argument a scope; i.e. a Famix**Entity class (** depends on the meta-model)
	and an input MooseGroup.
	- It collects, for each entities of the input, the entities
		- that contain the input entity
		- which type is the scope.
		
I also provide #availableScopesForEntity: method.
It returns the types of the entities that contain the input entity.
"
Class {
	#name : #FQScopeUp,
	#superclass : #FQAbstractScopeDirection,
	#category : #'Famix-Queries-Scope-Strategies'
}

{ #category : #'available scopes' }
FQScopeUp class >> availableScopesForEntity: class in: model [
	^ self allParentsScopesOf: class in: model
]

{ #category : #printing }
FQScopeUp class >> label [
	^ 'Up'
]

{ #category : #accessing }
FQScopeUp class >> priority [
	^ 10
]

{ #category : #scoping }
FQScopeUp class >> scope: aFamixClass on: entity [

	^ entity query ancestors ofType: aFamixClass
]

{ #category : #scoping }
FQScopeUp class >> scope: aFamixClass recursively: aBoolean on: entity [

	^ (entity query ancestors isRecursive: aBoolean) ofType: aFamixClass
]

{ #category : #printing }
FQScopeUp class >> scopingSelector [
	^ #atScope:
]
