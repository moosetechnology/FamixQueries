Class {
	#name : #FQQueriesCombinator,
	#superclass : #Object,
	#instVars : [
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
FQQueriesCombinator >> addQuery: newQuery after: anExistingQuery [
	(queries includes: anExistingQuery)
		ifFalse: [ FQUnknownPrecedingQuery signal ].
	
	newQuery parent: anExistingQuery.
	anExistingQuery addChild: newQuery.
	
	^ queries addLast: newQuery.
	
]

{ #category : #adding }
FQQueriesCombinator >> addUnionQueryBetween: firstParent and: secondParent [
	| newQuery parents |
	parents := {firstParent.
	secondParent}.
	
	(queries includesAll: parents)
		ifFalse: [ FQUnknownPrecedingQuery signal ].
	
	newQuery := FQUnionQuery forQueries: parents.
	
	newQuery parents: parents.
	
	parents do: [ :parent | parent addChild: newQuery ].
	^ queries addLast: newQuery
]

{ #category : #accessing }
FQQueriesCombinator >> initialEntities [
	^ self initialQuery result
]

{ #category : #accessing }
FQQueriesCombinator >> initialEntities: aMooseGroup [
	queries
		addFirst:
			(FQMockQuery new
				result: aMooseGroup;
				yourself)
]

{ #category : #accessing }
FQQueriesCombinator >> initialQuery [
	^ queries detect: [ :wrapper | wrapper parent isNil ]
]

{ #category : #initialization }
FQQueriesCombinator >> initialize [
	super initialize.
	queries := OrderedCollection new
]

{ #category : #accessing }
FQQueriesCombinator >> queries [
	^ queries
]

{ #category : #removing }
FQQueriesCombinator >> removeQuery: aQuery [
	aQuery children
		ifNotEmpty: [ UIManager default
				alert: 'Cannot remove a query with children for now'.
			^ self ].
	aQuery prepareRemoval.
	queries remove: aQuery.
	^ aQuery
]

{ #category : #accessing }
FQQueriesCombinator >> resultOfQuery: aQueryWrapper [
	^ aQueryWrapper result
]
