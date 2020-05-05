"
I represent a query and am used by a FQQueriesCombinator.

I hold the query I represent, its parent, its optional children and its result if it was computed.

My parents and children are query wrappers.
My result is computed on my parent result.

The final parent is special: it does not hold a query but only a result, which is the intial MooseGroup that was given as input.
"
Class {
	#name : #FQAbstractQueryWrapper,
	#superclass : #Object,
	#instVars : [
		'result',
		'query',
		'children',
		'label',
		'color'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #adding }
FQAbstractQueryWrapper >> addChild: aQueryWrapper [
	children add: aQueryWrapper
]

{ #category : #accessing }
FQAbstractQueryWrapper >> children [
	^ children
]

{ #category : #accessing }
FQAbstractQueryWrapper >> color [
	^ color ifNil: [ color := query class color ]
]

{ #category : #accessing }
FQAbstractQueryWrapper >> color: aColor [
	color := aColor
]

{ #category : #accessing }
FQAbstractQueryWrapper >> computeResult [
	^ self subclassResponsibility
]

{ #category : #initialization }
FQAbstractQueryWrapper >> initialize [
	super initialize.
	children := OrderedCollection new
]

{ #category : #accessing }
FQAbstractQueryWrapper >> label [
	^ label ifNil: [ label := query printString ]
]

{ #category : #accessing }
FQAbstractQueryWrapper >> label: aString [
	label := aString
]

{ #category : #removing }
FQAbstractQueryWrapper >> prepareRemoval [
	self subclassResponsibility
]

{ #category : #accessing }
FQAbstractQueryWrapper >> query [
	^ query
]

{ #category : #accessing }
FQAbstractQueryWrapper >> query: anObject [
	query := anObject
]

{ #category : #removing }
FQAbstractQueryWrapper >> removeChild: aQueryWrapper [
	children remove: aQueryWrapper
]

{ #category : #accessing }
FQAbstractQueryWrapper >> result [
	^ result ifNil: [ self computeResult ]
]

{ #category : #accessing }
FQAbstractQueryWrapper >> result: anObject [
	result := anObject
]
