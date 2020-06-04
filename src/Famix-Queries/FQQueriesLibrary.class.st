Class {
	#name : #FQQueriesLibrary,
	#superclass : #Object,
	#instVars : [
		'registry'
	],
	#category : #'Famix-Queries-Library'
}

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
	registry := Dictionary new
]
