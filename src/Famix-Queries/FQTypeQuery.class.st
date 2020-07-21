"
I am a query that can be applied on a MooseGroup.

----- Query -----
I select entities according to their type.
A type can be: 
	- A Famix**Entity subclass (** depends on the meta-model, example: FamixStClass, FamixJavaMethod, ...). 
		I will then select entities by doing: ""aMooseGroup allWithType: Famix***""
	- A FamixTrait
		I will then select entities by doing: ""aMooseGroup allUsing: FamixT**""

----- Parameters -----
I hold a collection of types. I can thus select entities of these types:
	my final result is the union of the selection for each type.
	Example: i can select all methods, classes and packages in the input mooseGroup.

----- API -----
- Running : see FQAbstractQuery comment
- Printing : see FQAbstractQuery comment
- Adding - removing types: 
	Use #addType: and #removeType:.
	You cannot add the same type twice.
	Trying to remove the last type will raise a FQCannotRemoveLastType exception.
- Comparing:
	Two type queries are equal if their types are the same.
- Available types:
	Classes of the named entities in the MooseGroup.

----- Validity -----
I am valid if I have at least 1 type.

----- Instance Creation -----
- Class method #forType: takes a single type as argument
- Class method #forTypes: takes a collection of types as argument
- Simplified creation API:
		'FQTypeQuery new
			type: aType1;
			type: aType2'
	/!\ Using this, it is possible to create an invalid query (with #types empty)
"
Class {
	#name : #FQTypeQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'types'
	],
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #'instance creation' }
FQTypeQuery class >> label [
	^ 'Type Query'
]

{ #category : #'instance creation' }
FQTypeQuery class >> types: aCollectionOfTypes [
	^ self new
		types: aCollectionOfTypes;
		yourself
]

{ #category : #'adding - removing' }
FQTypeQuery >> addType: aType [
	(self types includes: aType)
		ifTrue: [ ^ self ].
	self types add: aType.
	self resetResult.
	self flag: #FQTest , 'test reset'
]

{ #category : #'available parameters' }
FQTypeQuery >> availableTypes [
	self flag: #FQTest.
	^ self availableTypesFor: parent result
]

{ #category : #'available parameters' }
FQTypeQuery >> availableTypesFor: aMooseGroup [
	^ aMooseGroup allEntityTypes asOrderedCollection sort: [ :type1 :type2 | type1 name < type2 name ]
]

{ #category : #default }
FQTypeQuery >> beDefaultForParent [
	self types: self availableTypes
]

{ #category : #printing }
FQTypeQuery >> defaultName [
	^ String
		streamContents: [ :s | 
			self types
				allButLastDo: [ :type | s << (self class stringForClass: type) << ', ' ].
			s << (self class stringForClass: self types last) ]
]

{ #category : #printing }
FQTypeQuery >> displayOn: aStream with: aString [
	self types size == 1
		ifTrue:
			[ aStream << aString << (self displayStringForType: self types first) ]
		ifFalse: [ self types
				allButLastDo:
					[ :type | aStream << $( << aString << (self displayStringForType: type) << ') | ' ].
			aStream << $( << aString
				<< (self displayStringForType: self types last) << $) ]
]

{ #category : #printing }
FQTypeQuery >> displayStringForType: aType [
	^ (aType isTrait
		ifTrue: [ ' allUsing: ' ]
		ifFalse: [ ' allWithType: ' ]) , aType name
]

{ #category : #comparing }
FQTypeQuery >> hasSameParametersAs: aQuery [
	^ types = aQuery types
]

{ #category : #initialization }
FQTypeQuery >> initialize [
	super initialize.
	types := OrderedCollection new
]

{ #category : #testing }
FQTypeQuery >> isValid [
	^ self types isNotEmpty
		and: [ types allSatisfy: [ :type | self typeIsValid: type ] ]
]

{ #category : #'adding - removing' }
FQTypeQuery >> removeType: aType [
	self types size = 1
		ifTrue: [ FQCannotRemoveLastType
				signal: 'Removing the last type of a ' , self className , ' is forbidden' ].
	self types remove: aType.
	self resetResult.
	self flag: #FQTest , 'test reset'
]

{ #category : #running }
FQTypeQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ (self types asSet flatCollect: [ :type | aMooseGroup allMatching: type ]) asMooseGroup
]

{ #category : #printing }
FQTypeQuery >> storeOn: aStream [
	aStream << self className << ' types: {'.
	self isValid
		ifTrue: [ self types allButLastDo: [ :type | aStream << type name << '. ' ].
			aStream << self types last name ].
	aStream << $}
]

{ #category : #'adding - removing' }
FQTypeQuery >> type: aType [
	self addType: aType
	"self addTypeSymbol: aTypeSymbol"
]

{ #category : #accessing }
FQTypeQuery >> typeIsValid: elt [
	"Large acceptance: 
MooseEntity. Could be using FamixTNamedEntity, ... 
isTrait could be more thorough."

	^ (elt isClass and: [ elt inheritsFrom: MooseEntity ])
		or: [ elt isTrait ]
]

{ #category : #accessing }
FQTypeQuery >> types [
	^ types
]

{ #category : #accessing }
FQTypeQuery >> types: aCollection [
	types := aCollection asOrderedCollection
		select:
			[ :elt | self typeIsValid: elt ]
]
