"
I am a query that can be applied on a MooseGroup.

----- Query -----
I navigate from entities following moose relations (complex properties that are not associations).
I use MooseQuery to get the relation and return their opposite.
My result will be entities that are related to the entities of the input MooseGroup.

----- Parameters -----
I have a relation name, the name of the FM3Property defining the relation.

----- API -----
- Running : see FQAbstractQuery comment
- Printing : see FQAbstractQuery comment
- Changing name:
	Use #relationName: with a symbol as argument.
- Comparing:
	Two type queries are equal if their names are the same.
- Available parameters:
	Available relations depend on the input MooseGroup.

----- Validity -----
I am valid if I have a relation name (a symbol).

----- Instance Creation -----
- Class method #name: takes a symbol as argument.
- Simplified creation API:
		'FQRelationQuery name: aSymbol'
"
Class {
	#name : 'FQRelationQuery',
	#superclass : 'FQUnaryQuery',
	#instVars : [
		'relationName'
	],
	#category : 'Famix-Queries-Queries-Unary',
	#package : 'Famix-Queries',
	#tag : 'Queries-Unary'
}

{ #category : 'accessing' }
FQRelationQuery class >> label [

	^ 'Relation Query'
]

{ #category : 'accessing - structure variables' }
FQRelationQuery class >> name: aFamixType [

	^ self new
		  relationName: aFamixType;
		  yourself
]

{ #category : 'comparing' }
FQRelationQuery >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	^ super = anObject and: [ relationName = anObject relationName ]
]

{ #category : 'available parameters' }
FQRelationQuery >> availableRelationNames [

	^ parent ifNil: [ {  } ] ifNotNil: [ 
		  (self availableRelationNamesFor: parent result) sorted:
			  [ :propertyName | propertyName ] ascending ]
]

{ #category : 'available parameters' }
FQRelationQuery >> availableRelationNamesFor: aMooseGroup [

	aMooseGroup ifEmpty: [ ^ {  } ].
	^ aMooseGroup flatCollectAsSet: [ :entity | 
		  entity class mooseDescription allRelationProperties collect: #name ]
]

{ #category : 'default' }
FQRelationQuery >> beDefaultForParent [

	self relationName: (self availableRelationNames
			 ifEmpty: [ nil ]
			 ifNotEmpty: [ :relationNames | relationNames anyOne ])
]

{ #category : 'printing' }
FQRelationQuery >> defaultName [

	^ 'relation named: #' , self relationName
]

{ #category : 'printing' }
FQRelationQuery >> displayOn: aStream with: aString [

	aStream << '(MooseObjectQueryResult withAll: ' << aString
	<< ') relationsNamed: '.
	self relationName storeOn: aStream
]

{ #category : 'comparing' }
FQRelationQuery >> hasSameParametersAs: aQuery [

	^ aQuery relationName = self relationName
]

{ #category : 'comparing' }
FQRelationQuery >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: relationName hash
]

{ #category : 'testing' }
FQRelationQuery >> isValid [

	^ relationName isSymbol
]

{ #category : 'running' }
FQRelationQuery >> rawRunOn: aMooseGroup [

	^ (aMooseGroup rawAllUsing: TEntityMetaLevelDependency) inject: Set new into: [ :res :entity |
		  res addAll: (entity query relations named: self relationName).
		  res ]
]

{ #category : 'accessing' }
FQRelationQuery >> relationName [

	^ relationName
]

{ #category : 'accessing' }
FQRelationQuery >> relationName: aSymbol [

	relationName := aSymbol.
	self resetResult
]

{ #category : 'printing' }
FQRelationQuery >> storeOn: aStream [

	aStream << self className << ' name: '.
	self relationName storeOn: aStream
]
