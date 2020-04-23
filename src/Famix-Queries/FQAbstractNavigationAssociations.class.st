Class {
	#name : #FQAbstractNavigationAssociations,
	#superclass : #Object,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #accessing }
FQAbstractNavigationAssociations class >> allPossibleAssociations [
	^ (((FM3Property allInstances select: #hasOpposite)
		select: [ :p | p opposite isSource ])
		collectAsSet: #implementingType) asArray
		sorted: [ :assoc1 :assoc2 | assoc1 name < assoc2 name ]
]

{ #category : #printing }
FQAbstractNavigationAssociations >> displayIncomingOn: aStream [
	self subclassResponsibility
]

{ #category : #printing }
FQAbstractNavigationAssociations >> displayOutgoingOn: aStream [
	self subclassResponsibility
]

{ #category : #action }
FQAbstractNavigationAssociations >> queryIncomingWith: anEntity [
	^ self subclassResponsibility
]

{ #category : #action }
FQAbstractNavigationAssociations >> queryLocalIncomingWith: anEntity [
	^ self subclassResponsibility
]

{ #category : #action }
FQAbstractNavigationAssociations >> queryLocalOutgoingWith: anEntity [
	^ self subclassResponsibility
]

{ #category : #action }
FQAbstractNavigationAssociations >> queryOutgoingWith: anEntity [
	^ self subclassResponsibility
]
