Class {
	#name : #FQAbstractDirectionNavigationQueryStrategy,
	#superclass : #Object,
	#category : #'Famix-Queries-Utils'
}

{ #category : #accessing }
FQAbstractDirectionNavigationQueryStrategy class >> availableDirections [
	^ self allSubclasses
]

{ #category : #printing }
FQAbstractDirectionNavigationQueryStrategy class >> displayOn: aStream with: anAssociationStrategy [
	self subclassResponsibility
]

{ #category : #accessing }
FQAbstractDirectionNavigationQueryStrategy class >> label [
	^ self subclassResponsibility
]

{ #category : #action }
FQAbstractDirectionNavigationQueryStrategy class >> query: anEntity with: anAssociationStrategy [
	^ self subclassResponsibility
]
