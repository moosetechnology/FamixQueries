Class {
	#name : #FQNavigationQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQNavigationQueryTest >> actualClass [
	^ FQNavigationQuery
]

{ #category : #'tests adding - removing' }
FQNavigationQueryTest >> testAddAllAssociations [
	query := self actualClass new
		directionStrategy: FQIncomingNavigationQueryStrategy;
		association: FQAssociationNavigationQueryStrategy new.
	query allPossibleAssociations
		do: [ :assoc | query addAssociation: assoc ].
	self
		assert: query association class
		identicalTo: FQAllAssociationsNavigationQueryStrategy
]

{ #category : #'tests adding - removing' }
FQNavigationQueryTest >> testAddAssociation [
	query := self actualClass new
		directionStrategy: FQIncomingNavigationQueryStrategy;
		association: FQAssociationNavigationQueryStrategy new.
	
	query addAssociation: FamixStAccess.
	self assert: (query association associations includes: FamixStAccess).
	
	query addAssociation: FamixStAccess.
	self
		assert: (query association associations occurrencesOf: FamixStAccess)
		equals: 1
]

{ #category : #'tests - available parameters' }
FQNavigationQueryTest >> testAvailableAssociationsFor [
	| availableAssociations |
	query := self actualClass new
		directionStrategy: FQIncomingNavigationQueryStrategy.
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
		includesAll: FQAbstractDirectionNavigationQueryStrategy availableDirections
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testDisplayIncomingInvocation [
	query := FQNavigationQuery
		direction: FQIncomingNavigationQueryStrategy
		association: (FQAssociationNavigationQueryStrategy with: FamixStInvocation).
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
		direction: FQIncomingNavigationQueryStrategy
		association:
			(FQAssociationNavigationQueryStrategy
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
		direction: FQOutgoingNavigationQueryStrategy
		association: FQAllAssociationsNavigationQueryStrategy new.
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
		direction: FQOutgoingNavigationQueryStrategy
		association: FQAllAssociationsNavigationQueryStrategy new.

	"Same query"
	self
		assert: query
		equals:
			(FQNavigationQuery
				direction: FQOutgoingNavigationQueryStrategy
				association: FQAllAssociationsNavigationQueryStrategy new).

	"Different direction"
	self
		deny: query
		equals:
			(FQNavigationQuery
				direction: FQIncomingNavigationQueryStrategy
				association: FQAllAssociationsNavigationQueryStrategy new).

	"Different association"
	self
		deny: query
		equals:
			(FQNavigationQuery
				direction: FQOutgoingNavigationQueryStrategy
				association: (FQAssociationNavigationQueryStrategy with: FamixStInvocation)).

	"Different class of query"
	self deny: query equals: (FQBooleanQuery fromProperty: #isAbstract)
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testIncomingInvocation [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANPacket.contents()').
	query := FQNavigationQuery
		direction: FQIncomingNavigationQueryStrategy
		association: (FQAssociationNavigationQueryStrategy with: FamixStInvocation).
	self assert: (query runOn: grp) size equals: 3
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testIncomingInvocation2 [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANPacket.contents()').
	query := FQNavigationQuery
		direction: FQIncomingNavigationQueryStrategy
		association:
			(FQAssociationNavigationQueryStrategy
				withAll:
					{FamixStInvocation.
					FamixStInheritance}).
	self assert: (query runOn: grp) size equals: 3
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testLocalIncomingInvocation [
	| grp |
	grp := MooseAbstractGroup new.
	grp
		add: (model entityNamed: 'Smalltalk::LANAbstractDestinationAddress').
	query := FQNavigationQuery
		direction: FQLocalIncomingNavigationQueryStrategy
		association: FQAllAssociationsNavigationQueryStrategy new.
	self assert: (query runOn: grp) size equals: 1.
	self
		assert: (query runOn: grp) anyOne mooseName
		equals: 'Smalltalk::LANSingleDestinationAddress'.
	query := FQNavigationQuery
		direction: FQIncomingNavigationQueryStrategy
		association: FQAllAssociationsNavigationQueryStrategy new.
	self assert: (query runOn: grp) size equals: 2
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testLocalOutgoingInvocation [
	| grp |
	grp := MooseAbstractGroup new.
	grp
		add: (model entityNamed: 'Smalltalk::LANAbstractDestinationAddress').
	query := FQNavigationQuery
		direction: FQLocalOutgoingNavigationQueryStrategy
		association: FQAllAssociationsNavigationQueryStrategy new.
	self assert: (query runOn: grp) size equals: 1.
	self
		assert: (query runOn: grp) anyOne mooseName
		equals: 'Smalltalk::Object'.
	query := FQNavigationQuery
		direction: FQOutgoingNavigationQueryStrategy
		association: FQAllAssociationsNavigationQueryStrategy new.
	self assert: (query runOn: grp) size equals: 2
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testOutgoingInheritance [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANFileServer').
	query := FQNavigationQuery
		direction: FQOutgoingNavigationQueryStrategy
		association:
			(FQAssociationNavigationQueryStrategy with: FamixTInheritance).	"FamixStInheritance"
	self
		assert: (query runOn: grp) anyOne
		equals: (model entityNamed: 'Smalltalk::LANOutputServer')
]

{ #category : #'tests adding - removing' }
FQNavigationQueryTest >> testRemoveAssociation [
	query := self actualClass new
		directionStrategy: FQIncomingNavigationQueryStrategy;
		association: FQAllAssociationsNavigationQueryStrategy new.
		
	query removeAssociation: FamixStAccess.
	self deny: (query association associations includes: FamixStAccess).
	self
		assert: query association class
		identicalTo: FQAssociationNavigationQueryStrategy.
		
	query association: (FQAssociationNavigationQueryStrategy with: FamixStAccess).
	self
		should: [ query removeAssociation: FamixStAccess ]
		raise: FQNavigationQueryMustHaveAtLeastOneAssociation
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testRunOn [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANNode.initialize()').
	query := FQNavigationQuery
		direction: FQOutgoingNavigationQueryStrategy
		association: FQAllAssociationsNavigationQueryStrategy new.
	self assert: (query runOn: grp) size equals: 2
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testStoreOn [
	| generatedQuery |
	query := self actualClass new.
	query directionStrategy: query availableDirections first.
	query association: (FQAssociationNavigationQueryStrategy
									withAll: (query availableAssociationsFor: model)).
	
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	
	self assert: generatedQuery class identicalTo: self actualClass.
	self assert: generatedQuery direction identicalTo: query direction.
	self assert: generatedQuery association class identicalTo: query association class.
	self assertCollection: generatedQuery association associations hasSameElements: query association associations
]
