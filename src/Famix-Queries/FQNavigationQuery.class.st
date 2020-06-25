"
I am a query that can be applied on a MooseGroup.

----- Query -----
I navigate from entities following moose associations (Access, Invocation, Inheritance, Reference and Tait usage).
I use MooseQuery to get the associations and return their opposite.
My result will be entities of this class that are related to the entities of the input MooseGroup following the chosen associations.

----- Parameters -----
I have a direction strategy: Incoming or outgoing, Local or not (recursive).
	See FQAbstractNavigationDirection subclasses.
I have an association strategy, responsible for the call to MooseQuery.
	FQNavigationAssociations queries 1 or several specified associations.
	FQAllNavigationAssociations queries all associations.

----- API -----
- Running : see FQAbstractQuery comment
- Printing : see FQAbstractQuery comment
- Changing direction: 
	Use #directionStrategy: with a subclass of FQAbstractNavigationDirection as argument.
	Use #direction: with a symbol (#Incoming, #Outgoing, #LocalIncoming or #LocalOutgoing) as argument.
- Changing association strategy:
	Use #associationStrategy: with a subclass of FQAbstractNavigationAssociations as argument.
- Adding - removing associations:
	Use #association: with a Symbol (#Access, #Inheritance, #Invocation, #Reference or #TraitUsage) as argument
	Use #addAssociation: and #removeAssociation with an association trait 
		(one of 'FQAbstractNavigationAssociations allPossibleAssociations') as argument.
		See FQAbstractNavigationAssociations subclasses comment for more details.
- Comparing:
	Two type queries are equal if their direction are the same and if their association strategies hold the same associations.
- Available parameters:
	- Available directions are input-independant: see FQAbstractNavigationDirection>>availableDirections
	- Available associations depend on the input MooseGroup and the direction.

----- Validity -----
I am valid if I have a direction (a subclass of FQAbstractNavigationDirection)
	and an association strategy (a subclass of FQAbstractNavigationAssociations) 
	with at least one association to query.

----- Instance Creation -----
- Class method #direction:association: takes a FQAbstractNavigationDirection suclass 
	and a FQAbstractNavigationAssociations instance as argument.
- Simplified creation API:
		'FQNavigationQuery new
			direction: #Incoming ""or another direction"";
			association: anAssociation;
			association: anotherAssociation'
"
Class {
	#name : #FQNavigationQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'directionStrategy',
		'associationStrategy'
	],
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #'available parameters' }
FQNavigationQuery class >> directionStrategies [
	^ FQAbstractNavigationDirection allSubclasses
]

{ #category : #'instance creation' }
FQNavigationQuery class >> incoming [
	^ self new
		directionStrategy: FQIncomingNavigation;
		yourself
]

{ #category : #accessing }
FQNavigationQuery class >> label [
	^ 'Navigation Query'
]

{ #category : #'instance creation' }
FQNavigationQuery class >> localIncoming [
	^ self new
		directionStrategy: FQLocalIncomingNavigation;
		yourself
]

{ #category : #'instance creation' }
FQNavigationQuery class >> localOutgoing [
	^ self new
		directionStrategy: FQLocalOutgoingNavigation;
		yourself
]

{ #category : #'instance creation' }
FQNavigationQuery class >> outgoing [
	^ self new
		directionStrategy: FQOutgoingNavigation;
		yourself
]

{ #category : #'adding - removing' }
FQNavigationQuery >> addAssociation: anAssociation [
	(self associationsIsValid: anAssociation)
		ifFalse: [ ^ self ].
	self associationStrategy addAssociation: anAssociation.
	(self associations sameElements: self availableAssociations)
		ifTrue: [ self associationStrategy: FQAllNavigationAssociations new ].
	self resetResult.
	self flag: #FQTest , 'test reset result'
]

{ #category : #accessing }
FQNavigationQuery >> allAssociations [
	self associationStrategy: FQAllNavigationAssociations new
]

{ #category : #accessing }
FQNavigationQuery >> association: anAssociation [
	(self associationsIsValid: anAssociation)
		ifFalse: [ ^ self allAssociations ].
	self
		associationStrategy: (FQNavigationAssociations with: anAssociation)
]

{ #category : #accessing }
FQNavigationQuery >> associationStrategy [
	^ associationStrategy
]

{ #category : #accessing }
FQNavigationQuery >> associationStrategy: anObject [
	associationStrategy := anObject
]

{ #category : #accessing }
FQNavigationQuery >> associations [
	^ self associationStrategy associationsFor: self
]

{ #category : #accessing }
FQNavigationQuery >> associations: aCollectionOfAssociations [
	aCollectionOfAssociations isCollection
		ifFalse: [ ^ self association: aCollectionOfAssociations ].
	(aCollectionOfAssociations
		allSatisfy: [ :assoc | self associationsIsValid: assoc ])
		ifFalse: [ ^ self allAssociations ].
	(aCollectionOfAssociations sameElements: self availableAssociations)
		ifTrue: [ self allAssociations ]
		ifFalse: [ self
				associationStrategy: (FQNavigationAssociations withAll: aCollectionOfAssociations) ]
]

{ #category : #testing }
FQNavigationQuery >> associationsIsValid: anAssociation [
	^ anAssociation isClass
		and: [ (anAssociation lookupSelector: #isAssociation) notNil ]
]

{ #category : #'available parameters' }
FQNavigationQuery >> availableAssociations [
	self flag: #FQTest.
	^ (directionStrategy isNotNil and: [ parent isNotNil ])
		ifFalse: [ #() ]
		ifTrue: [ self availableAssociationsFor: parent result ]
]

{ #category : #'available parameters' }
FQNavigationQuery >> availableAssociationsFor: aMooseGroup [
	^ (self directionStrategy availableAssociationsFor: (aMooseGroup allUsing: TEntityMetaLevelDependency)) asOrderedCollection
]

{ #category : #default }
FQNavigationQuery >> beDefaultForParent [
	self
		flag:
			#FQImprove , #FQTest
				, 'This is a bit of a hack to allow creation of invalid queries'.
	directionStrategy := self class directionStrategies first.
	associationStrategy := FQAllNavigationAssociations new
]

{ #category : #printing }
FQNavigationQuery >> defaultName [
	^ String
		streamContents: [ :s | 
			s << self directionStrategy label << Character space.
			self isValid
				ifTrue: [ s << self associationStrategy associationsNames ] ]
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

{ #category : #comparing }
FQNavigationQuery >> hasSameParametersAs: aQuery [
	^ directionStrategy == aQuery directionStrategy
		and: [ associationStrategy = aQuery associationStrategy ]
]

{ #category : #initialization }
FQNavigationQuery >> initialize [
	super initialize.
	associationStrategy := FQAllNavigationAssociations new
]

{ #category : #testing }
FQNavigationQuery >> isValid [
	^ self directionStrategy isClass
		and: [ (self directionStrategy inheritsFrom: FQAbstractNavigationDirection)
				and:
					[ (self associationStrategy isKindOf: FQAbstractNavigationAssociations)
						and: [ self associations isNotEmpty
								and: [ self associations
										allSatisfy: [ :assoc | self associationsIsValid: assoc ] ] ] ] ]
]

{ #category : #'adding - removing' }
FQNavigationQuery >> removeAssociation: anAssociation [
	self
		associationStrategy:
			(FQNavigationAssociations
				withAll: (self associations copyWithout: anAssociation)).
	self resetResult.
	self flag: #FQTest , 'test reset result'
]

{ #category : #reset }
FQNavigationQuery >> resetAndChangeDirection: aDirectionStrategy [
	self resetResult.
	directionStrategy := aDirectionStrategy.
	self associationStrategy: FQAllNavigationAssociations new.
	self flag: #FQTest
]

{ #category : #running }
FQNavigationQuery >> runOn: aMooseGroup [
	self
		flag:
			#FQImprove
				, 'Selection of allUsing: so not all entities will respond.'.
	^ ((aMooseGroup allUsing: TEntityMetaLevelDependency)
		inject: Set new
		into: [ :res :entity | 
			res
				addAll: (self directionStrategy query: entity with: self associationStrategy).
			res ]) asMooseGroup
]

{ #category : #printing }
FQNavigationQuery >> storeOn: aStream [
	aStream << self className << ' '
		<< self directionStrategy label asCamelCase uncapitalized.
	self isValid
		ifTrue: [ self associationStrategy storeOn: aStream ]
]
