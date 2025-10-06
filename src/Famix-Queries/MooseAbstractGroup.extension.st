Extension { #name : 'MooseAbstractGroup' }

{ #category : '*Famix-Queries' }
MooseAbstractGroup >> allAssociationTypes [

	^ self
		  cacheAt: #allAssociationTypes
		  ifAbsentPut: [  (self collectAsSet: #class) select: [ :each | each withAllSuperclasses anySatisfy: [ :e | e isComposedBy: TAssociationMetaLevelDependency ] ] ]
]

{ #category : '*Famix-Queries' }
MooseAbstractGroup >> allEntityTypes [

	^ self
		  cacheAt: #allEntityTypes
		  ifAbsentPut: [ (self collectAsSet: #class) select: [ :class | class withAllSuperclasses anySatisfy: [ :each | each isComposedBy: TEntityMetaLevelDependency ] ] ]
]
