Class {
	#name : #FQNavigationQueryBuilder,
	#superclass : #FQAbstractQueryBuilder,
	#instVars : [
		'navigationAssociations'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #'changing parameters' }
FQNavigationQueryBuilder >> addAssociation: anAssociation [
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
FQNavigationQueryBuilder >> changeQueryAssociation [
	(navigationAssociations includesAll: self availableAssociations)
		ifTrue: [ query association: FQAllAssociationsNavigationQueryStrategy new ]
		ifFalse: [ query
				association: (FQAssociationNavigationQueryStrategy withAll: navigationAssociations) ]
]

{ #category : #'changing parameters' }
FQNavigationQueryBuilder >> changeQueryNavigationDirection: aDirection [
	query direction: aDirection
]

{ #category : #initialization }
FQNavigationQueryBuilder >> initialize [
	super initialize.
	navigationAssociations := Set new
]

{ #category : #accessing }
FQNavigationQueryBuilder >> queryClass [
	^ FQNavigationQuery
]

{ #category : #'changing parameters' }
FQNavigationQueryBuilder >> removeAssociation: anAssociation [
	query removeAssociation: anAssociation
]
