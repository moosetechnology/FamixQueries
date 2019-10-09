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
FQNavigationQuery class >> association: aFAMIXAssociation direction: aDirectionStrategy [
	^ self new
		association: aFAMIXAssociation;
		direction: aDirectionStrategy;
		yourself
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
FQNavigationQuery >> direction [
	^ direction
]

{ #category : #accessing }
FQNavigationQuery >> direction: anObject [
	direction := anObject
]

{ #category : #running }
FQNavigationQuery >> displayOn: aStream [
	aStream
		<<
			'(aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: '.
	self direction displayOn: aStream with: self association.
	aStream
		<<
			'.
			result ]) asMooseGroup'
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
