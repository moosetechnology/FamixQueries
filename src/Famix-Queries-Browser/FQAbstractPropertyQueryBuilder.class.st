Class {
	#name : #FQAbstractPropertyQueryBuilder,
	#superclass : #FQAbstractQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQAbstractPropertyQueryBuilder class >> queryClass [
	^ FQPropertyQuery
]

{ #category : #'available parameters' }
FQAbstractPropertyQueryBuilder >> availableComparators [
	^ query availableComparators
]

{ #category : #'available parameters' }
FQAbstractPropertyQueryBuilder >> availableProperties [
	^ query availablePropertiesFor: self entities
]

{ #category : #'available parameters' }
FQAbstractPropertyQueryBuilder >> availablePropertyTypes [
	^ self class queryClass availablePropertyTypes
]

{ #category : #'changing parameters' }
FQAbstractPropertyQueryBuilder >> changeQueryComparator: aComparator [
	query comparator: aComparator.
	self resetResult
]

{ #category : #'changing parameters' }
FQAbstractPropertyQueryBuilder >> changeQueryProperty: aPropertyName [
	query property: aPropertyName.
	self resetResult
]

{ #category : #'changing parameters' }
FQAbstractPropertyQueryBuilder >> changeQueryValueToCompare: aValue [
	query valueToCompare: aValue.
	self resetResult
]

{ #category : #initialization }
FQAbstractPropertyQueryBuilder >> initializeQueryFromParent: aQuery [
	super initializeQueryFromParent: aQuery.
	self availableProperties
		ifEmpty: [ (FQImpossibleQuery new builder: self) signal ].
	query property: self availableProperties first
]
