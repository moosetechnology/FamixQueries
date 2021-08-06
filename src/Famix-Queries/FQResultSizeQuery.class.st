"
`FQResultSizeQuery` receives a query and compares its entity types with a comparator and a valueToCompare. For example:
```
FQResultSizeQuery
	innerQuery: aBooleanQuery
	comparator: #>
	valueToCompare: 100
```
This will compare that all the entity types size of `aBooleanQuery` are greater than 100.

_Note: Like in `FQComplementQuery` we have the same problem for the `parent` instance variable. As this query inherits from `FQUnaryQuery` it has the `parent` instance variable. But it makes no sence that this query has a parent. Only a inner query that is used for the computations. This query does not use the parent instance variable for any of the computations. This is a bad design, we know. It will be fixed in the future._
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

{ #category : #'instance creation' }
FQResultSizeQuery class >> innerQuery: aQuery comparator: aComparingSymbol valueToCompare: aNumber [
	^ self new
		innerQuery: aQuery;
		comparator: aComparingSymbol;
		valueToCompare: aNumber;
		yourself
]

{ #category : #accessing }
FQResultSizeQuery class >> label [
	^ 'Result Size Query'
]

{ #category : #default }
FQResultSizeQuery >> beDefaultForParent [

	self innerQuery: (FQRootQuery new result: parent result).
	self comparator: #>.
	self valueToCompare: 0
]

{ #category : #accessing }
FQResultSizeQuery >> comparator [
	^ comparator
]

{ #category : #accessing }
FQResultSizeQuery >> comparator: anObject [
	comparator := anObject
]

{ #category : #running }
FQResultSizeQuery >> computeResult [

	self isValid ifFalse: [ ^ MooseGroup new ].

	^ self runOn: innerQuery result
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
	^ (innerQuery hasSameParametersAs: aQuery innerQuery)
		and: [ comparator = aQuery comparator
				and: valueToCompare = aQuery valueToCompare ]
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

	^ (innerQuery class inheritsFrom: FQAbstractQuery) and: [ 
		  innerQuery isValid and: [ 
			   comparator isSymbol and: [  valueToCompare isNumber ] ] ]
]

{ #category : #running }
FQResultSizeQuery >> runOn: aMooseGroup [

	| groups selectedGroups |
	"^ aMooseGroup select: [ :entity | 
		  (innerQuery runOn: entity asMooseGroup) size
			  perform: self comparator
			  with: self valueToCompare ]"
	groups := (aMooseGroup allEntityTypes collect: [ :type | 
		           aMooseGroup allWithType: type ]) asOrderedCollection.
	selectedGroups := groups select: [ :each | 
		                  each size perform: comparator with: valueToCompare ].
	^ (selectedGroups flatCollect: [ :each | each ]) asMooseGroup
]

{ #category : #printing }
FQResultSizeQuery >> storeOn: aStream [

	aStream << self className << ' innerQuery: ('.
	innerQuery storeOn: aStream.
	aStream << ') comparator: '.
	 comparator storeOn: aStream.
	aStream
		<< ' valueToCompare: ';
		<<  valueToCompare asString
]

{ #category : #accessing }
FQResultSizeQuery >> valueToCompare [
	^ valueToCompare
]

{ #category : #accessing }
FQResultSizeQuery >> valueToCompare: anObject [
	valueToCompare := anObject
]
