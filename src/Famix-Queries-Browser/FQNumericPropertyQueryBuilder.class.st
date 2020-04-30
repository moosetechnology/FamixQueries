Class {
	#name : #FQNumericPropertyQueryBuilder,
	#superclass : #FQAbstractPropertyQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQNumericPropertyQueryBuilder class >> queryClass [
	^ FQNumericQuery
]

{ #category : #initialization }
FQNumericPropertyQueryBuilder >> initializeQuery [
	super initializeQuery.
	query comparator: self availableComparators first
]
