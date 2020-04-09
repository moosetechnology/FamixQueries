Class {
	#name : #FQNumericPropertyQueryBuilder,
	#superclass : #FQAbstractPropertyQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQNumericPropertyQueryBuilder class >> queryClass [
	^ FQNumericQuery
]

{ #category : #running }
FQNumericPropertyQueryBuilder >> initializeQuery [
	super initializeQuery.
	query comparator: self availableComparators first
]
