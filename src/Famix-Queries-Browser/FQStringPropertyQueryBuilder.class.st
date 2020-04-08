Class {
	#name : #FQStringPropertyQueryBuilder,
	#superclass : #FQAbstractPropertyQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #running }
FQStringPropertyQueryBuilder >> initializeQuery [
	super initializeQuery.
	query comparator: self availableComparators first
]

{ #category : #accessing }
FQStringPropertyQueryBuilder >> queryClass [
	^ FQStringQuery
]
