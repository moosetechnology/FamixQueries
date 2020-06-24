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
		<< self comparator asString;
		space;
		<< self valueToCompare asString;
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
	^ (innerQuery isKindOf: FQAbstractQuery)
		and: [ innerQuery isValid
				and: [ self comparator isSymbol and: [ self valueToCompare isNumber ] ] ]
]

{ #category : #running }
FQResultSizeQuery >> runOn: aMooseGroup [
	^ aMooseGroup
		select: [ :entity | 
			(innerQuery runOn: entity asMooseGroup) size
				perform: self comparator
				with: self valueToCompare ]
]

{ #category : #printing }
FQResultSizeQuery >> storeOn: aStream [
	aStream << self className << ' innerQuery: ('.
	innerQuery storeOn: aStream.
	aStream << ') comparator: '.
	self comparator storeOn: aStream.
	aStream
		<< ' valueToCompare: ';
		<< self valueToCompare asString
]

{ #category : #accessing }
FQResultSizeQuery >> valueToCompare [
	^ valueToCompare
]

{ #category : #accessing }
FQResultSizeQuery >> valueToCompare: anObject [
	valueToCompare := anObject
]
