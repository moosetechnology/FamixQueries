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
	#category : #'Famix-Queries-Core'
}

{ #category : #testing }
FQAbstractQuery class >> isAbstract [
	^ self = FQAbstractQuery
]

{ #category : #'as yet unclassified' }
FQAbstractQuery class >> projectPrefix [
	^ 'FQ'
]

{ #category : #'instance creation' }
FQAbstractQuery class >> readFrom: aString [
	| script |
	script := 'FQ' , aString trim.
	^ self compiler evaluate: script
]

{ #category : #comparing }
FQAbstractQuery >> = aQuery [
	^ self subclassResponsibility
]

{ #category : #running }
FQAbstractQuery >> displayOn: aStream [ 
	self displayOn: aStream with: 'aMooseGroup' 
]

{ #category : #running }
FQAbstractQuery >> displayOn: aStream with: aString [
	^ self subclassResponsibility
]

{ #category : #testing }
FQAbstractQuery >> isValid [
	^ self subclassResponsibility
]

{ #category : #running }
FQAbstractQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ self subclassResponsibility
]

{ #category : #accessing }
FQAbstractQuery >> simpleClassName [
	^ self className withoutPrefix: self class projectPrefix
]
