Class {
	#name : #FQNavigationQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'association',
		'direction'
	],
	#category : #'Famix-Queries-Terminal'
}

{ #category : #'instance creation' }
FQNavigationQuery class >> direction: aDirectionStrategyClass association: anAssociationStrategy [
	^ self new
		direction: aDirectionStrategyClass;
		association: anAssociationStrategy;
		yourself
]

{ #category : #'adding - removing' }
FQNavigationQuery >> addAssociation: anAssociation [
	self association addAssociation: anAssociation
]

{ #category : #accessing }
FQNavigationQuery >> allPossibleAssociations [
	^ FQAbstractAssociationNavigationQueryStrategy
		allPossibleAssociations
]

{ #category : #accessing }
FQNavigationQuery >> association [
	^ association
]

{ #category : #accessing }
FQNavigationQuery >> association: anObject [
	association := anObject
]

{ #category : #accessing }
FQNavigationQuery >> availableAssociationsFor: aMooseGroup [
	^ ((self direction
		availableAssociationsFor: (aMooseGroup allUsing: TEntityMetaLevelDependency))
		collect: #implementingType) asOrderedCollection
]

{ #category : #accessing }
FQNavigationQuery >> availableDirections [
	^ FQAbstractDirectionNavigationQueryStrategy availableDirections
]

{ #category : #accessing }
FQNavigationQuery >> direction [
	^ direction
]

{ #category : #accessing }
FQNavigationQuery >> direction: anObject [
	direction := anObject
]

{ #category : #running }
FQNavigationQuery >> displayOn: aStream with: aString [
	aStream << '(' << aString
		<<
			'
		inject: Set new
		into: [ :result :entity | 
			result addAll: '.
	self direction displayOn: aStream with: self association.
	aStream
		<<
			'.
			result ]) asMooseGroup'
]

{ #category : #'adding - removing' }
FQNavigationQuery >> removeAssociation: anAssociation [
	self association removeAssociation: anAssociation
]

{ #category : #running }
FQNavigationQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ (aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: (self direction query: entity with: self association).
			result ]) asMooseGroup
]
