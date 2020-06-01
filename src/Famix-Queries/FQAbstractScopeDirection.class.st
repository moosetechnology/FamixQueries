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
FQAbstractScopeDirection class >> availableDirections [
	" Not 'self allSubclasses' because we want this specific order"

	^ {FQScopeUp.
	FQScopeUpAndDown.
	FQScopeDown}
]

{ #category : #'available scopes' }
FQAbstractScopeDirection class >> availableScopesFor: aMooseGroup [
	^ ((self respondingEntitiesIn: aMooseGroup) entities
		flatCollectAsSet: [ :entity | 
			(self availableScopesForEntity: entity)
				reject: [ :type | type isTrait ] ]) asArray
]

{ #category : #'available scopes' }
FQAbstractScopeDirection class >> availableScopesForEntity: entity [
	^ self subclassResponsibility
]

{ #category : #default }
FQAbstractScopeDirection class >> defaultDirection [
	^ FQScopeUpAndDown
]

{ #category : #printing }
FQAbstractScopeDirection class >> label [
	^ self subclassResponsibility
]

{ #category : #'available scopes' }
FQAbstractScopeDirection class >> respondingEntitiesIn: aMooseGroup [
	self
		flag:
			#FQImprove
				, 'Does a selection on the entities. They may not all respond'.
	^ aMooseGroup allUsing: TEntityMetaLevelDependency
]

{ #category : #scoping }
FQAbstractScopeDirection class >> scope: aFamixClass on: aMooseGroup [
	^ self subclassResponsibility
]

{ #category : #printing }
FQAbstractScopeDirection class >> scopingSelector [
	^ self subclassResponsibility
]
