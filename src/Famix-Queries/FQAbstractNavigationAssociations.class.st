"
I am an association strategy used by FQNavigationQuery.

I am responsible for a call to MooseQuery to navigate associations.

I query the opposite of the input entities for the associations I know, using MooseQuery.
This is done by one of my #query***With: methods when it is called by a subclass of FQAbstractNavigationDirection.

To see reaction to adding/removing associations API, see my subclasses.
"
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

{ #category : #'adding - removing' }
FQAbstractNavigationAssociations >> addAssociation: anAssociation [
	self subclassResponsibility
]

{ #category : #accessing }
FQAbstractNavigationAssociations >> associations [
	^ self subclassResponsibility
]

{ #category : #printing }
FQAbstractNavigationAssociations >> displayIncomingOn: aStream [
	self subclassResponsibility
]

{ #category : #printing }
FQAbstractNavigationAssociations >> displayLocalIncomingOn: aStream [
	self subclassResponsibility
]

{ #category : #printing }
FQAbstractNavigationAssociations >> displayLocalOutgoingOn: aStream [
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

{ #category : #'adding - removing' }
FQAbstractNavigationAssociations >> removeAssociation: arg1 [ 
	^ self subclassResponsibility
]
