Class {
	#name : #FQTypeQueryBuilder,
	#superclass : #FQAbstractQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #'changing parameters' }
FQTypeQueryBuilder >> addTypeToQuery: aType [
	query addType: aType
]

{ #category : #'available parameters' }
FQTypeQueryBuilder >> availableTypes [
	^ query availableTypesFor: entities
]

{ #category : #accessing }
FQTypeQueryBuilder >> currentQueryTypes [
	^ query types
]

{ #category : #accessing }
FQTypeQueryBuilder >> queryClass [
	^ FQTypeQuery
]

{ #category : #'changing parameters' }
FQTypeQueryBuilder >> removeTypeFromQuery: aType [
	query removeType: aType
]
