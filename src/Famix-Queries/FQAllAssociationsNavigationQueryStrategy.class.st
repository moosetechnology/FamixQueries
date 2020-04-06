Class {
	#name : #FQAllAssociationsNavigationQueryStrategy,
	#superclass : #FQAbstractAssociationNavigationQueryStrategy,
	#category : #'Famix-Queries-Utils'
}

{ #category : #printing }
FQAllAssociationsNavigationQueryStrategy >> displayIncomingOn: aStream [
	aStream << 'entity queryAllIncoming opposites'
]

{ #category : #printing }
FQAllAssociationsNavigationQueryStrategy >> displayLocalIncomingOn: aStream [
	aStream << 'entity queryAllLocalIncoming opposites'
]

{ #category : #printing }
FQAllAssociationsNavigationQueryStrategy >> displayLocalOutgoingOn: aStream [
	aStream << 'entity queryAllLocalOutgoing opposites'
]

{ #category : #printing }
FQAllAssociationsNavigationQueryStrategy >> displayOutgoingOn: aStream [
	aStream << 'entity queryAllOutgoing opposites'
]

{ #category : #action }
FQAllAssociationsNavigationQueryStrategy >> queryIncomingWith: anEntity [
	^ anEntity queryAllIncoming opposites
]

{ #category : #action }
FQAllAssociationsNavigationQueryStrategy >> queryLocalIncomingWith: anEntity [
	^ anEntity queryAllLocalIncoming  opposites
]

{ #category : #action }
FQAllAssociationsNavigationQueryStrategy >> queryLocalOutgoingWith: anEntity [
	^ anEntity queryAllLocalOutgoing opposites
]

{ #category : #action }
FQAllAssociationsNavigationQueryStrategy >> queryOutgoingWith: anEntity [
	^ anEntity queryAllOutgoing opposites
]
