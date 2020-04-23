Class {
	#name : #FQAbstractNavigationDirection,
	#superclass : #Object,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #accessing }
FQAbstractNavigationDirection class >> availableDirections [
	^ self allSubclasses
]

{ #category : #printing }
FQAbstractNavigationDirection class >> displayOn: aStream with: anAssociationStrategy [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
FQAbstractNavigationDirection class >> label [
	^ self subclassResponsibility
]

{ #category : #action }
FQAbstractNavigationDirection class >> query: anEntity with: anAssociationStrategy [
	^ self subclassResponsibility
]
