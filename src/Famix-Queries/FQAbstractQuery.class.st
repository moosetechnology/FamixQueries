"
I am a query that can be applied on a MooseGroup.

----- Query -----
I take a MooseGroup as input and apply a query on it.
The query can be 
	- a filter (TypeQuery and PropertyQuery)
	- a navigation (NavigationQuery and ScopeQuery)
	- a combination of 2 queries.
I return a new MooseGroup.
See subclasses for details.

----- API -----
- Running : My main responsibility.
	The #runOn: method takes a MooseGroup as argument. 
		It applies the query I represent on this group and returns a new MooseGroup with the result.

- Printing :
	- The #displayOn: method prints in Pharo code what the query is actually doing.
	- The #runOn: method prints Pharo code that creates the equivalent of self when evaluated.

----- Validity -----
I am valid if my parameters are set.
See subclasses.

----- Instance Creation -----
See subclasses
"
Class {
	#name : #FQAbstractQuery,
	#superclass : #Object,
	#instVars : [
		'result',
		'children'
	],
	#category : #'Famix-Queries-Core'
}

{ #category : #testing }
FQAbstractQuery class >> isAbstract [
	^ self = FQAbstractQuery
]

{ #category : #accessing }
FQAbstractQuery class >> projectPrefix [
	^ 'FQ'
]

{ #category : #'instance creation' }
FQAbstractQuery class >> readFrom: aString [
	^ self compiler evaluate: aString
]

{ #category : #comparing }
FQAbstractQuery >> = aQuery [
	^ self subclassResponsibility
]

{ #category : #adding }
FQAbstractQuery >> addChild: aQuery [
	children add: aQuery
]

{ #category : #accessing }
FQAbstractQuery >> children [
	^ children
]

{ #category : #running }
FQAbstractQuery >> computeResult [
	^ self subclassResponsibility
]

{ #category : #printing }
FQAbstractQuery >> displayOn: aStream [ 
	self displayOn: aStream with: 'aMooseGroup' 
]

{ #category : #printing }
FQAbstractQuery >> displayOn: aStream with: aString [
	^ self subclassResponsibility
]

{ #category : #initialization }
FQAbstractQuery >> initialize [
	super initialize.
	children := OrderedCollection new
]

{ #category : #testing }
FQAbstractQuery >> isValid [
	^ self subclassResponsibility
]

{ #category : #removing }
FQAbstractQuery >> prepareRemoval [
	^ self subclassResponsibility
]

{ #category : #removing }
FQAbstractQuery >> removeChild: aQuery [
	children remove: aQuery
]

{ #category : #initialization }
FQAbstractQuery >> resetResult [
	result := nil
]

{ #category : #running }
FQAbstractQuery >> result [
	^ result ifNil: [ result := self computeResult ]
]

{ #category : #running }
FQAbstractQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ self subclassResponsibility
]

{ #category : #accessing }
FQAbstractQuery >> simpleClassName [
	"This was used to remove the 'FQ' prefix in #storeOn: method.
	Problem is, by removing it, the System does not know those classes and cannot evaluate correctly the provided code"

	self flag: 'FQUnused'.
	^ self className withoutPrefix: self class projectPrefix
]
