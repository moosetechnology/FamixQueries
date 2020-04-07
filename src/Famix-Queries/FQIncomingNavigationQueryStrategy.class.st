Class {
	#name : #FQIncomingNavigationQueryStrategy,
	#superclass : #FQAbstractDirectionNavigationQueryStrategy,
	#category : #'Famix-Queries-Utils'
}

{ #category : #accessing }
FQIncomingNavigationQueryStrategy class >> availableAssociationsFor: aMooseGroup [
	^ aMooseGroup entities
		flatCollectAsSet: [ :entity | self availableAssociationsForEntity: entity in: Set new ]
]

{ #category : #accessing }
FQIncomingNavigationQueryStrategy class >> availableAssociationsForEntity: anEntity in: aSet [
	aSet addAll: anEntity incomingMSEProperties.
	anEntity children
		do: [ :child | self availableAssociationsForEntity: child in: aSet ].
	^ aSet
]

{ #category : #printing }
FQIncomingNavigationQueryStrategy class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayIncomingOn: aStream
]

{ #category : #action }
FQIncomingNavigationQueryStrategy class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryIncomingWith: anEntity
]
