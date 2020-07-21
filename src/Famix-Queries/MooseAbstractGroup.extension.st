Extension { #name : #MooseAbstractGroup }

{ #category : #'*Famix-Queries' }
MooseAbstractGroup >> allAssociationTypes [
	^ self
		lookUpPropertyNamed: #allAssociationTypes
		computedAs: [ (self collectAsSet: #class) select: [ :each | each withAllSuperclasses anySatisfy: [ :e | e isComposedBy: TAssociationMetaLevelDependency ] ] ]
]

{ #category : #'*Famix-Queries' }
MooseAbstractGroup >> allEntityTypes [
	^ self
		lookUpPropertyNamed: #allEntityTypes
		computedAs: [ (self collectAsSet: #class) select: [ :each | each withAllSuperclasses anySatisfy: [ :e | e isComposedBy: TEntityMetaLevelDependency ] ] ]
]
