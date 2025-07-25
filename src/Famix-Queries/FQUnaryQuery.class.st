"
I am the class that do unary operations for queries. That means all operations that are done with only one query. see my children classes.
"
Class {
	#name : 'FQUnaryQuery',
	#superclass : 'FQAbstractQuery',
	#instVars : [
		'parent'
	],
	#category : 'Famix-Queries-Core',
	#package : 'Famix-Queries',
	#tag : 'Core'
}

{ #category : 'instance creation' }
FQUnaryQuery class >> defaultForParent: aQuery [
	^(self isAbstract
		ifTrue: [ self subclasses detect: [ :subclass | subclass isAbstract not ] ]
		ifFalse: [ self ])
			new
		parent: aQuery;
		beDefaultForParent;
		yourself
]

{ #category : 'default' }
FQUnaryQuery class >> isAbstract [
	^ self == FQUnaryQuery
]

{ #category : 'testing' }
FQUnaryQuery class >> isUnaryQuery [

	^ true
]

{ #category : 'composition' }
FQUnaryQuery >> --> aChildQuery [
	^ aChildQuery
		beChildOf: self;
		yourself
]

{ #category : 'adding' }
FQUnaryQuery >> addToParentsSequence: sequence [

	parent ifNotNil: [ parent addToParentsSequence: sequence ].
	(sequence includes: self)
		ifTrue: [ 
			children do: [ :child | 
				(sequence detect: [ :query | query = self ]) addChild: child ] ]
		ifFalse: [ sequence addLast: self ].
	^ sequence
]

{ #category : 'adding' }
FQUnaryQuery >> beChildOf: aQuery [
	parent ifNotNil: [ self prepareRemoval ].
	self parent: aQuery.
	aQuery addChild: self
]

{ #category : 'default' }
FQUnaryQuery >> beDefaultForParent [
	self subclassResponsibility
]

{ #category : 'running' }
FQUnaryQuery >> computeResult [

	^ result := self isValid
		            ifTrue: [ self runOn: parent result ]
		            ifFalse: [ MooseGroup new ]
]

{ #category : 'accessing' }
FQUnaryQuery >> dependencies [

	^ self parentSequenceWithoutRoot
]

{ #category : 'printing' }
FQUnaryQuery >> displayOn: aStream [
	self displayOn: aStream with: self parentDisplayString
]

{ #category : 'printing' }
FQUnaryQuery >> displayOn: aStream with: aString [
	^ self subclassResponsibility
]

{ #category : 'testing' }
FQUnaryQuery >> hasNoParent [
	^ parent isNil
]

{ #category : 'comparing' }
FQUnaryQuery >> hasSameParametersAs: aQuery [
	^ self subclassResponsibility
]

{ #category : 'comparing' }
FQUnaryQuery >> hasSameParentsAs: aQuery [
	^ parent = aQuery parent
]

{ #category : 'testing' }
FQUnaryQuery >> isUnaryQuery [
	^ true
]

{ #category : 'accessing' }
FQUnaryQuery >> parent [
	^ parent
]

{ #category : 'accessing' }
FQUnaryQuery >> parent: anObject [
	parent := anObject
]

{ #category : 'printing' }
FQUnaryQuery >> parentDisplayString [
	(parent isNil or: [ parent isRootQuery ])
		ifTrue: [ ^ 'aMooseGroup' ].
	^ String
		streamContents: [ :aStream | 
			aStream << $(.
			parent displayOn: aStream.
			aStream << $) ]
]

{ #category : 'accessing' }
FQUnaryQuery >> parentSequence [

	| sequence parentToSequence |
	sequence := OrderedCollection new.
	"self addToParentsSequence: sequence.
	^ sequence"
	parentToSequence := parent.
	[ parentToSequence isNotNil ] whileTrue: [ 
		sequence add: parentToSequence.
		parentToSequence := parentToSequence parent ].
	^ sequence
]

{ #category : 'accessing' }
FQUnaryQuery >> parentSequenceWithoutRoot [

	(parent isNil or: [ parent isRootQuery ]) ifTrue: [
		^ OrderedCollection new ].
	^ (OrderedCollection with: parent) , parent parentSequenceWithoutRoot
]

{ #category : 'removing' }
FQUnaryQuery >> prepareRemoval [
	parent removeChild: self.
	parent := nil
]

{ #category : 'accessing' }
FQUnaryQuery >> resetParent [

	parent removeChild: self.
	parent := nil
]

{ #category : 'execution' }
FQUnaryQuery >> rootQuery: aFQRootQuery [

	self parent
		ifNil: [ self parent: aFQRootQuery ]
		ifNotNil: [ self parent rootQuery: aFQRootQuery ]
]

{ #category : 'printing' }
FQUnaryQuery >> storeWithParentsOn: aStream [

	(parent isNil or: [ parent isRootQuery ]) ifFalse: [ 
		parent storeWithParentsOn: aStream.
		aStream << ' --> ' ].
	aStream << '('.
	self storeOn: aStream.
	aStream << ')'
]
