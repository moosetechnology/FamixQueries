Class {
	#name : #FQTypeQueryBuilder,
	#superclass : #FQAbstractQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQTypeQueryBuilder class >> queryClass [
	^ FQTypeQuery
]

{ #category : #'changing parameters' }
FQTypeQueryBuilder >> addTypeToQuery: aType [
	query addType: aType.
	self resetResult
]

{ #category : #'available parameters' }
FQTypeQueryBuilder >> availableTypes [
	^ query availableTypesFor: self entities
]

{ #category : #accessing }
FQTypeQueryBuilder >> currentQueryTypes [
	^ query types
]

{ #category : #initialization }
FQTypeQueryBuilder >> initializeQuery [
	super initializeQuery.
	self availableTypes
		ifEmpty: [ (FQImpossibleQuery new builder: self) signal ].
	query types: self availableTypes
]

{ #category : #initialization }
FQTypeQueryBuilder >> initializeQueryFromParent: aQuery [
	super initializeQueryFromParent: aQuery.
	self availableTypes
		ifEmpty: [ (FQImpossibleQuery new builder: self) signal ].
	query types: self availableTypes
]

{ #category : #'changing parameters' }
FQTypeQueryBuilder >> removeTypeFromQuery: aType [
	query removeType: aType.
	self resetResult
]
