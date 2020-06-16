"
I am an association strategy used by FQNavigationQuery.

I am responsible for a call to MooseQuery to navigate associations.

I query the opposite of the input entities for all associations types, using MooseQuery.
This is done by one of my #query***With: methods when it is called by a subclass of FQAbstractNavigationDirection.

I know the API for adding and removing associations.
	- Adding an association will do nothing (since I collect ALL associations anyway)
	- Removing an association will return an FQNavigationAssociations with all association but the removed one, instead of self.
"
Class {
	#name : #FQAllNavigationAssociations,
	#superclass : #FQAbstractNavigationAssociations,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #comparing }
FQAllNavigationAssociations >> = anAssociationStrategy [
	^ anAssociationStrategy class = self class
]

{ #category : #'adding - removing' }
FQAllNavigationAssociations >> addAssociation: anAssociation [
	^ self
]

{ #category : #accessing }
FQAllNavigationAssociations >> associationsFor: aQuery [
	^ aQuery availableAssociations
]

{ #category : #accessing }
FQAllNavigationAssociations >> associationsNames [
	^ 'associations'
]

{ #category : #printing }
FQAllNavigationAssociations >> displayIncomingOn: aStream [
	aStream << 'entity queryAllIncoming opposites'
]

{ #category : #printing }
FQAllNavigationAssociations >> displayLocalIncomingOn: aStream [
	aStream << 'entity queryAllLocalIncoming opposites'
]

{ #category : #printing }
FQAllNavigationAssociations >> displayLocalOutgoingOn: aStream [
	aStream << 'entity queryAllLocalOutgoing opposites'
]

{ #category : #printing }
FQAllNavigationAssociations >> displayOutgoingOn: aStream [
	aStream << 'entity queryAllOutgoing opposites'
]

{ #category : #action }
FQAllNavigationAssociations >> queryIncomingWith: anEntity [
	^ anEntity queryAllIncoming opposites
]

{ #category : #action }
FQAllNavigationAssociations >> queryLocalIncomingWith: anEntity [
	^ anEntity queryAllLocalIncoming  opposites
]

{ #category : #action }
FQAllNavigationAssociations >> queryLocalOutgoingWith: anEntity [
	^ anEntity queryAllLocalOutgoing opposites
]

{ #category : #action }
FQAllNavigationAssociations >> queryOutgoingWith: anEntity [
	^ anEntity queryAllOutgoing opposites
]

{ #category : #printing }
FQAllNavigationAssociations >> storeOn: aStream [
	aStream << ' allAssociations'
]
