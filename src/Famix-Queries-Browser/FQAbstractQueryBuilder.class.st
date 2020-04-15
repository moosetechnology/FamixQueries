Class {
	#name : #FQAbstractQueryBuilder,
	#superclass : #Object,
	#instVars : [
		'query',
		'entities'
	],
	#category : #'Famix-Queries-Browser-Builder'
}

{ #category : #'plugin interface' }
FQAbstractQueryBuilder class >> newWithEntities: entities [
	^ self basicNew
		entities: entities;
		initialize;
		yourself
]

{ #category : #accessing }
FQAbstractQueryBuilder class >> queryClass [
	^ self subclassResponsibility
]

{ #category : #update }
FQAbstractQueryBuilder >> applyQuery [
	^ query runOn: entities
]

{ #category : #transmissions }
FQAbstractQueryBuilder >> codeToDisplay [
	^ self queryIsValid
		ifTrue: [ EFFormatter
				format:
					(RBParser
						parseExpression: (String streamContents: [ :s | query storeOn: s ])) ]
		ifFalse: [ 'No valid query possible' ]
]

{ #category : #accessing }
FQAbstractQueryBuilder >> entities [
	^ entities
]

{ #category : #accessing }
FQAbstractQueryBuilder >> entities: anObject [
	entities := anObject
]

{ #category : #initialization }
FQAbstractQueryBuilder >> initialize [
	super initialize.
	self initializeQuery
]

{ #category : #update }
FQAbstractQueryBuilder >> initializeQuery [
	query := self class queryClass new
]

{ #category : #accessing }
FQAbstractQueryBuilder >> query [
	^ query
]

{ #category : #accessing }
FQAbstractQueryBuilder >> query: anObject [
	query := anObject
]

{ #category : #testing }
FQAbstractQueryBuilder >> queryIsValid [
	^ query isValid
]

{ #category : #update }
FQAbstractQueryBuilder >> updateForQueryCode: aString [
	| newQuery |
	self flag: 'Todo : modify current query and adapt presenter'.
	newQuery := Smalltalk compiler evaluate: aString.	"self queryClass readFrom: aString"
	newQuery inspect
]
