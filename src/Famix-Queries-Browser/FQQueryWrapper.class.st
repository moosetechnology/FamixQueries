Class {
	#name : #FQQueryWrapper,
	#superclass : #Object,
	#instVars : [
		'query',
		'parent',
		'children',
		'result',
		'label'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #adding }
FQQueryWrapper >> addChild: aQueryWrapper [
	children add: aQueryWrapper
]

{ #category : #accessing }
FQQueryWrapper >> children [
	^ children
]

{ #category : #initialization }
FQQueryWrapper >> initialize [
	super initialize.
	children := OrderedCollection new.
]

{ #category : #accessing }
FQQueryWrapper >> label [
	^ label ifNil: [ label := query class label ]
]

{ #category : #accessing }
FQQueryWrapper >> label: aString [
	label := aString
]

{ #category : #accessing }
FQQueryWrapper >> parent [
	^ parent
]

{ #category : #accessing }
FQQueryWrapper >> parent: anObject [
	parent := anObject
]

{ #category : #accessing }
FQQueryWrapper >> query [
	^ query
]

{ #category : #accessing }
FQQueryWrapper >> query: anObject [
	query := anObject
]

{ #category : #accessing }
FQQueryWrapper >> result [
	^ result
]

{ #category : #accessing }
FQQueryWrapper >> result: anObject [
	result := anObject
]
