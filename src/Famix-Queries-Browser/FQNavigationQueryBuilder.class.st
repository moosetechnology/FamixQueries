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
	query addAssociation: anAssociation
]

{ #category : #'available parameters' }
FQNavigationQueryBuilder >> allPossibleAssociations [
	^ query allPossibleAssociations
]

{ #category : #'available parameters' }
FQNavigationQueryBuilder >> availableAssociations [
	^ query availableAssociationsFor: entities
]

{ #category : #'available parameters' }
FQNavigationQueryBuilder >> availableDirections [
	^ query availableDirections
]

{ #category : #'changing parameters' }
FQNavigationQueryBuilder >> changeQueryNavigationDirection: aDirection [
	query directionStrategy: aDirection.
	self availableAssociations
		ifEmpty: [ ImpossibleQuery signal: 'No available associations' ].
	query
		associationStrategy:
			(FQAssociationNavigationQueryStrategy
				withAll: self availableAssociations)
]

{ #category : #accessing }
FQNavigationQueryBuilder >> currentQueryAssociations [
	^ query association associations
]

{ #category : #initialization }
FQNavigationQueryBuilder >> initializeQuery [
	super initializeQuery.
	query directionStrategy: self availableDirections first.
	self availableAssociations
		ifEmpty: [ (ImpossibleQuery new builder: self) signal ].
	query
		associationStrategy:
			(FQAssociationNavigationQueryStrategy
				withAll: self availableAssociations)
]

{ #category : #'changing parameters' }
FQNavigationQueryBuilder >> removeAssociationFromQuery: anAssociation [
	query removeAssociation: anAssociation
]
