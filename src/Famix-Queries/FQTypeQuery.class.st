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
	#name : 'FQTypeQuery',
	#superclass : 'FQUnaryQuery',
	#instVars : [
		'types'
	],
	#category : 'Famix-Queries-Queries-Unary',
	#package : 'Famix-Queries',
	#tag : 'Queries-Unary'
}

{ #category : 'instance creation' }
FQTypeQuery class >> label [
	^ 'Type Query'
]

{ #category : 'instance creation' }
FQTypeQuery class >> types: aCollectionOfTypes [
	^ self new
		types: aCollectionOfTypes;
		yourself
]

{ #category : 'comparing' }
FQTypeQuery >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	^ super = anObject and: [ types = anObject types ]
]

{ #category : 'adding - removing' }
FQTypeQuery >> addType: aType [
	(self types includes: aType)
		ifTrue: [ ^ self ].
	self types add: aType.
	self resetResult.
	self flag: #FQTest , 'test reset'
]

{ #category : 'available parameters' }
FQTypeQuery >> availableTypes [
	self flag: #FQTest.
	^ self availableTypesFor: parent result
]

{ #category : 'available parameters' }
FQTypeQuery >> availableTypesFor: aMooseGroup [

	^ ((aMooseGroup allUsing: TEntityMetaLevelDependency) allEntityTypes
		   as: OrderedCollection) sort: [ :type1 :type2 |
		  type1 name < type2 name ]
]

{ #category : 'default' }
FQTypeQuery >> beDefaultForParent [

	"Don't do nothing. The previous behavior was to select all the types by default"

	
]

{ #category : 'printing' }
FQTypeQuery >> defaultName [

	^ String streamContents: [ :s |
		  self types
			  do: [ :type |
			  s << type name piecesCutWhereCamelCase last asEnglishPlural ]
			  separatedBy: [ s << ', ' ] ]
]

{ #category : 'printing' }
FQTypeQuery >> displayOn: aStream with: aString [

	self types size == 1
		ifTrue: [ 
		aStream << aString << (self displayStringForType: self types first) ]
		ifFalse: [ 
			self types
				do: [ :type | 
					aStream << $( << aString << (self displayStringForType: type)
					<< ')' ]
				separatedBy: [ aStream << ' | ' ] ]
]

{ #category : 'printing' }
FQTypeQuery >> displayStringForType: aType [
	^ (aType isTrait
		ifTrue: [ ' allUsing: ' ]
		ifFalse: [ ' allWithType: ' ]) , aType name
]

{ #category : 'comparing' }
FQTypeQuery >> hasSameParametersAs: aQuery [
	^ types = aQuery types
]

{ #category : 'comparing' }
FQTypeQuery >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ super hash bitXor: types hash
]

{ #category : 'initialization' }
FQTypeQuery >> initialize [
	super initialize.
	types := OrderedCollection new
]

{ #category : 'testing' }
FQTypeQuery >> isValid [

	^ types isNotEmpty and: [ 
		  types allSatisfy: [ :type | self typeIsValid: type ] ]
]

{ #category : 'running' }
FQTypeQuery >> rawRunOn: aMooseGroup [

	^ self types asSet flatCollect: [ :type | aMooseGroup allMatching: type ]
]

{ #category : 'adding - removing' }
FQTypeQuery >> removeType: aType [

	self types remove: aType.
	self resetResult.
	self flag: #FQTest , 'test reset'
]

{ #category : 'printing' }
FQTypeQuery >> storeOn: aStream [

	aStream << self className << ' types: {'.
	self isValid ifTrue: [ 
		self types
			do: [ :type | aStream << type name ]
			separatedBy: [ aStream << '. ' ] ].
	aStream << $}
]

{ #category : 'adding - removing' }
FQTypeQuery >> type: aType [
	self addType: aType
	"self addTypeSymbol: aTypeSymbol"
]

{ #category : 'accessing' }
FQTypeQuery >> typeIsValid: elt [
	"Large acceptance: 
MooseEntity. Could be using FamixTNamedEntity, ... 
isTrait could be more thorough."

	^ (elt isClass and: [ elt inheritsFrom: MooseEntity ])
		or: [ elt isTrait ]
]

{ #category : 'accessing' }
FQTypeQuery >> types [
	^ types
]

{ #category : 'accessing' }
FQTypeQuery >> types: aCollection [

	types := (aCollection as: OrderedCollection) select: [ :elt |
		         self typeIsValid: elt ]
]
