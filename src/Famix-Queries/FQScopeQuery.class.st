"
I am a query that can be applied on a MooseGroup.

----- Query -----
I collect scopes from entities.
I use MooseQuery methods #atScope:, #toScope: and #withScope:.
A scope is a Famix**Entity subclass (** depends on the meta-model). 
My result will be entities of this class that <contain / are contained in / both> the entities of the input MooseGroup

----- Parameters -----
I have a direction strategy, to scope up, down or both.
	See FQAbstractScopeDirection subclasses.
	My direction is responsible for the call to MooseQuery.
I hold a scope, i.e. a Famix**Entity subclass.

----- API -----
- Running : see FQAbstractQuery comment
- Printing : see FQAbstractQuery comment
- Changing scope: use #scope:.
- Changing direction: 
	Use #directionStrategy: with a subclass of FQAbstractScopeDirection as argument.
	Use #direction: with a symbol (#Up #Down or #UpAndDown) as argument.
- Comparing:
	Two type queries are equal if their direction and scope are the same.
- Available scopes:
	Depending on the input MooseGroup. Responsibility of my direction.

----- Validity -----
I am valid if I have a direction (a subclass of FQAbstractScopeDirection)
	and a valid scope (a subclass of MooseEntity).

----- Instance Creation -----
- Class method #forScope:direction: takes a Famix**Entity suclass and a FQAbstractScopeDirection as argument.
- Simplified creation API:
		'FQScopeQuery new
			direction: #Up ""or #Down or #UpAndDown"";
			scope: aScope'
"
Class {
	#name : #FQScopeQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'scope',
		'direction'
	],
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #'available parameters' }
FQScopeQuery class >> directionStrategies [
	^ MQScopeDirectionStrategy directionStrategies
]

{ #category : #'instance creation' }
FQScopeQuery class >> down [
	^ self new
		directionStrategy: MQScopeDownStrategy;
		yourself
]

{ #category : #'instance creation' }
FQScopeQuery class >> downTo: aScope [
	^ self new
		directionStrategy: MQScopeDownStrategy;
		scope: aScope;
		yourself
]

{ #category : #accessing }
FQScopeQuery class >> label [
	^ 'Scope Query'
]

{ #category : #'instance creation' }
FQScopeQuery class >> up [
	^ self new
		directionStrategy: MQScopeUpStrategy;
		yourself
]

{ #category : #'instance creation' }
FQScopeQuery class >> upAndDown [
	^ self new
		directionStrategy: MQScopeAllStrategy;
		yourself
]

{ #category : #'instance creation' }
FQScopeQuery class >> upAndDownTo: aScope [
	^ self new
		directionStrategy: MQScopeAllStrategy;
		scope: aScope;
		yourself
]

{ #category : #'instance creation' }
FQScopeQuery class >> upTo: aScope [
	^ self new
		directionStrategy: MQScopeUpStrategy;
		scope: aScope;
		yourself
]

{ #category : #'available parameters' }
FQScopeQuery >> availableScopes [
	self flag: #FQTest.
	^ parent
		ifNil: [ {} ]
		ifNotNil: [ self availableScopesFor: parent result ]
]

{ #category : #'available parameters' }
FQScopeQuery >> availableScopesFor: aMooseGroup [
	^ self directionStrategy availableScopesFor: aMooseGroup
]

{ #category : #default }
FQScopeQuery >> beDefaultForParent [
	self directionStrategy: self directionStrategies first.
	self
		scope:
			(self availableScopes
				ifEmpty: [ nil ]
				ifNotEmpty: [ :scopes | scopes first ])
]

{ #category : #printing }
FQScopeQuery >> defaultName [
	^ String
		streamContents: [ :s | 
			s
				<< self directionStrategy label;
				<< ' to ';
				<< (self class stringForClass: self scope) ]
]

{ #category : #accessing }
FQScopeQuery >> directionStrategies [
	^ self class directionStrategies
]

{ #category : #accessing }
FQScopeQuery >> directionStrategy [
	^ direction
]

{ #category : #accessing }
FQScopeQuery >> directionStrategy: anObject [
	direction := anObject
]

{ #category : #printing }
FQScopeQuery >> displayOn: aStream with: aString [
	aStream << '(MooseObjectQueryResult withAll: ' << aString << ') '
		<< self directionStrategy scopingSelector asString.
	aStream
		space;
		<< self scope name
]

{ #category : #comparing }
FQScopeQuery >> hasSameParametersAs: aQuery [
	^ direction == aQuery directionStrategy
		and: [ scope == aQuery scope ]
]

{ #category : #testing }
FQScopeQuery >> isValid [
	^ self directionStrategy isClass
		and: [ (self directionStrategy inheritsFrom: MQScopeDirectionStrategy)
				and: [ self scopeIsValid: self scope ] ]
]

{ #category : #reset }
FQScopeQuery >> resetAndChangeDirection: aDirectionStrategyClass [
	self resetResult.
	direction := aDirectionStrategyClass.
	self
		scope:
			(self availableScopes
				ifNotEmpty: #anyOne
				ifEmpty: [  ]).
	self flag: #FQTest
]

{ #category : #reset }
FQScopeQuery >> resetScope [
	scope := nil
]

{ #category : #running }
FQScopeQuery >> runOn: aMooseGroup [
	^ self directionStrategy scope: self scope on: aMooseGroup
]

{ #category : #accessing }
FQScopeQuery >> scope [
	^ scope
]

{ #category : #accessing }
FQScopeQuery >> scope: anObject [
	(self scopeIsValid: anObject)
		ifFalse: [ ^ self resetScope ].
	scope := anObject.
	self resetResult.
	self flag: #FQTest , 'test reset result'
]

{ #category : #accessing }
FQScopeQuery >> scopeIsValid: anObject [
	^ anObject isClass and: [ anObject inheritsFrom: MooseEntity ]
]

{ #category : #printing }
FQScopeQuery >> storeOn: aStream [
	aStream << self className << ' '
		<< self directionStrategy label asCamelCase uncapitalized.
	self isValid
		ifFalse: [ ^ self ].
	aStream << 'To: ' << self scope name
]
