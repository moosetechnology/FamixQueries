Extension { #name : #FamixTScopingEntity }

{ #category : #'*Famix-Queries' }
FamixTScopingEntity >> allParentScopes [
	| result |
	result := OrderedCollection new.
	self allParentScopesDo: [ :each | result add: each ].
	^ result
]
