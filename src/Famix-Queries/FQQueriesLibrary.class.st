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
FQQueriesLibrary class >> clear [
	<script>
	currentLibrary := nil
]

{ #category : #accessing }
FQQueriesLibrary class >> current [
	^ currentLibrary ifNil: [ currentLibrary := self new ]
]

{ #category : #adding }
FQQueriesLibrary >> addNewQuery: aQuery [
	registry at: aQuery name put: aQuery copy reset
]

{ #category : #adding }
FQQueriesLibrary >> createQueryNamed: aQueryName [
	^ (registry at: aQueryName ifAbsent: [ nil ]) copy
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
		at: 'Classes with >50 methods'
		put:
			(FQComposedQuery
				queries:
					(FQTypeQuery types: {FamixTClass})
						-->
							(FQNumericQuery
								property: #numberOfMethods
								comparator: #>
								valueToCompare: 50))
]
