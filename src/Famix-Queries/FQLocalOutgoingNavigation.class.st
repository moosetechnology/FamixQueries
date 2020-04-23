Class {
	#name : #FQLocalOutgoingNavigation,
	#superclass : #FQAbstractNavigationDirection,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #accessing }
FQLocalOutgoingNavigation class >> availableAssociationsFor: aMooseGroup [
	^ aMooseGroup entities flatCollectAsSet: #outgoingMSEProperties
]

{ #category : #printing }
FQLocalOutgoingNavigation class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayLocalOutgoingOn: aStream
]

{ #category : #printing }
FQLocalOutgoingNavigation class >> label [
	^ 'Local Outgoing'
]

{ #category : #action }
FQLocalOutgoingNavigation class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryLocalOutgoingWith: anEntity
]
