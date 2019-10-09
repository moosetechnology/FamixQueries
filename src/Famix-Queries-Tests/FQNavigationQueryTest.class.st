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
	query := FQNavigationQuery association: (FQAssociationNavigationQueryStrategy with: FamixStInvocation) direction: FQIncomingNavigationQueryStrategy.

	self assert: (String streamContents: [ :aStream | query displayOn: aStream ]) equals: '(aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: (entity queryIncoming: FamixStInvocation) opposites.
			result ]) asMooseGroup'
]

{ #category : #tests }
FQNavigationQueryTest >> testDisplayIncomingInvocation2 [
	query := FQNavigationQuery association: (FQAssociationNavigationQueryStrategy withAll: {FamixStInvocation . FamixStInheritance}) direction: FQIncomingNavigationQueryStrategy.

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
	query := FQNavigationQuery association: FQAllAssociationsNavigationQueryStrategy new direction: FQOutgoingNavigationQueryStrategy.

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

	query := FQNavigationQuery association: (FQAssociationNavigationQueryStrategy with: FamixStInvocation) direction: FQIncomingNavigationQueryStrategy.

	self assert: (query runOn: grp) size equals: 3
]

{ #category : #tests }
FQNavigationQueryTest >> testIncomingInvocation2 [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANPacket.contents()').

	query := FQNavigationQuery association: (FQAssociationNavigationQueryStrategy withAll: {FamixStInvocation . FamixStInheritance}) direction: FQIncomingNavigationQueryStrategy.

	self assert: (query runOn: grp) size equals: 3
]

{ #category : #tests }
FQNavigationQueryTest >> testLocalIncomingInvocation [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANAbstractDestinationAddress').

	query := FQNavigationQuery association: FQAllAssociationsNavigationQueryStrategy new direction: FQLocalIncomingNavigationQueryStrategy.
	self assert: (query runOn: grp) size equals: 1.
	self assert: (query runOn: grp) anyOne mooseName equals: 'Smalltalk::LANSingleDestinationAddress'.

	query := FQNavigationQuery association: FQAllAssociationsNavigationQueryStrategy new direction: FQIncomingNavigationQueryStrategy.
	self assert: (query runOn: grp) size equals: 2
]

{ #category : #tests }
FQNavigationQueryTest >> testLocalOutgoingInvocation [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANAbstractDestinationAddress').
	
	query := FQNavigationQuery association: FQAllAssociationsNavigationQueryStrategy new direction: FQLocalOutgoingNavigationQueryStrategy.
	self assert: (query runOn: grp) size equals: 1.
	self assert: (query runOn: grp) anyOne mooseName equals: 'Smalltalk::Object'.

	query := FQNavigationQuery association: FQAllAssociationsNavigationQueryStrategy new direction: FQOutgoingNavigationQueryStrategy.
	self assert: (query runOn: grp) size equals: 2
]

{ #category : #tests }
FQNavigationQueryTest >> testOutgoingInheritance [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANFileServer').

	query := FQNavigationQuery association: (FQAssociationNavigationQueryStrategy with: FamixStInheritance) direction: FQOutgoingNavigationQueryStrategy.

	self assert: (query runOn: grp) anyOne equals: (model entityNamed: 'Smalltalk::LANOutputServer')
]

{ #category : #tests }
FQNavigationQueryTest >> testRunOn [
	| grp |
	grp := MooseAbstractGroup new.
	grp add: (model entityNamed: 'Smalltalk::LANNode.initialize()').

	query := FQNavigationQuery association: (FQAllAssociationsNavigationQueryStrategy new) direction: FQOutgoingNavigationQueryStrategy.

	self assert: (query runOn: grp) size equals: 2
]
