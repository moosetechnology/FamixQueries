Class {
	#name : #FQStringPropertyQueryBuilder,
	#superclass : #FQAbstractPropertyQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQStringPropertyQueryBuilder class >> queryClass [
	^ FQStringQuery
]

{ #category : #running }
FQStringPropertyQueryBuilder >> initializeQuery [
	super initializeQuery.
	query comparator: self availableComparators first
]
