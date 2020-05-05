"
I am the model used by a FQQueryConfigurationPresenter.
I build terminal queries (See FQAbstractQuery).

- I provide information on the available parameters to build a query, depending on an input MooseGroup.
- I build a query and gives the presenter the information it needs about it.
- I can apply the query on an input MooseGroup and give the resulting MooseGroup.

See my subclasses for specialized behavior depending on the type of query they build.
"
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
	self flag: #FQImprove , 'Maybe use a cache ?'.
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
	self
		flag: #FQImprove , 'Todo : modify current query and adapt presenter'.
	newQuery := Smalltalk compiler evaluate: aString.	"self queryClass readFrom: aString"
	newQuery inspect
]
