Class {
	#name : #FQStringPropertyQueryBuilder,
	#superclass : #FQAbstractPropertyQueryBuilder,
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #accessing }
FQStringPropertyQueryBuilder class >> queryClass [
	^ FQStringQuery
]

{ #category : #initialization }
FQStringPropertyQueryBuilder >> initializeQuery [
	super initializeQuery.
	query comparator: self availableComparators first
]
