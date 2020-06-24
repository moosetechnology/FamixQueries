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
		'name',
		'result',
		'children'
	],
	#category : #'Famix-Queries-Core'
}

{ #category : #accessing }
FQAbstractQuery class >> label [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
FQAbstractQuery class >> readFrom: aString [
	^ self compiler evaluate: aString
]

{ #category : #composition }
FQAbstractQuery >> & anotherQuery [
	^ self intersection: anotherQuery
]

{ #category : #composition }
FQAbstractQuery >> --> aChildQuery [
	^ aChildQuery
		beChildOf: self;
		yourself
]

{ #category : #composition }
FQAbstractQuery >> \ anotherQuery [
	^ self substration: anotherQuery
]

{ #category : #adding }
FQAbstractQuery >> addChild: aQuery [
	children add: aQuery
]

{ #category : #adding }
FQAbstractQuery >> addToParentsSequence: sequence [
	self subclassResponsibility
]

{ #category : #adding }
FQAbstractQuery >> beChildOf: aQueryOrCollection [
	self subclassResponsibility
]

{ #category : #printing }
FQAbstractQuery >> buildDefaultName [
	self isValid
		ifFalse: [ ^ self invalidDefaultName ].
	^ self defaultName
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
FQAbstractQuery >> defaultName [
	^ self subclassResponsibility
]

{ #category : #printing }
FQAbstractQuery >> displayOn: aStream [
	^ self subclassResponsibility
]

{ #category : #testing }
FQAbstractQuery >> hasNoParent [
	^ self subclassResponsibility
]

{ #category : #comparing }
FQAbstractQuery >> hasSameParentsAs: aQuery [
	^ self subclassResponsibility
]

{ #category : #initialization }
FQAbstractQuery >> initialize [
	super initialize.
	children := Set new
]

{ #category : #composition }
FQAbstractQuery >> intersection: anotherQuery [
	^ FQIntersectionQuery new
		beChildOf:
			{self.
			anotherQuery}
]

{ #category : #printing }
FQAbstractQuery >> invalidDefaultName [
	^ 'Invalid ' , self class label
]

{ #category : #testing }
FQAbstractQuery >> isRootQuery [
	^ false
]

{ #category : #testing }
FQAbstractQuery >> isValid [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQAbstractQuery >> name [
	^ name ifNil: [ self buildDefaultName ]
]

{ #category : #accessing }
FQAbstractQuery >> name: aString [
	name := aString
]

{ #category : #accessing }
FQAbstractQuery >> parentSequence [
	| sequence |
	sequence := OrderedCollection new.
	self addToParentsSequence: sequence.
	^ sequence
]

{ #category : #removing }
FQAbstractQuery >> prepareRemoval [
	^ self subclassResponsibility
]

{ #category : #printing }
FQAbstractQuery >> printOn: aStream [
	super printOn: aStream.
	self isValid
		ifFalse: [ aStream << ' (invalid)'.
			^ self ].
	aStream << Character space << (self name join: '()')
]

{ #category : #removing }
FQAbstractQuery >> removeChild: aQuery [
	children remove: aQuery
]

{ #category : #replacing }
FQAbstractQuery >> replace: anotherQuery [
	self flag: #FQTest.
	self subclassResponsibility
]

{ #category : #replacing }
FQAbstractQuery >> replaceParent: aParentQuery with: anotherQuery [
	self flag: #FQTest.
	self subclassResponsibility
]

{ #category : #reset }
FQAbstractQuery >> reset [
	self
		resetParents;
		resetResult.
	self resetChildren
]

{ #category : #reset }
FQAbstractQuery >> resetChildren [
	children := Set new
]

{ #category : #reset }
FQAbstractQuery >> resetParents [
	self subclassResponsibility
]

{ #category : #reset }
FQAbstractQuery >> resetResult [
	result := nil.
	self children do: [ :child | child resetResult ]
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

{ #category : #printing }
FQAbstractQuery >> storeOn: aStream [
	^ self subclassResponsibility
]

{ #category : #printing }
FQAbstractQuery >> storeOn: aStream withParentsIn: queries [
	self subclassResponsibility
]

{ #category : #composition }
FQAbstractQuery >> substration: anotherQuery [
	^ FQSubstractionQuery new
		beChildOf:
			{self.
			anotherQuery}
]

{ #category : #composition }
FQAbstractQuery >> union: anotherQuery [
	^ FQUnionQuery new
		beChildOf:
			{self.
			anotherQuery}
]

{ #category : #composition }
FQAbstractQuery >> | anotherQuery [
	^ self union: anotherQuery
]
