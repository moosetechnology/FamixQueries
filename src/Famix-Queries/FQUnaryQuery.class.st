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
	^ self new
		parent: aQuery;
		beDefaultForParent;
		yourself
]

{ #category : #comparing }
FQUnaryQuery >> = aQuery [
	^ super = aQuery and: [ self hasSameParametersAs: aQuery ]
]

{ #category : #adding }
FQUnaryQuery >> addToParentsSequence: sequence [
	parent ifNotNil: [ parent addToParentsSequence: sequence ].
	sequence addLast: self.
	^ sequence
]

{ #category : #adding }
FQUnaryQuery >> beChildOf: aQuery [
	parent ifNotNil: [ self prepareRemoval ].
	self parent: aQuery.
	aQuery addChild: self
]

{ #category : #running }
FQUnaryQuery >> computeResult [
	^ self runOn: parent result
]

{ #category : #testing }
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

{ #category : #removing }
FQUnaryQuery >> prepareRemoval [
	parent removeChild: self.
	parent := nil
]
