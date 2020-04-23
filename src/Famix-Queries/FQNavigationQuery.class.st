"
I am a query that can be applied on a MooseGroup.

----- Query -----
I navigate from entities following moose associations (Access, Invocation, Inheritance, Reference and Tait usage).
I use MooseQuery to get the associations and return their opposite.
My result will be entities of this class that are related to the entities of the input MooseGroup following the chosen associations.

----- Parameters -----
I have a direction strategy: Incoming or outgoing, Local or not (recursive).
	See FQAbstractDirectionNavigationQueryStrategy subclasses.
I have an association strategy, responsible for the call to MooseQuery.
	FQAssociationNavigationQueryStrategy queries 1 or several specified associations.
	FQAllAssociationsNavigationQueryStrategy queries all associations.

----- API -----
- Running : see FQAbstractQuery comment
- Printing : see FQAbstractQuery comment
- Changing direction: 
	Use #directionStrategy: with a subclass of FQAbstractScopeDirection as argument.
	Use #direction: with a symbol (#Up #Down or #UpAndDown) as argument.
- Changing associations:
	Use #associationStrategy: with a subclass of FQAbstractDirectionNavigationQueryStrategy as argument.
	Use #association: with a symbol (#Incoming, #Outgoing, #LocalIncoming, #LocalOutgoing) as argument
- Comparing:
	Two type queries are equal if their direction are the same and if their association strategies hold the same associations.
- Available parameters:
	- Available directions are input-independant: see FQAbstractDirectionNavigationQueryStrategy>>availableDirections
	- Available associations depend on the input MooseGroup and the direction.

----- Validity -----
I am valid if I have a direction (a subclass of FQAbstractDirectionNavigationQueryStrategy)
	and an association strategy (a subclass of FQAbstractAssociationNavigationQueryStrategy) 
	with at least one association to query.

----- Instance Creation -----
- Class method #direction:association: takes a FQAbstractDirectionNavigationQueryStrategy suclass 
	and a FQAbstractAssociationNavigationQueryStrategy instance as argument.
- Simplified creation API:
		'FQNavigationQuery new
			direction: #Incoming ""or another direction"";
			association: anAssociation;
			association: anotherAssociation'
"
Class {
	#name : #FQNavigationQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'directionStrategy',
		'associationStrategy'
	],
	#category : #'Famix-Queries-Terminal'
}

{ #category : #utils }
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
		and: [ directionStrategy == aQuery directionStrategy
				and: [ associationStrategy associations = aQuery associationStrategy associations ] ]
]

{ #category : #'adding - removing' }
FQNavigationQuery >> addAssociation: anAssociation [
	associationStrategy := self associationStrategy addAssociation: anAssociation
]

{ #category : #'available parameters' }
FQNavigationQuery >> allPossibleAssociations [
	^ FQAbstractAssociationNavigationQueryStrategy
		allPossibleAssociations
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
FQNavigationQuery >> associationStrategy [
	^ associationStrategy
]

{ #category : #accessing }
FQNavigationQuery >> associationStrategy: anObject [
	associationStrategy := anObject
]

{ #category : #'available parameters' }
FQNavigationQuery >> availableAssociationsFor: aMooseGroup [
	^ ((self directionStrategy
		availableAssociationsFor: (aMooseGroup allUsing: TEntityMetaLevelDependency))
		collect: #implementingType) asOrderedCollection
]

{ #category : #'available parameters' }
FQNavigationQuery >> availableDirections [
	^ FQAbstractDirectionNavigationQueryStrategy availableDirections
]

{ #category : #accessing }
FQNavigationQuery >> direction: aSymbol [
	directionStrategy := self availableDirections
		detect: [ :dir | dir label asCamelCase = aSymbol asString ]
]

{ #category : #accessing }
FQNavigationQuery >> directionStrategy [
	^ directionStrategy
]

{ #category : #accessing }
FQNavigationQuery >> directionStrategy: anObject [
	directionStrategy := anObject
]

{ #category : #printing }
FQNavigationQuery >> displayOn: aStream with: aString [
	aStream << '(' << aString
		<<
			'
		inject: Set new
		into: [ :result :entity | 
			result addAll: '.
	self directionStrategy displayOn: aStream with: self associationStrategy.
	aStream
		<<
			'.
			result ]) asMooseGroup'
]

{ #category : #initialization }
FQNavigationQuery >> initialize [
	super initialize.
	associationStrategy := FQAssociationNavigationQueryStrategy new
]

{ #category : #testing }
FQNavigationQuery >> isValid [
	^ self directionStrategy isClass
		and: [ (self directionStrategy
				inheritsFrom: FQAbstractDirectionNavigationQueryStrategy)
				and: [ (self associationStrategy
						isKindOf: FQAbstractAssociationNavigationQueryStrategy)
						and: [ self associationStrategy associations isNotEmpty ] ] ]
]

{ #category : #'adding - removing' }
FQNavigationQuery >> removeAssociation: anAssociation [
	self associationStrategy: (self associationStrategy removeAssociation: anAssociation)
]

{ #category : #running }
FQNavigationQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ (aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: (self directionStrategy query: entity with: self associationStrategy).
			result ]) asMooseGroup
]

{ #category : #printing }
FQNavigationQuery >> storeOn: aStream [
	aStream << self simpleClassName << ' new direction: #'
		<< self directionStrategy label asCamelCase << '; '.
	self associationStrategy associations
		allButLastDo: [ :assoc | 
			aStream << 'association: '.
			(self class associationAsSymbol: assoc) storeOn: aStream.
			aStream << $; ].
	aStream << 'association: '.
	(self class associationAsSymbol: self associationStrategy associations last)
		storeOn: aStream
]
