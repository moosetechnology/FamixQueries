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
	^ query availablePropertiesFor: entities
]

{ #category : #'available parameters' }
FQAbstractPropertyQueryBuilder >> availablePropertyTypes [
	^ self class queryClass availablePropertyTypes
]

{ #category : #'changing parameters' }
FQAbstractPropertyQueryBuilder >> changeQueryComparator: aComparator [
	^ query comparator: aComparator
]

{ #category : #'changing parameters' }
FQAbstractPropertyQueryBuilder >> changeQueryProperty: aPropertyName [
	^ query property: aPropertyName
]

{ #category : #'changing parameters' }
FQAbstractPropertyQueryBuilder >> changeQueryValueToCompare: aValue [
	^ query valueToCompare: aValue
]

{ #category : #running }
FQAbstractPropertyQueryBuilder >> initializeQuery [
	super initializeQuery.
	self availableProperties
		ifEmpty: [ (ImpossibleQuery new builder: self) signal ].
	query property: self availableProperties first
]
