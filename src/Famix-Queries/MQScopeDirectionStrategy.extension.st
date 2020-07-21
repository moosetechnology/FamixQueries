Extension { #name : #MQScopeDirectionStrategy }

{ #category : #'*Famix-Queries' }
MQScopeDirectionStrategy class >> allChildrenScopesOf: aClass in: aModel [
	"Return all the possible children scopes of this class that are in a model."

	^ (aClass allChildrenTypesIn: aModel metamodel) flatCollectAsSet: #withAllSubclasses
]

{ #category : #'*Famix-Queries' }
MQScopeDirectionStrategy class >> allParentsScopesOf: aClass in: aModel [
	"Return all the possible parents scopes of this class that are in a model."

	^ (aClass allParentTypesIn: aModel metamodel) flatCollectAsSet: #withAllSubclasses
]

{ #category : #'*Famix-Queries' }
MQScopeDirectionStrategy class >> availableScopesFor: aMooseGroup [
	"Return the list of possible scopes in a moose group for the direction of the strategy."

	| model |
	aMooseGroup ifEmpty: [ ^ {} ].
	model := aMooseGroup localMooseModel.
	^ ((aMooseGroup allEntityTypes flatCollectAsSet: [ :class | self availableScopesForEntity: class in: model ]) & model allEntityTypes) asArray
]

{ #category : #'*Famix-Queries' }
MQScopeDirectionStrategy class >> availableScopesForEntity: class in: model [
	"Return the list of possible scopes for a class in a model for the direction of the strategy."

	^ self subclassResponsibility
]

{ #category : #'*Famix-Queries' }
MQScopeDirectionStrategy class >> defaultDirection [
	^ MQScopeAllStrategy
]

{ #category : #'*Famix-Queries' }
MQScopeDirectionStrategy class >> directionStrategies [
	^ self allSubclasses sort: #priority ascending
]

{ #category : #'*Famix-Queries' }
MQScopeDirectionStrategy class >> label [
	^ self subclassResponsibility
]

{ #category : #'*Famix-Queries' }
MQScopeDirectionStrategy class >> priority [
	^ self subclassResponsibility
]

{ #category : #'*Famix-Queries' }
MQScopeDirectionStrategy class >> scope: aFamixClass on: aMooseGroup [
	^ self subclassResponsibility
]

{ #category : #'*Famix-Queries' }
MQScopeDirectionStrategy class >> scopingSelector [
	^ self subclassResponsibility
]
