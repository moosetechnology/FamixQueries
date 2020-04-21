Class {
	#name : #FQQueriesCombinator,
	#superclass : #Object,
	#instVars : [
		'initialEntities',
		'queries'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #'instance creation' }
FQQueriesCombinator class >> newWithEntities: entities [
	^ self new
		initialEntities: entities;
		yourself
]

{ #category : #adding }
FQQueriesCombinator >> addQueryToSequence: aQuery [
	| newQuery |
	newQuery := queries
		ifEmpty: [ self flag: 'Better way to do this ?'.
			aQuery ]
		ifNotEmpty: [ FQSequenceQuery
				forQueries:
					{queries last.
					aQuery} ].
	queries addLast: newQuery.
	^ newQuery
]

{ #category : #accessing }
FQQueriesCombinator >> currentResult [
	self flag: 'Improvement needed'.
	^ queries
		ifEmpty: [ initialEntities ]
		ifNotEmpty: [ queries last runOn: initialEntities ]
]

{ #category : #accessing }
FQQueriesCombinator >> initialEntities [
	^ initialEntities
]

{ #category : #accessing }
FQQueriesCombinator >> initialEntities: anObject [
	initialEntities := anObject
]

{ #category : #initialization }
FQQueriesCombinator >> initialize [
	super initialize.
	initialEntities := MooseGroup new.
	queries := OrderedCollection new
]

{ #category : #accessing }
FQQueriesCombinator >> queries [
	^ queries
]

{ #category : #accessing }
FQQueriesCombinator >> resultOfQuery: aQuery [
	self flag: 'Cache ??'.
	^ aQuery runOn: initialEntities
]
