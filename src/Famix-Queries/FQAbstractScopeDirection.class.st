"
I am a direction strategy used by FQScopeQuery to scope entities.

I am responsible for a call to MooseQuery to navigate containment.

See my Class side.

My main method is #scope:on:
	- It takes as argument a scope; i.e. a Famix**Entity class (** depends on the meta-model)
	and an input MooseGroup.
	- It collects, for each entities of the input, the entities
		- that have a containment relation with the input entity
		- which type is the scope.
		
I also provide #availableScopesForEntity: method.
It returns the types of the entities that have a containment relation with the input entity.

The direction of the considered containment relations depend on my subclasses behavior.
"
Class {
	#name : #FQAbstractScopeDirection,
	#superclass : #Object,
	#category : #'Famix-Queries-Scope-Strategies'
}

{ #category : #'available scopes' }
FQAbstractScopeDirection class >> allChildrenScopesOf: aClass in: aModel [
	"Return all the possible children scopes of this class that are in a model."

	^ (aClass allChildrenTypesIn: aModel metamodel) flatCollectAsSet: #withAllSubclasses
]

{ #category : #'available scopes' }
FQAbstractScopeDirection class >> allParentsScopesOf: aClass in: aModel [
	"Return all the possible parents scopes of this class that are in a model."

	^ (aClass allParentTypesIn: aModel metamodel) flatCollectAsSet: #withAllSubclasses
]

{ #category : #'available scopes' }
FQAbstractScopeDirection class >> availableScopesFor: aMooseGroup [
	"Return the list of possible scopes in a moose group for the direction of the strategy."

	| model |
	aMooseGroup ifEmpty: [ ^ {} ].
	model := aMooseGroup isMooseModel
		ifTrue: [ aMooseGroup ]
		ifFalse: [ aMooseGroup mooseModel ].
	^ (((aMooseGroup allUsing: TEntityMetaLevelDependency) allEntityTypes
		flatCollectAsSet: [ :class | self availableScopesForEntity: class in: model ])
		& model allEntityTypes) asArray
]

{ #category : #'available scopes' }
FQAbstractScopeDirection class >> availableScopesForEntity: class in: model [
	"Return the list of possible scopes for a class in a model for the direction of the strategy."

	^ self subclassResponsibility
]

{ #category : #default }
FQAbstractScopeDirection class >> defaultDirection [
	^ FQScopeUpAndDown
]

{ #category : #'available scopes' }
FQAbstractScopeDirection class >> directionStrategies [
	^ self allSubclasses sort: #priority ascending
]

{ #category : #printing }
FQAbstractScopeDirection class >> label [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQAbstractScopeDirection class >> priority [
	^ self subclassResponsibility
]

{ #category : #scoping }
FQAbstractScopeDirection class >> scope: aFamixClass on: aMooseGroup [
	^ self subclassResponsibility
]

{ #category : #printing }
FQAbstractScopeDirection class >> scopingSelector [
	^ self subclassResponsibility
]
