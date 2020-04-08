Class {
	#name : #FQNumericPropertyQueryBuilder,
	#superclass : #FQAbstractPropertyQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #running }
FQNumericPropertyQueryBuilder >> initializeQuery [
	super initializeQuery.
	query comparator: self availableComparators first
]

{ #category : #accessing }
FQNumericPropertyQueryBuilder >> queryClass [
	^ FQNumericQuery
]
