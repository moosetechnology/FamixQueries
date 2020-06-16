"
I am a direction strategy used by FQNavigationQuery.

See my Class side.

My main method is #query:with:
	- It is called by an FQNavigationQuery
	- It takes as argument an input MooseGroup and an association strategy (see FQAstractNaigationAssociations).
	- It triggers the associations strategy to collect the opposites of the outgoing associations of the input entities and their children.
	- It returns a mooseGroup
		
I also provide #availableAssociationsFor: method.
It uses MooseQuery trait TEntityMetaLevelDependency.
It returns the outgoing associations types for the input entity and its children.
"
Class {
	#name : #FQOutgoingNavigation,
	#superclass : #FQAbstractNavigationDirection,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #accessing }
FQOutgoingNavigation class >> associationsFor: aMooseGroup [
	^ aMooseGroup allEntityTypes flatCollectAsSet: [ :class | class allOutgoingAssociationTypesIn: aMooseGroup metamodel ]
]

{ #category : #printing }
FQOutgoingNavigation class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayOutgoingOn: aStream
]

{ #category : #printing }
FQOutgoingNavigation class >> label [
	^ 'Outgoing'
]

{ #category : #action }
FQOutgoingNavigation class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryOutgoingWith: anEntity
]
