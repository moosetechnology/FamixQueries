Class {
	#name : #FQLocalIncomingNavigation,
	#superclass : #FQAbstractNavigationDirection,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #accessing }
FQLocalIncomingNavigation class >> availableAssociationsFor: aMooseGroup [
	^ aMooseGroup entities flatCollectAsSet: #incomingMSEProperties
]

{ #category : #action }
FQLocalIncomingNavigation class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayLocalIncomingOn: aStream
]

{ #category : #'as yet unclassified' }
FQLocalIncomingNavigation class >> label [
	^ 'Local Incoming'
]

{ #category : #action }
FQLocalIncomingNavigation class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryLocalIncomingWith: anEntity
]
