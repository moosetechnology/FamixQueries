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
	#name : 'FQScopeContainers',
	#superclass : 'FQAbstractScopeDirection',
	#category : 'Famix-Queries-Scope-Strategies',
	#package : 'Famix-Queries',
	#tag : 'Scope-Strategies'
}

{ #category : 'available scopes' }
FQScopeContainers class >> availableScopesForEntity: class in: model [
	^ self allContainersScopesOf: class in: model
]

{ #category : 'printing' }
FQScopeContainers class >> label [
	^ 'Up'
]

{ #category : 'accessing' }
FQScopeContainers class >> priority [
	^ 10
]

{ #category : 'scoping' }
FQScopeContainers class >> scope: aFamixClass on: entity [

	^ entity query containers ofType: aFamixClass
]

{ #category : 'scoping' }
FQScopeContainers class >> scope: aFamixClass recursively: aBoolean on: entity [

	^ (entity query containers isRecursive: aBoolean) ofType: aFamixClass
]

{ #category : 'printing' }
FQScopeContainers class >> scopingSelector [
	^ #atScope:
]
