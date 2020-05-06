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

{ #category : #initialization }
FQStringPropertyQueryBuilder >> initializeQueryFromParent: aQuery [
	super initializeQueryFromParent: aQuery.
	query comparator: self availableComparators first
]
