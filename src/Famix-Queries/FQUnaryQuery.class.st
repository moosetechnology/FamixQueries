Class {
	#name : #FQUnaryQuery,
	#superclass : #FQAbstractQuery,
	#instVars : [
		'parent'
	],
	#category : #'Famix-Queries-Core'
}

{ #category : #default }
FQUnaryQuery class >> defaultForParent: aQuery [
	^ (self isAbstract
		ifTrue: [ self subclasses detect: [ :subclass | subclass isAbstract not ] ]
		ifFalse: [ self ]) new
		parent: aQuery;
		beDefaultForParent;
		yourself
]

{ #category : #default }
FQUnaryQuery class >> isAbstract [
	^ self == FQUnaryQuery
]

{ #category : #printing }
FQUnaryQuery class >> stringForClass: aClass [
	^ (aClass name piecesCutWhere: [ :char1 :char2 | char2 isUppercase ])
		last asEnglishPlural
]

{ #category : #adding }
FQUnaryQuery >> addToParentsSequence: sequence [
	parent ifNotNil: [ parent addToParentsSequence: sequence ].
	(sequence includes: self)
		ifTrue: [ children
				do:
					[ :child | (sequence detect: [ :query | query = self ]) addChild: child ] ]
		ifFalse: [ sequence addLast: self ].
	^ sequence
]

{ #category : #adding }
FQUnaryQuery >> beChildOf: aQuery [
	parent ifNotNil: [ self prepareRemoval ].
	self parent: aQuery.
	aQuery addChild: self
]

{ #category : #default }
FQUnaryQuery >> beDefaultForParent [
	self subclassResponsibility
]

{ #category : #running }
FQUnaryQuery >> computeResult [
	self isValid
		ifFalse: [ ^ MooseGroup new ].
	^ self runOn: parent result
]

{ #category : #printing }
FQUnaryQuery >> displayOn: aStream [
	self displayOn: aStream with: self parentDisplayString
]

{ #category : #printing }
FQUnaryQuery >> displayOn: aStream with: aString [
	^ self subclassResponsibility
]

{ #category : #testing }
FQUnaryQuery >> hasNoParent [
	^ parent isNil
]

{ #category : #comparing }
FQUnaryQuery >> hasSameParametersAs: aQuery [
	^ self subclassResponsibility
]

{ #category : #comparing }
FQUnaryQuery >> hasSameParentsAs: aQuery [
	^ parent = aQuery parent
]

{ #category : #accessing }
FQUnaryQuery >> parent [
	^ parent
]

{ #category : #accessing }
FQUnaryQuery >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
FQUnaryQuery >> parentDisplayString [
	(parent isNil or: [ parent isRootQuery ])
		ifTrue: [ ^ 'aMooseGroup' ].
	^ String
		streamContents: [ :aStream | 
			aStream << $(.
			parent displayOn: aStream.
			aStream << $) ]
]

{ #category : #removing }
FQUnaryQuery >> prepareRemoval [
	parent removeChild: self.
	parent := nil
]

{ #category : #replacing }
FQUnaryQuery >> replace: anotherQuery [
	(anotherQuery isKindOf: FQUnaryQuery)
		ifFalse: [ self inform: 'Cannot replace a binary query with a unary query'.
			^ anotherQuery ].
	self beChildOf: anotherQuery parent.
	anotherQuery prepareRemoval.
	anotherQuery children
		do: [ :childQuery | 
			childQuery
				resetResult;
				replaceParent: anotherQuery with: self ]
]

{ #category : #replacing }
FQUnaryQuery >> replaceParent: aParent with: anotherQuery [
	parent == aParent
		ifFalse: [ ^ self ].
	self beChildOf: anotherQuery
]

{ #category : #removing }
FQUnaryQuery >> resetParents [
	parent := nil
]

{ #category : #printing }
FQUnaryQuery >> storeOn: aStream withParentsIn: queries [
	(parent isNil
		or: [ parent isRootQuery or: [ (queries includes: parent) not ] ])
		ifFalse: [ parent storeOn: aStream withParentsIn: queries.
			aStream << ' --> ' ].
	aStream << '('.
	self storeOn: aStream.
	aStream << ')'
]
