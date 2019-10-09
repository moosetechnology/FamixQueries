Class {
	#name : #FQAbstractAssociationNavigationQueryStrategy,
	#superclass : #Object,
	#category : #'Famix-Queries-Utils'
}

{ #category : #printing }
FQAbstractAssociationNavigationQueryStrategy >> displayIncomingOn: aStream [
	self subclassResponsibility
]

{ #category : #printing }
FQAbstractAssociationNavigationQueryStrategy >> displayOutgoingOn: aStream [
	self subclassResponsibility
]

{ #category : #action }
FQAbstractAssociationNavigationQueryStrategy >> queryIncomingWith: anEntity [
	^ self subclassResponsibility
]

{ #category : #action }
FQAbstractAssociationNavigationQueryStrategy >> queryLocalIncomingWith: anEntity [
	^ self subclassResponsibility
]

{ #category : #action }
FQAbstractAssociationNavigationQueryStrategy >> queryLocalOutgoingWith: anEntity [
	^ self subclassResponsibility
]

{ #category : #action }
FQAbstractAssociationNavigationQueryStrategy >> queryOutgoingWith: anEntity [
	^ self subclassResponsibility
]
