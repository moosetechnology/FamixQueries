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
		'direction',
		'recursive'
	],
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #'available parameters' }
FQScopeQuery class >> directionStrategies [
	^ FQAbstractScopeDirection directionStrategies
]

{ #category : #'instance creation' }
FQScopeQuery class >> down [
	^ self new
		directionStrategy: FQScopeDown;
		yourself
]

{ #category : #'instance creation' }
FQScopeQuery class >> downTo: aScope [
	^ self new
		directionStrategy: FQScopeDown;
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
		directionStrategy: FQScopeUp;
		yourself
]

{ #category : #'instance creation' }
FQScopeQuery class >> upAndDown [
	^ self new
		directionStrategy: FQScopeUpAndDown;
		yourself
]

{ #category : #'instance creation' }
FQScopeQuery class >> upAndDownTo: aScope [
	^ self new
		directionStrategy: FQScopeUpAndDown;
		scope: aScope;
		yourself
]

{ #category : #'instance creation' }
FQScopeQuery class >> upTo: aScope [
	^ self new
		directionStrategy: FQScopeUp;
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

	^ self directionStrategy
		  ifNil: [ {  } ]
		  ifNotNil: [ :direc | direc availableScopesFor: aMooseGroup ]
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

{ #category : #initialization }
FQScopeQuery >> initialize [

	super initialize.
	recursive := false
]

{ #category : #testing }
FQScopeQuery >> isValid [
	^ self directionStrategy isClass
		and: [ (self directionStrategy inheritsFrom: FQAbstractScopeDirection)
				and: [ self scopeIsValid: self scope ] ]
]

{ #category : #running }
FQScopeQuery >> rawRunOn: aMooseGroup [

	^ (aMooseGroup rawAllUsing: TEntityMetaLevelDependency) inject: Set new into: [ :res :entity |
		  res addAll: (self directionStrategy scope: self scope recursively: recursive on: entity).
		  res ]
]

{ #category : #accessing }
FQScopeQuery >> recursive [

	^ recursive
]

{ #category : #accessing }
FQScopeQuery >> recursive: anObject [

	recursive := anObject
]

{ #category : #'as yet unclassified' }
FQScopeQuery >> recursively [

	recursive := true
	
]

{ #category : #reset }
FQScopeQuery >> resetAndChangeDirection: aDirectionStrategyClass [

	self resetResult.
	direction := aDirectionStrategyClass.
	self resetScope.
	self flag: #FQTest
]

{ #category : #reset }
FQScopeQuery >> resetScope [
	scope := nil
]

{ #category : #accessing }
FQScopeQuery >> scope [
	^ scope
]

{ #category : #accessing }
FQScopeQuery >> scope: anObject [

	anObject == scope ifTrue: [ ^ self ].
	(self scopeIsValid: anObject) ifFalse: [ ^ self ].
	scope := anObject.
	self resetResult
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
