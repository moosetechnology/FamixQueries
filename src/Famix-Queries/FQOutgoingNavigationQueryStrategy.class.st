Class {
	#name : #FQOutgoingNavigationQueryStrategy,
	#superclass : #FQAbstractDirectionNavigationQueryStrategy,
	#category : #'Famix-Queries-Utils'
}

{ #category : #printing }
FQOutgoingNavigationQueryStrategy class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayOutgoingOn: aStream
]

{ #category : #action }
FQOutgoingNavigationQueryStrategy class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryOutgoingWith: anEntity
]
