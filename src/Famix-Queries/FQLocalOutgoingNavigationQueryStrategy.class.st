Class {
	#name : #FQLocalOutgoingNavigationQueryStrategy,
	#superclass : #FQAbstractDirectionNavigationQueryStrategy,
	#category : #'Famix-Queries-Utils'
}

{ #category : #printing }
FQLocalOutgoingNavigationQueryStrategy class >> displayOn: aStream with: anAssociationStrategy [
	anAssociationStrategy displayLocalOutgoingOn: aStream
]

{ #category : #accessing }
FQLocalOutgoingNavigationQueryStrategy class >> label [
	^ 'Local Outgoing'
]

{ #category : #action }
FQLocalOutgoingNavigationQueryStrategy class >> query: anEntity with: anAssociationStrategy [
	^ anAssociationStrategy queryLocalOutgoingWith: anEntity
]
