Extension { #name : #MQScopeDownStrategy }

{ #category : #'*Famix-Queries' }
MQScopeDownStrategy class >> availableScopesForEntity: class in: model [
	^ self allChildrenScopesOf: class in: model
]

{ #category : #'*Famix-Queries' }
MQScopeDownStrategy class >> label [
	^ 'Down'
]

{ #category : #'*Famix-Queries' }
MQScopeDownStrategy class >> priority [
	^ 20
]

{ #category : #'*Famix-Queries' }
MQScopeDownStrategy class >> scope: aFamixClass on: aMooseGroup [
	^ ((MooseObjectQueryResult withAll: aMooseGroup) toScope: aFamixClass)
		asMooseGroup
]

{ #category : #'*Famix-Queries' }
MQScopeDownStrategy class >> scopingSelector [
	^ #toScope:
]
