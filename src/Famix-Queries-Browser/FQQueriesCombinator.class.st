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
