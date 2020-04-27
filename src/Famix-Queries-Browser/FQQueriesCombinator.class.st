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
FQQueriesCombinator >> addQuery: aQuery after: anExistingQueryWrapper [
	| queryWrapper |

	(queries includes: anExistingQueryWrapper)
		ifFalse: [ FQUnknownPrecedingQuery signal ].

	queryWrapper := FQQueryWrapper new query: aQuery.
	
	queryWrapper parent: anExistingQueryWrapper.
	anExistingQueryWrapper addChild: queryWrapper.
	
	^ queries addLast: queryWrapper.
	
]

{ #category : #adding }
FQQueriesCombinator >> addQueryOnInitialEntities: aQuery [
	^ queries
		addLast:
			(FQQueryWrapper new
				parent: queries first;
				query: aQuery)
]

{ #category : #private }
FQQueriesCombinator >> computeResultOf: aQueryWrapper [
	aQueryWrapper
		result:
			(aQueryWrapper query runOn: (self resultOfQuery: aQueryWrapper parent)).
	^ aQueryWrapper result
]

{ #category : #accessing }
FQQueriesCombinator >> initialEntities [
	^ queries first result
]

{ #category : #accessing }
FQQueriesCombinator >> initialEntities: aMooseGroup [
	queries
		addFirst:
			(FQQueryWrapper new
				result: aMooseGroup;
				label: 'Initial Entities';
				yourself)
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

{ #category : #accessing }
FQQueriesCombinator >> resultOfQuery: aQueryWrapper [
	^ aQueryWrapper result ifNil: [ self computeResultOf: aQueryWrapper ]
]
