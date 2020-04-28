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
	#superclass : #FQAbstractQuery,
	#instVars : [
		'scope',
		'direction'
	],
	#category : #'Famix-Queries-Terminal'
}

{ #category : #'instance creation' }
FQScopeQuery class >> forScope: aFamixClass direction: aScopeDirectionClass [
	^ self new
		scope: aFamixClass;
		directionStrategy: aScopeDirectionClass;
		yourself
]

{ #category : #utils }
FQScopeQuery class >> scopeAsString: aScopeClass [
	^ (aScopeClass name
		piecesCutWhere: [ :char1 :char2 | char2 isUppercase ]) last
]

{ #category : #comparing }
FQScopeQuery >> = aQuery [
	^ self class == aQuery class
		and: [ direction == aQuery directionStrategy and: [ scope == aQuery scope ] ]
]

{ #category : #'available parameters' }
FQScopeQuery >> availableDirections [
	^ FQAbstractScopeDirection availableDirections
]

{ #category : #'available parameters' }
FQScopeQuery >> availableScopesFor: aMooseGroup [
	^ self directionStrategy availableScopesFor: aMooseGroup
]

{ #category : #accessing }
FQScopeQuery >> direction: aSymbol [
	direction := self availableDirections
		detect: [ :dir | dir label asCamelCase = aSymbol asString ]
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

{ #category : #testing }
FQScopeQuery >> isValid [
	^ self directionStrategy isClass
		and: [ (self directionStrategy inheritsFrom: FQAbstractScopeDirection)
				and: [ self scope isClass and: [ self scope inheritsFrom: MooseEntity ] ] ]
]

{ #category : #printing }
FQScopeQuery >> printOn: aStream [
	aStream << self class label << ' (' << self directionStrategy label
		<< ', to ' << (self class scopeAsString: self scope) << ')'
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
	scope := anObject
]

{ #category : #printing }
FQScopeQuery >> storeOn: aStream [
	aStream << self className << ' new direction: #'
		<< self directionStrategy label asCamelCase << '; scope: '
		<< self scope name
]
