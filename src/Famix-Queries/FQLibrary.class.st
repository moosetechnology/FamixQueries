Class {
	#name : #FQLibrary,
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
FQLibrary class >> clear [
	<script>
	currentLibrary := nil
]

{ #category : #accessing }
FQLibrary class >> current [
	^ currentLibrary ifNil: [ currentLibrary := self new ]
]

{ #category : #executing }
FQLibrary class >> queryNamed: aName [
	^ self current createQueryNamed: aName
]

{ #category : #adding }
FQLibrary >> addNewQuery: aQuery [
	registry at: aQuery name put: aQuery copy reset
]

{ #category : #adding }
FQLibrary >> createQueryNamed: aQueryName [
	^ (registry at: aQueryName ifAbsent: [ nil ]) copy
]

{ #category : #initialization }
FQLibrary >> initialize [
	super initialize.
	registry := Dictionary new.
	self setDefaultQueries
]

{ #category : #accessing }
FQLibrary >> registryAt: aName [
	^ registry at: aName ifAbsent: [  ]
]

{ #category : #initialization }
FQLibrary >> resetRegistry [
	registry := Dictionary new.
	self setDefaultQueries
]

{ #category : #accessing }
FQLibrary >> savedQueriesNames [
	^ registry keys
]

{ #category : #initialization }
FQLibrary >> setDefaultQueries [
	| name |
	name := 'Classes with >50 methods'.
	registry
		at: name
		put:
			((FQComposedQuery
				queries:
					(FQTypeQuery types: {FamixTClass})
						-->
							(FQNumericQuery
								property: #numberOfMethods
								comparator: #>
								valueToCompare: 50)) name: name)
]
