Extension { #name : #MQScopeUpStrategy }

{ #category : #'*Famix-Queries' }
MQScopeUpStrategy class >> availableScopesForEntity: class in: model [
	^ self allParentsScopesOf: class in: model
]

{ #category : #'*Famix-Queries' }
MQScopeUpStrategy class >> label [
	^ 'Up'
]

{ #category : #'*Famix-Queries' }
MQScopeUpStrategy class >> priority [
	^ 10
]

{ #category : #'*Famix-Queries' }
MQScopeUpStrategy class >> scope: aFamixClass on: aMooseGroup [
	^ ((MooseObjectQueryResult withAll: aMooseGroup) atScope: aFamixClass)
		asMooseGroup
]

{ #category : #'*Famix-Queries' }
MQScopeUpStrategy class >> scopingSelector [
	^ #atScope:
]
