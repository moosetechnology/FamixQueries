Class {
	#name : #FQIncomingNavigationQueryStrategy,
	#superclass : #FQAbstractDirectionNavigationQueryStrategy,
	#category : #'Famix-Queries-Utils'
}

{ #category : #printing }
FQIncomingNavigationQueryStrategy class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayIncomingOn: aStream
]

{ #category : #accessing }
FQIncomingNavigationQueryStrategy class >> label [
	^ 'Incoming'
]

{ #category : #action }
FQIncomingNavigationQueryStrategy class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryIncomingWith: anEntity
]
