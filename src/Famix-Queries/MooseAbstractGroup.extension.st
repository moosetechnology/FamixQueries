Extension { #name : 'MooseAbstractGroup' }

{ #category : '*Famix-Queries' }
MooseAbstractGroup >> allEntityTypes [
	^ self collectAsSet: #class
]
