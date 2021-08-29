Extension { #name : #MQScopeAllStrategy }

{ #category : #'*Famix-Queries' }
MQScopeAllStrategy class >> availableScopesForEntity: class in: model [
	^ (self allChildrenScopesOf: class in: model) , (self allParentsScopesOf: class in: model)
]

{ #category : #'*Famix-Queries' }
MQScopeAllStrategy class >> label [
	^ 'Up and Down'
]

{ #category : #'*Famix-Queries' }
MQScopeAllStrategy class >> priority [
	^ 15
]

{ #category : #'*Famix-Queries' }
MQScopeAllStrategy class >> scope: aFamixClass on: aMooseGroup [
	^ ((MooseObjectQueryResult withAll: aMooseGroup)
		withScope: aFamixClass) asMooseGroup
]

{ #category : #'*Famix-Queries' }
MQScopeAllStrategy class >> scopingSelector [
	^ #withScope:
]
