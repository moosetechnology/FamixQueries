"
The query is instantiated on a parentQuery. Then, it receives an innerQuery. The inner query can only be a `FQNavigationQuery` or `FQScopeQuery`. Also a comparator, that can be: <, >, <=, >=, =. And finally a number to compare.

Then, for each of the results of the parent query, it runs the inner query. That produces a collection, then compares the size of the collection with the comparator and the value. See `FQResultSizeQuery>>#runOn:`
"
Class {
	#name : #FQResultSizeQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'innerQuery',
		'comparator',
		'valueToCompare'
	],
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #'as yet unclassified' }
FQResultSizeQuery class >> innerQuery: aQuery comparator: aComparingSymbol valueToCompare: aNumber [
	^ self new
		innerQuery: aQuery;
		comparator: aComparingSymbol;
		valueToCompare: aNumber;
		yourself
]

{ #category : #testing }
FQResultSizeQuery class >> isAvailableForQueriesSize: numberOfQueriesInPresenter [

	^ numberOfQueriesInPresenter > 0
]

{ #category : #accessing }
FQResultSizeQuery class >> label [
	^ 'Result Size Query'
]

{ #category : #default }
FQResultSizeQuery >> beDefaultForParent [

	innerQuery := FQRootQuery new result: parent result.
	comparator := #>.
	valueToCompare := 0
]

{ #category : #accessing }
FQResultSizeQuery >> comparator [
	^ comparator
]

{ #category : #accessing }
FQResultSizeQuery >> comparator: anObject [
	comparator := anObject
]

{ #category : #printing }
FQResultSizeQuery >> defaultName [

	^ '(' , innerQuery name , ') size ' , comparator asString , ' '
	  , valueToCompare asString
]

{ #category : #printing }
FQResultSizeQuery >> displayOn: aStream with: aString [

	aStream << aString << ' select: [ :entity | ('.
	innerQuery displayOn: aStream with: 'entity asMooseGroup'.
	aStream
		<< ') size ';
		<< comparator asString;
		space;
		<< valueToCompare asString;
		<< ' ]'
]

{ #category : #comparing }
FQResultSizeQuery >> hasSameParametersAs: aQuery [

	^ (innerQuery hasSameParametersAs: aQuery innerQuery) and: [ 
		  comparator = aQuery comparator and:
			  valueToCompare = aQuery valueToCompare ]
]

{ #category : #accessing }
FQResultSizeQuery >> innerQuery [

	^ innerQuery
]

{ #category : #accessing }
FQResultSizeQuery >> innerQuery: anObject [

	innerQuery := anObject
]

{ #category : #testing }
FQResultSizeQuery >> isValid [

	^ (innerQuery isKindOf: FQAbstractQuery) and: [ 
		  innerQuery isValid and: [ 
			  comparator isSymbol and: [ valueToCompare isNumber ] ] ]
]

{ #category : #running }
FQResultSizeQuery >> runOn: aMooseGroup [

	^ aMooseGroup select: [ :entity | 
		  (innerQuery runOn: entity asMooseGroup) size
			  perform: comparator
			  with: valueToCompare ]
]

{ #category : #printing }
FQResultSizeQuery >> storeOn: aStream [

	aStream << self className << ' innerQuery: ('.
	innerQuery storeOn: aStream.
	aStream << ') comparator: '.
	comparator storeOn: aStream.
	aStream
		<< ' valueToCompare: ';
		<< valueToCompare asString
]

{ #category : #accessing }
FQResultSizeQuery >> valueToCompare [
	^ valueToCompare
]

{ #category : #accessing }
FQResultSizeQuery >> valueToCompare: anObject [
	valueToCompare := anObject
]
