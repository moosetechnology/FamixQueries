Class {
	#name : #FQQueriesLibraryTest,
	#superclass : #TestCase,
	#instVars : [
		'library',
		'helper'
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
				valueToCompare: 20;
				beChildOf: (FQTypeQuery new type: FamixTClass);
				parentSequence);
		name: 'God classes'
]

{ #category : #running }
FQQueriesLibraryTest >> setUp [
	super setUp.
	library := FQLibrary new.
	helper := FQTestsHelper current
]

{ #category : #tests }
FQQueriesLibraryTest >> testAddNewQuery [
	library addNewQuery: self godClassesQuery.
	self
		assert:
			((library registryAt: 'God classes')
				hasSameParametersAs: self godClassesQuery)
]

{ #category : #tests }
FQQueriesLibraryTest >> testAddedQueryIsCopiedAndReset [
	| queryToAdd queryInRegistry |
	queryToAdd := self godClassesQuery
		beChildOf: (FQRootQuery new result: helper classesAndMethods).
	(FQScopeQuery up scope: FamixStPackage) beChildOf: queryToAdd.

	"Add"
	library addNewQuery: queryToAdd.
	queryInRegistry := library registryAt: queryToAdd name.

	"Saved query is a copy"
	self deny: queryInRegistry identicalTo: queryToAdd.

	"Queries inside composed query are copies"
	queryToAdd queries
		with: queryInRegistry queries
		do: [ :original :copy | self deny: original identicalTo: copy ].

	"Saved query was reset"
	self assert: queryInRegistry parent isNil.
	self assert: queryInRegistry children isEmpty.
	self should: [ queryInRegistry result ] raise: MessageNotUnderstood
]

{ #category : #tests }
FQQueriesLibraryTest >> testCreateQueryNamed [
	library addNewQuery: self godClassesQuery.
	self
		assert:
			((library createQueryNamed: 'God classes')
				hasSameParametersAs: self godClassesQuery)
]
