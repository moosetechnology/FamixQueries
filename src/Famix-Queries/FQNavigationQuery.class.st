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

{ #category : #accessing }
FQNavigationQuery class >> label [
	^ 'Navigation Query'
]

{ #category : #printing }
FQNavigationQuery class >> simpleNameOf: anAssociation [
	^ anAssociation name withoutPrefix: self traitPrefix
]

{ #category : #printing }
FQNavigationQuery class >> stringForAssociation: anAssociation [
	^ (self simpleNameOf: anAssociation) asLowercase asEnglishPlural
]

{ #category : #printing }
FQNavigationQuery class >> symbolForAssociation: anAssociation [
	^ (self simpleNameOf: anAssociation) asSymbol
]

{ #category : #printing }
FQNavigationQuery class >> traitPrefix [
	^ 'FamixT'
]

{ #category : #'adding - removing' }
FQNavigationQuery >> addAssociation: anAssociation [
	associationStrategy := self associationStrategy
		addAssociation: anAssociation.
	self resetResult.
	self flag: #FQTest , 'test reset result'
]

{ #category : #'available parameters' }
FQNavigationQuery >> allPossibleAssociations [
	^ FQAbstractNavigationAssociations
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
FQNavigationQuery >> availableAssociations [
	self flag: #FQTest.
	^ directionStrategy
		ifNil: [ #() ]
		ifNotNil: [ self availableAssociationsFor: parent result ]
]

{ #category : #'available parameters' }
FQNavigationQuery >> availableAssociationsFor: aMooseGroup [
	^ ((self directionStrategy
		availableAssociationsFor: (aMooseGroup allUsing: TEntityMetaLevelDependency))
		collect: #implementingType) asOrderedCollection
]

{ #category : #'available parameters' }
FQNavigationQuery >> availableDirections [
	^ FQAbstractNavigationDirection availableDirections
]

{ #category : #default }
FQNavigationQuery >> beDefaultForParent [
	self
		flag:
			#FQImprove , #FQTest
				, 'This is a bit of a hack to allow creation of invalid queries'.
	directionStrategy := self availableDirections first.
	associationStrategy := [ FQNavigationAssociations
		withAll: self availableAssociations ]
		on: FQCannotRemoveLastNavigationAssociation
		do: [ FQNavigationAssociations new ]
]

{ #category : #printing }
FQNavigationQuery >> defaultName [
	^ String
		streamContents: [ :s | 
			s << self directionStrategy label << Character space.
			self associationStrategy associations
				allButLastDo: [ :assoc | s << (self class stringForAssociation: assoc) << ', ' ].
			s
				<<
					(self class
						stringForAssociation: self associationStrategy associations last) ]
]

{ #category : #accessing }
FQNavigationQuery >> direction: aSymbol [
	self
		directionStrategy:
			(self availableDirections
				detect: [ :dir | dir label asCamelCase = aSymbol asString ])
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
		and: [ associationStrategy associations
				= aQuery associationStrategy associations ]
]

{ #category : #initialization }
FQNavigationQuery >> initialize [
	super initialize.
	associationStrategy := FQNavigationAssociations new
]

{ #category : #testing }
FQNavigationQuery >> isValid [
	^ self directionStrategy isClass
		and: [ (self directionStrategy
				inheritsFrom: FQAbstractNavigationDirection)
				and: [ (self associationStrategy
						isKindOf: FQAbstractNavigationAssociations)
						and: [ self associationStrategy associations isNotEmpty ] ] ]
]

{ #category : #'adding - removing' }
FQNavigationQuery >> removeAssociation: anAssociation [
	self
		associationStrategy: (self associationStrategy removeAssociation: anAssociation).
	self resetResult.
	self flag: #FQTest , 'test reset result'
]

{ #category : #reset }
FQNavigationQuery >> reset [
	self resetResult.
	self resetDirection.
	self resetAssociation
]

{ #category : #reset }
FQNavigationQuery >> resetAndChangeDirection: aDirectionStrategy [
	self reset.
	directionStrategy := aDirectionStrategy.
	self availableAssociations
		ifNotEmpty: [ :associations | 
			self
				associationStrategy: (FQNavigationAssociations withAll: associations) ].
	self flag: #FQTest
]

{ #category : #reset }
FQNavigationQuery >> resetAssociation [
	associationStrategy := nil
]

{ #category : #reset }
FQNavigationQuery >> resetDirection [
	directionStrategy := nil
]

{ #category : #running }
FQNavigationQuery >> runOn: aMooseGroup [
	self
		flag:
			#FQImprove
				, 'Selection of allUsing: so not all entities will respond.'.
	^ ((aMooseGroup allUsing: TDependencyQueries)
		inject: Set new
		into: [ :res :entity | 
			res
				addAll: (self directionStrategy query: entity with: self associationStrategy).
			res ]) asMooseGroup
]

{ #category : #printing }
FQNavigationQuery >> storeOn: aStream [
	aStream << self className << ' new direction: #'
		<< self directionStrategy label asCamelCase << '; '.
	self associationStrategy associations
		allButLastDo: [ :assoc | 
			aStream << 'association: '.
			(self class symbolForAssociation: assoc) storeOn: aStream.
			aStream << $; ].
	aStream << 'association: '.
	(self class
		symbolForAssociation: self associationStrategy associations last)
		storeOn: aStream
]
