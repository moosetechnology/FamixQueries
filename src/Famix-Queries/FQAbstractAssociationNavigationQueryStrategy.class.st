Class {
	#name : #FQAbstractAssociationNavigationQueryStrategy,
	#superclass : #Object,
	#category : #'Famix-Queries-Utils'
}

{ #category : #accessing }
FQAbstractAssociationNavigationQueryStrategy class >> allPossibleAssociations [
	^ (((FM3Property allInstances select: #hasOpposite)
		select: [ :p | p opposite isSource ])
		collectAsSet: #implementingType) asArray
		sorted: [ :assoc1 :assoc2 | assoc1 name < assoc2 name ]
]

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
