Class {
	#name : #FQOutgoingNavigationQueryStrategy,
	#superclass : #FQAbstractDirectionNavigationQueryStrategy,
	#category : #'Famix-Queries-Utils'
}

{ #category : #accessing }
FQOutgoingNavigationQueryStrategy class >> availableAssociationsFor: aMooseGroup [
	^ aMooseGroup entities
		flatCollectAsSet: [ :entity | self availableAssociationsForEntity: entity in: Set new ]
]

{ #category : #accessing }
FQOutgoingNavigationQueryStrategy class >> availableAssociationsForEntity: anEntity in: aSet [
	aSet addAll: anEntity outgoingMSEProperties.
	anEntity children
		do: [ :child | self availableAssociationsForEntity: child in: aSet ].
	^ aSet
]

{ #category : #printing }
FQOutgoingNavigationQueryStrategy class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayOutgoingOn: aStream
]

{ #category : #action }
FQOutgoingNavigationQueryStrategy class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryOutgoingWith: anEntity
]
