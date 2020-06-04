Class {
	#name : #FQQueriesLibraryTest,
	#superclass : #TestCase,
	#instVars : [
		'library'
	],
	#category : #'Famix-Queries-Tests-Library'
}

{ #category : #tests }
FQQueriesLibraryTest >> godClassesQuery [
	^ FQComposedQuery new
		queries:
			(FQNumericQuery new
				property: #numberOfMethods;
				comparator: #>;
				valueToCompare: 50;
				beChildOf: (FQTypeQuery new type: FamixTClass);
				parentSequence);
		name: 'God classes'
]

{ #category : #running }
FQQueriesLibraryTest >> setUp [
	super setUp.
	library := FQQueriesLibrary new
]

{ #category : #tests }
FQQueriesLibraryTest >> testAddNewQuery [
	library addNewQuery: self godClassesQuery.
	self
		assert: (library registry at: 'God classes')
		equals:
			(String
				streamContents: [ :aStream | self godClassesQuery storeOn: aStream ]).
]

{ #category : #tests }
FQQueriesLibraryTest >> testCreateQueryNamed [
	library addNewQuery: self godClassesQuery.
	self
		assert: (library createQueryNamed: 'God classes')
		equals: self godClassesQuery
]
