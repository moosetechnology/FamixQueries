Class {
	#name : #FQNavigationQueryBuilder,
	#superclass : #FQAbstractQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQNavigationQueryBuilder class >> queryClass [
	^ FQNavigationQuery
]

{ #category : #'changing parameters' }
FQNavigationQueryBuilder >> addAssociationToQuery: anAssociation [
	query addAssociation: anAssociation.
	self resetResult
]

{ #category : #'available parameters' }
FQNavigationQueryBuilder >> allPossibleAssociations [
	^ query allPossibleAssociations
]

{ #category : #'available parameters' }
FQNavigationQueryBuilder >> availableAssociations [
	^ query availableAssociationsFor: self entities
]

{ #category : #'available parameters' }
FQNavigationQueryBuilder >> availableDirections [
	^ query availableDirections
]

{ #category : #'changing parameters' }
FQNavigationQueryBuilder >> changeQueryNavigationDirection: aDirection [
	query directionStrategy: aDirection.
	self availableAssociations
		ifEmpty: [ FQImpossibleQuery signal: 'No available associations' ].
	query
		associationStrategy:
			(FQNavigationAssociations
				withAll: self availableAssociations).
	self resetResult
]

{ #category : #accessing }
FQNavigationQueryBuilder >> currentQueryAssociations [
	^ query associationStrategy associations
]

{ #category : #initialization }
FQNavigationQueryBuilder >> initializeQuery [
	super initializeQuery.
	query directionStrategy: self availableDirections first.
	self availableAssociations
		ifEmpty: [ (FQImpossibleQuery new builder: self) signal ].
	query
		associationStrategy:
			(FQNavigationAssociations
				withAll: self availableAssociations)
]

{ #category : #initialization }
FQNavigationQueryBuilder >> initializeQueryFromParent: aQuery [
	super initializeQueryFromParent: aQuery.
	query directionStrategy: self availableDirections first.
	self availableAssociations
		ifEmpty: [ (FQImpossibleQuery new builder: self) signal ].
	query
		associationStrategy:
			(FQNavigationAssociations
				withAll: self availableAssociations)
]

{ #category : #'changing parameters' }
FQNavigationQueryBuilder >> removeAssociationFromQuery: anAssociation [
	query removeAssociation: anAssociation.
	self resetResult
]
