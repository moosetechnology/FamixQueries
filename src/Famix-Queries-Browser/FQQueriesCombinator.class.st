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

	queryWrapper := FQTerminalQueryWrapper new query: aQuery.
	
	queryWrapper parent: anExistingQueryWrapper.
	anExistingQueryWrapper addChild: queryWrapper.
	
	^ queries addLast: queryWrapper.
	
]

{ #category : #adding }
FQQueriesCombinator >> addQueryOnInitialEntities: aQuery [
	^ queries
		addLast:
			(FQTerminalQueryWrapper new
				parent: queries first;
				query: aQuery)
]

{ #category : #adding }
FQQueriesCombinator >> addUnionQueryBetween: firstParent and: secondParent [
	| queryWrapper parents |
	parents := {firstParent.
	secondParent}.
	(queries includesAll: parents)
		ifFalse: [ FQUnknownPrecedingQuery signal ].
	queryWrapper := FQCombinatorQueryWrapper new
		query: (FQUnionQuery forQueries: parents);
		label: 'Union'.
	queryWrapper parents: parents.
	parents do: [ :parent | parent addChild: queryWrapper ].
	^ queries addLast: queryWrapper
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
			(FQTerminalQueryWrapper new
				result: aMooseGroup;
				label: 'Initial Entities';
				color: (Color colorFrom: 'DDDDDD');
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
FQQueriesCombinator >> removeQuery: aQueryWrapper [
	aQueryWrapper children
		ifNotEmpty: [ UIManager default
				alert: 'Cannot remove a query with children for now'.
			^ self ].
	aQueryWrapper prepareRemoval.
	queries remove: aQueryWrapper.
	^ aQueryWrapper
]

{ #category : #accessing }
FQQueriesCombinator >> resultOfQuery: aQueryWrapper [
	^ aQueryWrapper result ifNil: [ self computeResultOf: aQueryWrapper ]
]
