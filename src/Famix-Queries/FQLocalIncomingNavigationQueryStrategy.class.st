Class {
	#name : #FQLocalIncomingNavigationQueryStrategy,
	#superclass : #FQAbstractDirectionNavigationQueryStrategy,
	#category : #'Famix-Queries-Utils'
}

{ #category : #action }
FQLocalIncomingNavigationQueryStrategy class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayLocalIncomingOn: aStream
]

{ #category : #action }
FQLocalIncomingNavigationQueryStrategy class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryLocalIncomingWith: anEntity
]
