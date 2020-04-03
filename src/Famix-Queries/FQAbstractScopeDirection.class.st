Class {
	#name : #FQAbstractScopeDirection,
	#superclass : #Object,
	#category : #'Famix-Queries-Utils'
}

{ #category : #'available scopes' }
FQAbstractScopeDirection class >> availableScopesFor: aMooseGroup [
	^ ((self respondingEntitiesIn: aMooseGroup) entities
		flatCollectAsSet: [ :entity | 
			(self availableScopesForEntity: entity)
				reject: [ :type | type isTrait ] ]) asArray
]

{ #category : #'available scopes' }
FQAbstractScopeDirection class >> availableScopesForEntity: entity [
	^ self subclassResponsibility
]

{ #category : #default }
FQAbstractScopeDirection class >> defaultDirection [
	^ FQScopeUpDownDirection
]

{ #category : #'available scopes' }
FQAbstractScopeDirection class >> respondingEntitiesIn: aMooseGroup [
	self
		flag: 'Does a selection on the entities. They may not all respond'.
	^ aMooseGroup allUsing: TEntityMetaLevelDependency
]

{ #category : #scoping }
FQAbstractScopeDirection class >> scope: aFamixClass on: aMooseGroup [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQAbstractScopeDirection class >> scopingSelector [
	^ self subclassResponsibility
]
