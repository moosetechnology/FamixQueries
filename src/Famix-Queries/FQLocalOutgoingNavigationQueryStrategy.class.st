Class {
	#name : #FQLocalOutgoingNavigationQueryStrategy,
	#superclass : #FQAbstractDirectionNavigationQueryStrategy,
	#category : #'Famix-Queries-Utils'
}

{ #category : #accessing }
FQLocalOutgoingNavigationQueryStrategy class >> availableAssociationsFor: aMooseGroup [
	^ aMooseGroup entities flatCollectAsSet: #outgoingMSEProperties
]

{ #category : #printing }
FQLocalOutgoingNavigationQueryStrategy class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayLocalOutgoingOn: aStream
]

{ #category : #action }
FQLocalOutgoingNavigationQueryStrategy class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryLocalOutgoingWith: anEntity
]
