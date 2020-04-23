Class {
	#name : #FQOutgoingNavigation,
	#superclass : #FQAbstractNavigationDirection,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #accessing }
FQOutgoingNavigation class >> availableAssociationsFor: aMooseGroup [
	^ aMooseGroup entities
		flatCollectAsSet: [ :entity | self availableAssociationsForEntity: entity in: Set new ]
]

{ #category : #accessing }
FQOutgoingNavigation class >> availableAssociationsForEntity: anEntity in: aSet [
	aSet addAll: anEntity outgoingMSEProperties.
	anEntity children
		do: [ :child | self availableAssociationsForEntity: child in: aSet ].
	^ aSet
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
