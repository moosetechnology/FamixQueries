Extension { #name : 'MQScopeContainedEntitiesStrategy' }

{ #category : '*Famix-Queries' }
MQScopeContainedEntitiesStrategy class >> availableScopesForEntity: class in: model [
	"Return all the possible children scopes of this class that are in a model."

	^ (class allContainedEntityTypesIn: model metamodel) flatCollectAsSet: #withAllSubclasses
]

{ #category : '*Famix-Queries' }
MQScopeContainedEntitiesStrategy class >> label [
	^ 'Down'
]

{ #category : '*Famix-Queries' }
MQScopeContainedEntitiesStrategy class >> priority [
	^ 20
]

{ #category : '*Famix-Queries' }
MQScopeContainedEntitiesStrategy class >> scope: aFamixClass on: entity [

	^ entity query containedEntities ofType: aFamixClass
]

{ #category : '*Famix-Queries' }
MQScopeContainedEntitiesStrategy class >> scope: aFamixClass recursively: aBoolean on: entity [

	^ (entity query containedEntities isRecursive: aBoolean) ofType: aFamixClass
]

{ #category : '*Famix-Queries' }
MQScopeContainedEntitiesStrategy class >> scopingSelector [

	^ #containedEntitiesOfType:
]
