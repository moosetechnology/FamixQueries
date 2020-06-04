Class {
	#name : #FQQueriesLibrary,
	#superclass : #Object,
	#instVars : [
		'registry'
	],
	#classInstVars : [
		'currentLibrary'
	],
	#category : #'Famix-Queries-Library'
}

{ #category : #accessing }
FQQueriesLibrary class >> current [
	^ currentLibrary ifNil: [ currentLibrary := self new ]
]

{ #category : #adding }
FQQueriesLibrary >> addNewQuery: aQuery [
	registry
		at: aQuery name
		put: (String streamContents: [ :aStream | aQuery storeOn: aStream ])
]

{ #category : #adding }
FQQueriesLibrary >> createQueryNamed: aQueryName [
	| queryScript |
	queryScript := registry at: aQueryName ifAbsent: [ ^ nil ].
	aQueryName.
	^ (FQAbstractQuery readFrom: queryScript) name: aQueryName
]

{ #category : #initialization }
FQQueriesLibrary >> initialize [
	super initialize.
	registry := Dictionary new.
	self setDefaultQueries
]

{ #category : #initialization }
FQQueriesLibrary >> resetRegistry [
	registry := Dictionary new.
	self setDefaultQueries
]

{ #category : #accessing }
FQQueriesLibrary >> savedQueriesNames [
	^ registry keys
]

{ #category : #initialization }
FQQueriesLibrary >> setDefaultQueries [
	registry
		at: 'God classes'
		put:
			'FQComposedQuery new queries: (FQNumericQuery new property: #numberOfMethods; comparator: #>; valueToCompare: 50; beChildOf: (FQTypeQuery new type: FamixTClass)) parentSequence'
]
