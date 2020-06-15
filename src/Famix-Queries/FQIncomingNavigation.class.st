"
I am a direction strategy used by FQNavigationQuery.

See my Class side.

My main method is #query:with:
	- It is called by an FQNavigationQuery
	- It takes as argument an input MooseGroup and an association strategy (see FQAstractNaigationAssociations).
	- It triggers the associations strategy to collect the opposites of the incoming associations of the input entities and their children.
	- It returns a mooseGroup
		
I also provide #availableAssociationsFor: method.
It uses MooseQuery trait TEntityMetaLevelDependency.
It returns the incoming associations types for the input entity and its children.
"
Class {
	#name : #FQIncomingNavigation,
	#superclass : #FQAbstractNavigationDirection,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #accessing }
FQIncomingNavigation class >> associationsFor: aMooseGroup [
	^ aMooseGroup allEntityTypes flatCollectAsSet: [ :class | class allIncomingAssociationTypesIn: aMooseGroup metamodel ]
]

{ #category : #printing }
FQIncomingNavigation class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayIncomingOn: aStream
]

{ #category : #printing }
FQIncomingNavigation class >> label [
	^ 'Incoming'
]

{ #category : #action }
FQIncomingNavigation class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryIncomingWith: anEntity
]
