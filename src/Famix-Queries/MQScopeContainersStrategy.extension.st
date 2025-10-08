Extension { #name : 'MQScopeContainersStrategy' }

{ #category : '*Famix-Queries' }
MQScopeContainersStrategy class >> availableScopesForEntity: class in: model [
	"Return all the possible containers scopes of this class that are in a model."

	^ (class allContainerTypesIn: model metamodel) flatCollectAsSet: #withAllSubclasses
]

{ #category : '*Famix-Queries' }
MQScopeContainersStrategy class >> label [
	^ 'Up'
]

{ #category : '*Famix-Queries' }
MQScopeContainersStrategy class >> priority [
	^ 10
]

{ #category : '*Famix-Queries' }
MQScopeContainersStrategy class >> scope: aFamixClass on: entity [

	^ entity query containers ofType: aFamixClass
]

{ #category : '*Famix-Queries' }
MQScopeContainersStrategy class >> scope: aFamixClass recursively: aBoolean on: entity [

	^ (entity query containers isRecursive: aBoolean) ofType: aFamixClass
]

{ #category : '*Famix-Queries' }
MQScopeContainersStrategy class >> scopingSelector [

	^ #containersOfType:
]
