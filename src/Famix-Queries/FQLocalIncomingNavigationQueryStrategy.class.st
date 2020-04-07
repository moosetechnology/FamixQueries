Class {
	#name : #FQLocalIncomingNavigationQueryStrategy,
	#superclass : #FQAbstractDirectionNavigationQueryStrategy,
	#category : #'Famix-Queries-Utils'
}

{ #category : #accessing }
FQLocalIncomingNavigationQueryStrategy class >> availableAssociationsFor: aMooseGroup [
	^ aMooseGroup entities flatCollectAsSet: #incomingMSEProperties
]

{ #category : #action }
FQLocalIncomingNavigationQueryStrategy class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayLocalIncomingOn: aStream
]

{ #category : #accessing }
FQLocalIncomingNavigationQueryStrategy class >> label [
	^ 'Local Incoming'
]

{ #category : #action }
FQLocalIncomingNavigationQueryStrategy class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryLocalIncomingWith: anEntity
]
