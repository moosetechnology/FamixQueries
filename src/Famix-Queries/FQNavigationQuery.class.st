Class {
	#name : #FQNavigationQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'association',
		'direction'
	],
	#category : #'Famix-Queries-Terminal'
}

{ #category : #'as yet unclassified' }
FQNavigationQuery class >> associationAsSymbol: anAssociation [
	^ (anAssociation name withoutPrefix: 'FamixT') asSymbol
]

{ #category : #'instance creation' }
FQNavigationQuery class >> direction: aDirectionStrategyClass association: anAssociationStrategy [
	^ self new
		directionStrategy: aDirectionStrategyClass;
		associationStrategy: anAssociationStrategy;
		yourself
]

{ #category : #comparing }
FQNavigationQuery >> = aQuery [
	^ self class == aQuery class
		and: [ direction == aQuery direction
				and: [ association associations = aQuery association associations ] ]
]

{ #category : #'adding - removing' }
FQNavigationQuery >> addAssociation: anAssociation [
	association := self association addAssociation: anAssociation
]

{ #category : #'available parameters' }
FQNavigationQuery >> allPossibleAssociations [
	^ FQAbstractAssociationNavigationQueryStrategy
		allPossibleAssociations
]

{ #category : #accessing }
FQNavigationQuery >> association [
	^ association
]

{ #category : #'adding - removing' }
FQNavigationQuery >> association: aSymbol [
	self
		addAssociation:
			(self allPossibleAssociations
				detect:
					[ :assoc | assoc name includesSubstring: aSymbol asString ])
]

{ #category : #accessing }
FQNavigationQuery >> associationStrategy: anObject [
	association := anObject
]

{ #category : #'available parameters' }
FQNavigationQuery >> availableAssociationsFor: aMooseGroup [
	^ ((self direction
		availableAssociationsFor: (aMooseGroup allUsing: TEntityMetaLevelDependency))
		collect: #implementingType) asOrderedCollection
]

{ #category : #'available parameters' }
FQNavigationQuery >> availableDirections [
	^ FQAbstractDirectionNavigationQueryStrategy availableDirections
]

{ #category : #accessing }
FQNavigationQuery >> direction [
	^ direction
]

{ #category : #accessing }
FQNavigationQuery >> direction: aSymbol [
	direction := self availableDirections
		detect: [ :dir | dir label asCamelCase = aSymbol asString ]
]

{ #category : #accessing }
FQNavigationQuery >> directionStrategy: anObject [
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

{ #category : #initialization }
FQNavigationQuery >> initialize [
	super initialize.
	association := FQAssociationNavigationQueryStrategy new
]

{ #category : #testing }
FQNavigationQuery >> isValid [
	^ (self direction
		inheritsFrom: FQAbstractDirectionNavigationQueryStrategy)
		and: [ (self association
				isKindOf: FQAbstractAssociationNavigationQueryStrategy)
				and: [ self association associations isNotEmpty ] ]
]

{ #category : #'adding - removing' }
FQNavigationQuery >> removeAssociation: anAssociation [
	self associationStrategy: (self association removeAssociation: anAssociation)
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

{ #category : #printing }
FQNavigationQuery >> storeOn: aStream [
	aStream << self simpleClassName << ' new direction: #'
		<< self direction label asCamelCase << '; '.
	self association associations
		allButLastDo: [ :assoc | 
			aStream << 'association: '.
			(self class associationAsSymbol: assoc) storeOn: aStream.
			aStream << $; ].
	aStream << 'association: '.
	(self class associationAsSymbol: self association associations last)
		storeOn: aStream
]
