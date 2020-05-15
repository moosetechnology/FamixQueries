Class {
	#name : #FQNavigationQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #helpers }
FQNavigationQueryTest >> actualClass [
	^ FQNavigationQuery
]

{ #category : #'tests - adding - removing' }
FQNavigationQueryTest >> testAddAllAssociations [
	query := self actualClass new
		directionStrategy: FQIncomingNavigation;
		associationStrategy: FQNavigationAssociations new.
	query allPossibleAssociations
		do: [ :assoc | query addAssociation: assoc ].
	self
		assert: query associationStrategy class
		identicalTo: FQAllNavigationAssociations
]

{ #category : #'tests - adding - removing' }
FQNavigationQueryTest >> testAddAssociation [
	query := self actualClass new
		directionStrategy: FQIncomingNavigation;
		associationStrategy: FQNavigationAssociations new.
	
	query addAssociation: FamixStAccess.
	self assert: (query associationStrategy associations includes: FamixStAccess).
	
	query addAssociation: FamixStAccess.
	self
		assert: (query associationStrategy associations occurrencesOf: FamixStAccess)
		equals: 1
]

{ #category : #'tests - available parameters' }
FQNavigationQueryTest >> testAvailableAssociationsFor [
	| availableAssociations |
	query := self actualClass new
		directionStrategy: FQIncomingNavigation.
	availableAssociations := query availableAssociationsFor: model.
	self
		assertCollection: FamixTAssociation users
		includesAll: availableAssociations
]

{ #category : #'tests - available parameters' }
FQNavigationQueryTest >> testAvailableDirections [
	query := self actualClass new.
	self
		assertCollection: query availableDirections
		includesAll: FQAbstractNavigationDirection availableDirections
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testDisplayIncomingInvocation [
	query := FQNavigationQuery
		direction: FQIncomingNavigation
		association: (FQNavigationAssociations with: FamixStInvocation).
	self
		assert: (String streamContents: [ :aStream | query displayOn: aStream ])
		equals:
			'(aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: (entity queryIncoming: FamixStInvocation) opposites.
			result ]) asMooseGroup'
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testDisplayIncomingInvocation2 [
	query := FQNavigationQuery
		direction: FQIncomingNavigation
		association:
			(FQNavigationAssociations
				withAll:
					{FamixStInvocation.
					FamixStInheritance}).
	self
		assert: (String streamContents: [ :aStream | query displayOn: aStream ])
		equals:
			'(aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: ({ FamixStInvocation . FamixStInheritance } flatCollect: [ :association | (entity queryIncoming: association) opposites ]).
			result ]) asMooseGroup'
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testDisplayOn [
	query := FQNavigationQuery
		direction: FQOutgoingNavigation
		association: FQAllNavigationAssociations new.
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			'(aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: entity queryAllOutgoing opposites.
			result ]) asMooseGroup'
]

{ #category : #tests }
FQNavigationQueryTest >> testEquals [
	query := FQNavigationQuery
		direction: FQOutgoingNavigation
		association: FQAllNavigationAssociations new.

	"Same query"
	self
		assert: query
		equals:
			(FQNavigationQuery
				direction: FQOutgoingNavigation
				association: FQAllNavigationAssociations new).

	"Different direction"
	self
		deny: query
		equals:
			(FQNavigationQuery
				direction: FQIncomingNavigation
				association: FQAllNavigationAssociations new).

	"Different association"
	self
		deny: query
		equals:
			(FQNavigationQuery
				direction: FQOutgoingNavigation
				association: (FQNavigationAssociations with: FamixStInvocation)).

	"Different class of query"
	self deny: query equals: (FQBooleanQuery forProperty: #isAbstract)
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testIncomingInvocation [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANPacket.contents()').
	query := FQNavigationQuery
		direction: FQIncomingNavigation
		association: (FQNavigationAssociations with: FamixStInvocation).
	self assert: (query runOn: grp) size equals: 3
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testIncomingInvocation2 [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANPacket.contents()').
	query := FQNavigationQuery
		direction: FQIncomingNavigation
		association:
			(FQNavigationAssociations
				withAll:
					{FamixStInvocation.
					FamixStInheritance}).
	self assert: (query runOn: grp) size equals: 3
]

{ #category : #tests }
FQNavigationQueryTest >> testIsValid [
	query := self actualClass
		direction: FQOutgoingNavigation
		association: FQAllNavigationAssociations new.	
	self assert: query isValid.
	
	query := self actualClass
		direction: 'Not a Navigation strategy'
		association: FQAllNavigationAssociations new.
	self deny: query isValid.
	
	query := self actualClass
		direction: FQOutgoingNavigation
		association: 'Not an association strategy'.	
	self deny: query isValid.

	query := self actualClass new.
	self deny: query isValid.
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testLocalIncomingInvocation [
	| grp |
	grp := MooseAbstractGroup new.
	grp
		add: (model entityNamed: 'Smalltalk::LANAbstractDestinationAddress').
	query := FQNavigationQuery
		direction: FQLocalIncomingNavigation
		association: FQAllNavigationAssociations new.
	self assert: (query runOn: grp) size equals: 1.
	self
		assert: (query runOn: grp) anyOne mooseName
		equals: 'Smalltalk::LANSingleDestinationAddress'.
	query := FQNavigationQuery
		direction: FQIncomingNavigation
		association: FQAllNavigationAssociations new.
	self assert: (query runOn: grp) size equals: 2
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testLocalOutgoingInvocation [
	| grp |
	grp := MooseAbstractGroup new.
	grp
		add: (model entityNamed: 'Smalltalk::LANAbstractDestinationAddress').
	query := FQNavigationQuery
		direction: FQLocalOutgoingNavigation
		association: FQAllNavigationAssociations new.
	self assert: (query runOn: grp) size equals: 1.
	self
		assert: (query runOn: grp) anyOne mooseName
		equals: 'Smalltalk::Object'.
	query := FQNavigationQuery
		direction: FQOutgoingNavigation
		association: FQAllNavigationAssociations new.
	self assert: (query runOn: grp) size equals: 2
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testName [
	query := self actualClass
		direction: FQLocalIncomingNavigation
		association:
			(FQNavigationAssociations
				withAll:
					{FamixTReference.
					FamixTAccess}).
	self assert: query name equals: 'Local Incoming references, accesses'.
	query := self actualClass new.
	self assert: query name equals: 'Invalid Navigation Query'
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testOutgoingInheritance [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANFileServer').
	query := FQNavigationQuery
		direction: FQOutgoingNavigation
		association:
			(FQNavigationAssociations with: FamixTInheritance).	"FamixStInheritance"
	self
		assert: (query runOn: grp) anyOne
		equals: (model entityNamed: 'Smalltalk::LANOutputServer')
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testPrintOn [
	query := self actualClass
		direction: FQLocalIncomingNavigation
		association:
			(FQNavigationAssociations
				withAll:
					{FamixTReference.
					FamixTAccess}).
	self
		assert: query printString
		equals: 'a FQNavigationQuery (Local Incoming references, accesses)'
]

{ #category : #'tests - adding - removing' }
FQNavigationQueryTest >> testRemoveAssociation [
	query := self actualClass new
		directionStrategy: FQIncomingNavigation;
		associationStrategy: FQAllNavigationAssociations new.
		
	query removeAssociation: FamixStAccess.
	self deny: (query associationStrategy associations includes: FamixStAccess).
	self
		assert: query associationStrategy class
		identicalTo: FQNavigationAssociations.
		
	query associationStrategy: (FQNavigationAssociations with: FamixStAccess).
	self
		should: [ query removeAssociation: FamixStAccess ]
		raise: FQCannotRemoveLastNavigationAssociation
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testRunOn [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANNode.initialize()').
	
	query := FQNavigationQuery
		direction: FQOutgoingNavigation
		association: FQAllNavigationAssociations new.
	
	self assert: (query runOn: grp) size equals: 2
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testStoreOn [
	| generatedQuery |
	query := self actualClass new.
	query directionStrategy: query availableDirections first.
	query associationStrategy: (FQNavigationAssociations
									withAll: (query availableAssociationsFor: model)).
	
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	
	self assert: generatedQuery class identicalTo: self actualClass.
	self assert: generatedQuery directionStrategy identicalTo: query directionStrategy.
	self assert: generatedQuery associationStrategy class identicalTo: query associationStrategy class.
	self assertCollection: generatedQuery associationStrategy associations hasSameElements: query associationStrategy associations
]

{ #category : #tests }
FQNavigationQueryTest >> testSyntacticSugar [
	query := self actualClass new
		direction: #Incoming;
		association: #Access;
		association: #Inheritance.
	self
		assert: query directionStrategy
		identicalTo: FQIncomingNavigation.
	self
		assert: query associationStrategy class
		identicalTo: FQNavigationAssociations.
	self
		assertCollection: query associationStrategy associations
		hasSameElements: {FamixTAccess. FamixTInheritance}
]
