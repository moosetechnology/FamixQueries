"
I am a direction strategy used by FQNavigationQuery.

See my Class side.

My main method is #query:with:
	- It is called by an FQNavigationQuery
	- It takes as argument an input MooseGroup and an association strategy (see FQAstractNaigationAssociations).
	- It triggers the associations strategy to collect the opposites of the incoming associations of the input entities.
	- It returns a mooseGroup
		
I also provide #availableAssociationsFor: method.
It uses MooseQuery trait TEntityMetaLevelDependency.
It returns the incoming associations types for the input entity.
"
Class {
	#name : #FQLocalIncomingNavigation,
	#superclass : #FQAbstractNavigationDirection,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #accessing }
FQLocalIncomingNavigation class >> associationsFor: aMooseGroup [
	^ aMooseGroup allEntityTypes flatCollectAsSet: [ :class | class incomingAssociationTypesIn: aMooseGroup metamodel ]
]

{ #category : #printing }
FQLocalIncomingNavigation class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayLocalIncomingOn: aStream
]

{ #category : #printing }
FQLocalIncomingNavigation class >> label [
	^ 'Local Incoming'
]

{ #category : #action }
FQLocalIncomingNavigation class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryLocalIncomingWith: anEntity
]
