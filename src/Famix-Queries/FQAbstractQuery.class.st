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
	#name : 'FQAbstractQuery',
	#superclass : 'Object',
	#instVars : [
		'name',
		'result',
		'children'
	],
	#category : 'Famix-Queries-Core',
	#package : 'Famix-Queries',
	#tag : 'Core'
}

{ #category : 'instance creation' }
FQAbstractQuery class >> defaultForParent: aQuery [

	^ self new
]

{ #category : 'testing' }
FQAbstractQuery class >> isUnaryQuery [
	^ false
]

{ #category : 'accessing' }
FQAbstractQuery class >> label [
	^ self subclassResponsibility
]

{ #category : 'instance creation' }
FQAbstractQuery class >> readFrom: aString [
	^ self compiler evaluate: aString
]

{ #category : 'composition' }
FQAbstractQuery >> & anotherQuery [
	^ self intersection: anotherQuery
]

{ #category : 'comparing' }
FQAbstractQuery >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ self name = anObject name and: [ self children = anObject children ]
]

{ #category : 'composition' }
FQAbstractQuery >> \ anotherQuery [

	^ self subtraction: anotherQuery
]

{ #category : 'adding' }
FQAbstractQuery >> addChild: aQuery [
	children add: aQuery
]

{ #category : 'printing' }
FQAbstractQuery >> buildDefaultName [
	self isValid
		ifFalse: [ ^ self invalidDefaultName ].
	^ self defaultName
]

{ #category : 'testing' }
FQAbstractQuery >> canBeNegated [
	^false
]

{ #category : 'accessing' }
FQAbstractQuery >> children [

	^ children
]

{ #category : 'running' }
FQAbstractQuery >> computeResult [
	^ self subclassResponsibility
]

{ #category : 'printing' }
FQAbstractQuery >> defaultName [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
FQAbstractQuery >> dependencies [

	"Queries by default don't have any dependency"

	^ #(  )
]

{ #category : 'printing' }
FQAbstractQuery >> displayOn: aStream [
	^ self subclassResponsibility
]

{ #category : 'execution' }
FQAbstractQuery >> executeOn: aMooseGroup [

	| root |

	root := FQRootQuery new input: aMooseGroup.
	self rootQuery: root.
	^ self result
]

{ #category : 'accessing' }
FQAbstractQuery >> hasSameParametersAs: aQuery [ 
	^ self subclassResponsibility
]

{ #category : 'comparing' }
FQAbstractQuery >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ name hash bitXor: children hash
]

{ #category : 'initialization' }
FQAbstractQuery >> initialize [

	super initialize.
	children := OrderedCollection new
]

{ #category : 'composition' }
FQAbstractQuery >> intersection: anotherQuery [

	^ FQIntersectionQuery new subqueries: { 
			  self.
			  anotherQuery }
]

{ #category : 'printing' }
FQAbstractQuery >> invalidDefaultName [
	^ 'Invalid ' , self class label
]

{ #category : 'testing' }
FQAbstractQuery >> isRootQuery [
	^ false
]

{ #category : 'testing' }
FQAbstractQuery >> isScriptQuery [

	^ false
]

{ #category : 'testing' }
FQAbstractQuery >> isUnaryQuery [
	^ false
]

{ #category : 'testing' }
FQAbstractQuery >> isValid [
	^ self subclassResponsibility
]

{ #category : 'accessing' }
FQAbstractQuery >> name [
	^ name ifNil: [ self buildDefaultName ]
]

{ #category : 'accessing' }
FQAbstractQuery >> name: aString [
	name := aString
]

{ #category : 'accessing' }
FQAbstractQuery >> parent [

	^ nil
]

{ #category : 'accessing' }
FQAbstractQuery >> parent: aQuery [

	"Do nothing"

	
]

{ #category : 'accessing' }
FQAbstractQuery >> parentSequence [

	self subclassResponsibility
]

{ #category : 'accessing' }
FQAbstractQuery >> parentSequenceWithoutRoot [

	^ OrderedCollection new
]

{ #category : 'removing' }
FQAbstractQuery >> prepareRemoval [
	^ self subclassResponsibility
]

{ #category : 'printing' }
FQAbstractQuery >> printOn: aStream [
	super printOn: aStream.
	self isValid
		ifFalse: [ aStream << ' (invalid)'.
			^ self ].
	aStream << Character space << (self name join: '()')
]

{ #category : 'running' }
FQAbstractQuery >> rawRunOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new collection with my result. This collection will then be casted as a MooseGroup by #runOn:"

	^ self subclassResponsibility
]

{ #category : 'running' }
FQAbstractQuery >> rawRunOnEntity: anEntity [
	"I am a hook to allow to run a query on only one entity. I'll by default cast it as a MooseGroup but some subclasses can override me in order to speed things up."

	^ self rawRunOn: anEntity asMooseGroup
]

{ #category : 'removing' }
FQAbstractQuery >> removeChild: aQuery [
	children remove: aQuery
]

{ #category : 'reset' }
FQAbstractQuery >> resetResult [
	result := nil.
	self children do: [ :child | child resetResult ]
]

{ #category : 'running' }
FQAbstractQuery >> result [

	result ifNil: [ result := self computeResult ].
	^ result
]

{ #category : 'execution' }
FQAbstractQuery >> rootQuery: aFQRootQuery [

	self subclassResponsibility
]

{ #category : 'running' }
FQAbstractQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ (self rawRunOn: aMooseGroup) asMooseGroup
]

{ #category : 'printing' }
FQAbstractQuery >> storeOn: aStream [
	^ self subclassResponsibility
]

{ #category : 'printing' }
FQAbstractQuery >> storeWithParentsOn: aStream [

	self subclassResponsibility
]

{ #category : 'composition' }
FQAbstractQuery >> subtraction: anotherQuery [

	^ FQSubtractionQuery new subqueries: { 
			  self.
			  anotherQuery }
]

{ #category : 'composition' }
FQAbstractQuery >> union: anotherQuery [

	^ FQUnionQuery new subqueries: { 
			  self.
			  anotherQuery }
]

{ #category : 'composition' }
FQAbstractQuery >> | anotherQuery [
	^ self union: anotherQuery
]
