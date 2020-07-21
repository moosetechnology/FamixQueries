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
	#name : #FQAbstractNavigationDirection,
	#superclass : #Object,
	#category : #'Famix-Queries-Navigation-Strategies'
}

{ #category : #accessing }
FQAbstractNavigationDirection class >> associationsFor: aMooseGroup [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQAbstractNavigationDirection class >> availableAssociationsFor: aMooseGroup [
	| associations model |
	aMooseGroup ifEmpty: [ ^ #() ].
	associations := self associationsFor: aMooseGroup.
	model := aMooseGroup isMooseModel
		ifTrue: [ aMooseGroup ]
		ifFalse: [ aMooseGroup mooseModel ].
	
	^ ((model allAssociationTypes
		select: [ :class | 
			associations
				anySatisfy: [ :type | class = type or: [ class allTraits includes: type ] ] ])
		flatCollect: #withAllSubclasses)
	
	"This is for compatibilty MM"
		select:
			[ :class | (model metamodel classes collect: #implementingClass) includes: class ]
]

{ #category : #printing }
FQAbstractNavigationDirection class >> displayOn: aStream with: anAssociationStrategy [
	self subclassResponsibility
]

{ #category : #printing }
FQAbstractNavigationDirection class >> label [
	^ self subclassResponsibility
]

{ #category : #action }
FQAbstractNavigationDirection class >> query: anEntity with: anAssociationStrategy [
	^ self subclassResponsibility
]
