Class {
	#name : #FQNavigationQueryTest,
	#superclass : #FQUnaryQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #running }
FQNavigationQueryTest >> actualClass [
	^ FQNavigationQuery
]

{ #category : #'class example' }
FQNavigationQueryTest >> allIncomingForClassExample [
	^ self incomingAccessesForClassExample
		, self incomingInvocationsForClassExample
		, self incomingReferencesForClassExample
]

{ #category : #'class example' }
FQNavigationQueryTest >> allLocalIncomingForClassExample [
	^ self localIncomingReferencesForClassExample
]

{ #category : #'class example' }
FQNavigationQueryTest >> allLocalOutgoingForClassExample [
	^ self localOutgoingInheritancesForClassExample
]

{ #category : #'class example' }
FQNavigationQueryTest >> allOutgoingForClassExample [
	^ self outgoingAccessesForClassExample
		, self outgoingInheritancesForClassExample
		, self outgoingInvocationsForClassExample
]

{ #category : #'class example' }
FQNavigationQueryTest >> classExample [
	^ MooseAbstractGroup new
		add: (helper modelExample entityNamed: 'Smalltalk::LANFileServer');
		yourself
]

{ #category : #running }
FQNavigationQueryTest >> expectedPrintOnString [
	^ 'a FQNavigationQuery (Incoming accesses, inheritances, invocations, references, traitusages)'
]

{ #category : #'class example' }
FQNavigationQueryTest >> incomingAccessesForClassExample [
	"(self classExample anyOne queryIncoming: FamixTAccess) opposites"

	^ MooseGroup new
		add: (helper modelExample entityNamed: 'Smalltalk::LANFileServer.name()');
		add: (helper modelExample entityNamed: 'Smalltalk::LANFileServer.output:(Object)');
		yourself
]

{ #category : #'running - queries' }
FQNavigationQueryTest >> incomingAllAssociationsQuery [
	^ self actualClass new
		directionStrategy: FQIncomingNavigation;
		associationStrategy: FQAllNavigationAssociations new
]

{ #category : #'class example' }
FQNavigationQueryTest >> incomingInvocationsForClassExample [
	"(self classExample anyOne queryIncoming: FamixTInvocation) opposites"

	^ MooseGroup new
		add: (helper modelExample entityNamed: 'Smalltalk::LANInterface.originate()');
		add: (helper modelExample entityNamed: 'Smalltalk::LANFileServer.output:(Object)');
		add: (helper modelExample entityNamed: 'Smalltalk::LANNode.printOn:(Object)');
		add: (helper modelExample entityNamed: 'Smalltalk::TLANInterface.originate()');
		add: (helper modelExample entityNamed: 'Smalltalk::LANNode.send:(Object)');
		add: (helper modelExample entityNamed: 'Smalltalk::LANOutputServer.accept:(Object)');
		add: (helper modelExample entityNamed: 'Smalltalk::LANPacket.printOn:(Object)');
		yourself
]

{ #category : #'class example' }
FQNavigationQueryTest >> incomingReferencesForClassExample [
	"(self classExample anyOne queryIncoming: FamixTReferences) opposites"

	^ MooseGroup new
		add: (helper modelExample entityNamed: 'Smalltalk::LANInterface.newFileServer()');
		yourself
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> incomingTest [
	self
		assertCollection: (query runOn: self classExample)
		hasSameElements: self allIncomingForClassExample.

	"One tpe of associations"
	query
		associationStrategy: (FQNavigationAssociations with: FamixTAccess).
	self
		assertCollection: (query runOn: self classExample)
		hasSameElements: self incomingAccessesForClassExample.

	"Empty result"
	query
		associationStrategy: (FQNavigationAssociations with: FamixTInheritance).
	self assert: (query runOn: self classExample) isEmpty
]

{ #category : #'running - queries' }
FQNavigationQueryTest >> localIncomingAllAssociationsQuery [
	^ self actualClass new
		directionStrategy: FQLocalIncomingNavigation;
		associationStrategy: FQAllNavigationAssociations new
]

{ #category : #'class example' }
FQNavigationQueryTest >> localIncomingReferencesForClassExample [
	"(self classExample anyOne queryLocalIncoming: FamixTReferences) opposites"

	^ MooseGroup new
		add: (helper modelExample entityNamed: 'Smalltalk::LANInterface.newFileServer()');
		yourself
]

{ #category : #'running - queries' }
FQNavigationQueryTest >> localOutgoingAllAssociationsQuery [
	^ self actualClass new
		directionStrategy: FQLocalOutgoingNavigation;
		associationStrategy: FQAllNavigationAssociations new
]

{ #category : #'class example' }
FQNavigationQueryTest >> localOutgoingInheritancesForClassExample [
	"(self classExample anyOne queryLocalOutgoing: FamixTInheritance) opposites"

	^ MooseGroup new
		add: (helper modelExample entityNamed: 'Smalltalk::LANOutputServer');
		yourself
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> localOutgoingTest [
	query := self localOutgoingAllAssociationsQuery.
	self
		assertCollection: (query runOn: self classExample)
		hasSameElements: self allLocalOutgoingForClassExample.

	"One tpe of associations"
	query
		associationStrategy: (FQNavigationAssociations with: FamixTInheritance).
	self
		assertCollection: (query runOn: self classExample)
		hasSameElements: self localOutgoingInheritancesForClassExample.

	"Empty result"
	query
		associationStrategy: (FQNavigationAssociations with: FamixTReference).
	self assert: (query runOn: self classExample) isEmpty
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> localincomingTest [
	query := self localIncomingAllAssociationsQuery.
	self
		assertCollection: (query runOn: self classExample)
		hasSameElements: self allLocalIncomingForClassExample.

	"One tpe of associations"
	query
		associationStrategy: (FQNavigationAssociations with: FamixTReference).
	self
		assertCollection: (query runOn: self classExample)
		hasSameElements: self localIncomingReferencesForClassExample.

	"Empty result"
	query
		associationStrategy: (FQNavigationAssociations with: FamixTInheritance).
	self assert: (query runOn: self classExample) isEmpty
]

{ #category : #running }
FQNavigationQueryTest >> newQuery [
	^ self incomingAllAssociationsQuery
]

{ #category : #'class example' }
FQNavigationQueryTest >> outgoingAccessesForClassExample [
	"(self classExample anyOne queryOutgoing: FamixTAccess) opposites"

	^ MooseGroup new
		add: (helper modelExample entityNamed: 'Transcript');
		add: (helper modelExample entityNamed: 'Smalltalk::LANOutputServer.serverType');
		add: (helper modelExample entityNamed: 'Smalltalk::LANFileServer.name().super');
		add: (helper modelExample entityNamed: 'Smalltalk::LANFileServer.output:(Object).thePacket');
		add: (helper modelExample entityNamed: 'Smalltalk::LANFileServer.output:(Object).self');
		yourself
]

{ #category : #'running - queries' }
FQNavigationQueryTest >> outgoingAllAssociationsQuery [
	^ self actualClass new
		directionStrategy: FQOutgoingNavigation;
		associationStrategy: FQAllNavigationAssociations new
]

{ #category : #'class example' }
FQNavigationQueryTest >> outgoingInheritancesForClassExample [
	"(self classExample anyOne queryOutgoing: FamixTInheritance) opposites"

	^ MooseGroup new
		add: (helper modelExample entityNamed: 'Smalltalk::LANOutputServer');
		yourself
]

{ #category : #'class example' }
FQNavigationQueryTest >> outgoingInvocationsForClassExample [
	"(self classExample anyOne queryOutgoing: FamixTInvocation) opposites"

	^ MooseGroup new
		add: (helper modelExample entityNamed: 'Smalltalk::LANFileServer.name()');
		add: (helper modelExample entityNamed: 'Smalltalk::LANInterface.contents()');
		add: (helper modelExample entityNamed: 'Smalltalk::LANPacket.contents()');
		add: (helper modelExample entityNamed: 'Smalltalk::LANNode.name()');
		yourself
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> outgoingTest [
	query := self outgoingAllAssociationsQuery.
	self
		assertCollection: (query runOn: self classExample)
		hasSameElements: self allOutgoingForClassExample.

	"One tpe of associations"
	query
		associationStrategy: (FQNavigationAssociations with: FamixTAccess).
	self
		assertCollection: (query runOn: self classExample)
		hasSameElements: self outgoingAccessesForClassExample.

	"Empty result"
	query
		associationStrategy: (FQNavigationAssociations with: FamixTReference).
	self assert: (query runOn: self classExample) isEmpty
]

{ #category : #'tests - adding - removing' }
FQNavigationQueryTest >> testAddAllAssociations [
	query associationStrategy: FQNavigationAssociations new.
	
	query allPossibleAssociations
		do: [ :assoc | query addAssociation: assoc ].
	
	self
		assert: query associationStrategy class
		identicalTo: FQAllNavigationAssociations
]

{ #category : #'tests - adding - removing' }
FQNavigationQueryTest >> testAddAssociation [
	query associationStrategy: FQNavigationAssociations new.

	query addAssociation: FamixTAccess.
	self
		assert: (query associationStrategy associations includes: FamixTAccess).

	query addAssociation: FamixTAccess.
	self
		assert: (query associationStrategy associations occurrencesOf: FamixTAccess)
		equals: 1
]

{ #category : #'tests - available parameters' }
FQNavigationQueryTest >> testAvailableAssociationsFor [
	| availableAssociations |
	availableAssociations := query availableAssociationsFor: helper modelExample.
	self
		assertCollection: FamixTAssociation users
		includesAll: availableAssociations
]

{ #category : #'tests - available parameters' }
FQNavigationQueryTest >> testAvailableDirections [
	self
		assertCollection: query availableDirections
		includesAll: FQAbstractNavigationDirection availableDirections
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testDisplayIncomingInvocation [
	query
		associationStrategy: (FQNavigationAssociations with: FamixTInvocation).
	self
		assert: (String streamContents: [ :aStream | query displayOn: aStream ])
		equals:
			'(aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: (entity queryIncoming: FamixTInvocation) opposites.
			result ]) asMooseGroup'
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testDisplayIncomingInvocation2 [
	query
		associationStrategy:
			(FQNavigationAssociations
				withAll:
					{FamixTInvocation.
					FamixTInheritance}).
	self
		assert: (String streamContents: [ :aStream | query displayOn: aStream ])
		equals:
			'(aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: ({ FamixTInvocation . FamixTInheritance } flatCollect: [ :association | (entity queryIncoming: association) opposites ]).
			result ]) asMooseGroup'
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			'(aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: entity queryAllIncoming opposites.
			result ]) asMooseGroup'
]

{ #category : #tests }
FQNavigationQueryTest >> testEquals [
	super testEquals.

	"Different direction"
	self deny: query equals: self outgoingAllAssociationsQuery.

	"Different association"
	self
		deny: query
		equals:
			(FQNavigationQuery new
				directionStrategy: FQIncomingNavigation;
				associationStrategy: (FQNavigationAssociations with: FamixTInvocation))
]

{ #category : #tests }
FQNavigationQueryTest >> testIsValid [
	super testIsValid.
	self
		deny: (self newQuery directionStrategy: 'Not a Navigation strategy') isValid.
	self
		deny:
			(self newQuery associationStrategy: 'Not an association strategy')
				isValid
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testName [
	query := self actualClass new
		directionStrategy: FQLocalIncomingNavigation;
		associationStrategy:
			(FQNavigationAssociations
				withAll:
					{FamixTReference.
					FamixTAccess}).
	self assert: query name equals: 'Local Incoming references, accesses'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Navigation Query'
]

{ #category : #'tests - adding - removing' }
FQNavigationQueryTest >> testRemoveAssociation [
	query removeAssociation: FamixTAccess.
	self deny: (query associationStrategy associations includes: FamixTAccess).
	self
		assert: query associationStrategy class
		identicalTo: FQNavigationAssociations.
		
	query associationStrategy: (FQNavigationAssociations with: FamixTAccess).
	self
		should: [ query removeAssociation: FamixTAccess ]
		raise: FQCannotRemoveLastNavigationAssociation
]

{ #category : #'tests - running' }
FQNavigationQueryTest >> testRunOn [
	self incomingTest.
	self localincomingTest.
	self outgoingTest.
	self localOutgoingTest
]

{ #category : #'tests - printing' }
FQNavigationQueryTest >> testStoreOn [
	| generatedQuery |
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	self assert: generatedQuery class identicalTo: self actualClass.
	self
		assert: generatedQuery directionStrategy
		identicalTo: query directionStrategy.
	self
		assert: generatedQuery associationStrategy class
		identicalTo: query associationStrategy class.
	self
		assertCollection: generatedQuery associationStrategy associations
		hasSameElements: query associationStrategy associations
]

{ #category : #tests }
FQNavigationQueryTest >> testSyntacticSugar [
	query := self unConfiguredQuery
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
