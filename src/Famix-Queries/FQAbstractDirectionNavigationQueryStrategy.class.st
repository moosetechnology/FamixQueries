Class {
	#name : #FQAbstractDirectionNavigationQueryStrategy,
	#superclass : #Object,
	#category : #'Famix-Queries-Utils'
}

{ #category : #printing }
FQAbstractDirectionNavigationQueryStrategy class >> displayOn: aStream with: anAssociationStrategy [
	self subclassResponsibility
]

{ #category : #action }
FQAbstractDirectionNavigationQueryStrategy class >> query: anEntity with: anAssociationStrategy [
	^ self subclassResponsibility
]
