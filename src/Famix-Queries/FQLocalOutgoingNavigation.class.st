"
I am a direction strategy used by FQNavigationQuery.

See my Class side.

My main method is #query:with:
	- It is called by an FQNavigationQuery
	- It takes as argument an input MooseGroup and an association strategy (see FQAstractNaigationAssociations).
	- It triggers the associations strategy to collect the opposites of the outgoing associations of the input entities.
	- It returns a mooseGroup
		
I also provide #availableAssociationsFor: method.
It uses MooseQuery trait TEntityMetaLevelDependency.
It returns the outgoing associations types for the input entity.
"
Class {
	#name : 'FQLocalOutgoingNavigation',
	#superclass : 'FQAbstractNavigationDirection',
	#category : 'Famix-Queries-Navigation-Strategies',
	#package : 'Famix-Queries',
	#tag : 'Navigation-Strategies'
}

{ #category : 'accessing' }
FQLocalOutgoingNavigation class >> associationsFor: aMooseGroup [
	^ aMooseGroup allEntityTypes flatCollectAsSet: [ :class | class outgoingAssociationTypesIn: aMooseGroup metamodel ]
]

{ #category : 'printing' }
FQLocalOutgoingNavigation class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayLocalOutgoingOn: aStream
]

{ #category : 'printing' }
FQLocalOutgoingNavigation class >> label [
	^ 'Local Outgoing'
]

{ #category : 'action' }
FQLocalOutgoingNavigation class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryLocalOutgoingWith: anEntity
]
