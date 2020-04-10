Class {
	#name : #FQNavigationQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQNavigationQueryTest >> actualClass [
	^ FQNavigationQuery
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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
FQNavigationQueryTest >> testIncomingInvocation [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANPacket.contents()').
	query := FQNavigationQuery
		direction: FQIncomingNavigationQueryStrategy
		association: (FQAssociationNavigationQueryStrategy with: FamixStInvocation).
	self assert: (query runOn: grp) size equals: 3
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
FQNavigationQueryTest >> testRunOn [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANNode.initialize()').
	query := FQNavigationQuery
		direction: FQOutgoingNavigationQueryStrategy
		association: FQAllAssociationsNavigationQueryStrategy new.
	self assert: (query runOn: grp) size equals: 2
]

{ #category : #tests }
FQNavigationQueryTest >> testStoreOn [
	| generatedQuery |
	query := self actualClass new.
	query direction: query availableDirections first.
	query association: (FQAssociationNavigationQueryStrategy
									withAll: (query availableAssociationsFor: model)).
	
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	
	self assert: generatedQuery class identicalTo: self actualClass.
	self assert: generatedQuery direction identicalTo: query direction.
	self assert: generatedQuery association class identicalTo: query association class.
	self assertCollection: generatedQuery association associations hasSameElements: query association associations
]
