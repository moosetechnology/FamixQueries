Class {
	#name : #FQAllNavigationAssociations,
	#superclass : #FQAbstractNavigationAssociations,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #'adding - removing' }
FQAllNavigationAssociations >> addAssociation: anAssociation [
	^ self
]

{ #category : #accessing }
FQAllNavigationAssociations >> associations [
	^ self class allPossibleAssociations
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

{ #category : #'adding - removing' }
FQAllNavigationAssociations >> removeAssociation: anAssociation [
	^ FQNavigationAssociations
		withAll: (self class allPossibleAssociations copyWithout: anAssociation)
]
