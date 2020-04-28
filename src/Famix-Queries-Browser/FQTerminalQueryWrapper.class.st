"
I represent a query and am used by a FQQueriesCombinator.

I hold the query I represent, its parent, its optional children and its result if it was computed.

My parents and children are query wrappers.
My result is computed on my parent result.

The final parent is special: it does not hold a query but only a result, which is the intial MooseGroup that was given as input.
"
Class {
	#name : #FQTerminalQueryWrapper,
	#superclass : #FQAbstractQueryWrapper,
	#instVars : [
		'parent'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQTerminalQueryWrapper >> parent [
	^ parent
]

{ #category : #accessing }
FQTerminalQueryWrapper >> parent: anObject [
	parent := anObject
]
