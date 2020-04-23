Class {
	#name : #FQIncomingNavigation,
	#superclass : #FQAbstractNavigationDirection,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #accessing }
FQIncomingNavigation class >> availableAssociationsFor: aMooseGroup [
	^ aMooseGroup entities
		flatCollectAsSet: [ :entity | self availableAssociationsForEntity: entity in: Set new ]
]

{ #category : #accessing }
FQIncomingNavigation class >> availableAssociationsForEntity: anEntity in: aSet [
	aSet addAll: anEntity incomingMSEProperties.
	anEntity children
		do: [ :child | self availableAssociationsForEntity: child in: aSet ].
	^ aSet
]

{ #category : #printing }
FQIncomingNavigation class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayIncomingOn: aStream
]

{ #category : #'as yet unclassified' }
FQIncomingNavigation class >> label [
	^ 'Incoming'
]

{ #category : #action }
FQIncomingNavigation class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryIncomingWith: anEntity
]
