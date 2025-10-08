Extension { #name : 'MQScopeDirectionStrategy' }

{ #category : '*Famix-Queries' }
MQScopeDirectionStrategy class >> availableScopesFor: aMooseGroup [
	"Return the list of possible scopes in a moose group for the direction of the strategy."

	| model |
	aMooseGroup ifEmpty: [ ^ {  } ].
	model := aMooseGroup localMooseModel.
	^ ((aMooseGroup allEntityTypes flatCollectAsSet: [ :class | self availableScopesForEntity: class in: model ]) & model allEntityTypes) asArray
]

{ #category : '*Famix-Queries' }
MQScopeDirectionStrategy class >> availableScopesForEntity: class in: model [
	"Return the list of possible scopes for a class in a model for the direction of the strategy."

	^ self subclassResponsibility
]

{ #category : '*Famix-Queries' }
MQScopeDirectionStrategy class >> defaultDirection [

	^ MQScopeContainersStrategy
]

{ #category : '*Famix-Queries' }
MQScopeDirectionStrategy class >> directionStrategies [

	self flag: #todo. "Remove the reject when we will have not deprecated subclass."
	^ (self allSubclasses reject: #isDeprecated) sort: #priority ascending
]

{ #category : '*Famix-Queries' }
MQScopeDirectionStrategy class >> label [
	^ self subclassResponsibility
]

{ #category : '*Famix-Queries' }
MQScopeDirectionStrategy class >> priority [
	^ self subclassResponsibility
]

{ #category : '*Famix-Queries' }
MQScopeDirectionStrategy class >> scope: aFamixClass on: entity [

	^ self subclassResponsibility
]

{ #category : '*Famix-Queries' }
MQScopeDirectionStrategy class >> scope: aFamixClass recursively: aBoolean on: entity [

	^ self subclassResponsibility
]

{ #category : '*Famix-Queries' }
MQScopeDirectionStrategy class >> scopingSelector [
	^ self subclassResponsibility
]
