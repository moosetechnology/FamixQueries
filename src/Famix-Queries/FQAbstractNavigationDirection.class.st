"
I am a direction strategy used by FQNavigationQuery.

See my Class side.

My main method is #query:with:
	- It is called by an FQNavigationQuery
	- It takes as argument an input MooseGroup and an association strategy (see FQAstractNaigationAssociations).
	- It triggers the associations strategy with my direction.
	- It returns a mooseGroup
		
I also provide #availableAssociationsFor: method.
It uses MooseQuery trait TEntityMetaLevelDependency.
It returns the associations available in my direction for the input entity.

The direction of the associations depend on my subclasses behavior.
"
Class {
	#name : 'FQAbstractNavigationDirection',
	#superclass : 'Object',
	#category : 'Famix-Queries-Navigation-Strategies',
	#package : 'Famix-Queries',
	#tag : 'Navigation-Strategies'
}

{ #category : 'accessing' }
FQAbstractNavigationDirection class >> associationsFor: aMooseGroup [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
FQAbstractNavigationDirection class >> availableAssociationsFor: workingGroup [
	"Compute associations that apply to entities in the workingGroup (result of parent query)"

	| associationTraits model |
	workingGroup ifEmpty: [ ^ #(  ) ].
	associationTraits := self associationsFor: workingGroup.
	model := workingGroup localMooseModel.

	^ ((model allAssociationTypes
		select: [ :assoType | associationTraits anySatisfy: [ :trait | assoType isOfType: trait ] ])
		flatCollect: #withAllSubclasses)
		select: [ :assoType | (model metamodel classes collect: #implementingClass) includes: assoType ]
]

{ #category : 'printing' }
FQAbstractNavigationDirection class >> displayOn: aStream with: anAssociationStrategy [
	self subclassResponsibility
]

{ #category : 'printing' }
FQAbstractNavigationDirection class >> label [
	^ self subclassResponsibility
]

{ #category : 'action' }
FQAbstractNavigationDirection class >> query: anEntity with: anAssociationStrategy [
	^ self subclassResponsibility
]
