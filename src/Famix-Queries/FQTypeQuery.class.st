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
	Trying to remove the last type will raise a FQTypeQueryMustHaveAtLeastOneType exception.
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
	#superclass : #FQAbstractQuery,
	#instVars : [
		'types'
	],
	#category : #'Famix-Queries-Terminal'
}

{ #category : #'instance creation' }
FQTypeQuery class >> forType: aType [
	^ self new
		types: {aType} asOrderedCollection;
		yourself
]

{ #category : #'instance creation' }
FQTypeQuery class >> forTypes: aTypesCollection [
	^ self new
		types: aTypesCollection asOrderedCollection;
		yourself
]

{ #category : #'as yet unclassified' }
FQTypeQuery class >> typeAsSymbol: aType [
	^ (aType name piecesCutWhere: [ :char1 :char2 | char2 isUppercase ])
		last asSymbol
]

{ #category : #comparing }
FQTypeQuery >> = aQuery [
	^ self class == aQuery class and: [ types = aQuery types ]
]

{ #category : #'adding - removing' }
FQTypeQuery >> addType: aType [
	(self types includes: aType)
		ifTrue: [ ^ self ].
	self types add: aType
]

{ #category : #printing }
FQTypeQuery >> addTypeSymbol: aTypeSymbol [
	self flag: 'For future use if using only symbols is possible'.
	(self types
		anySatisfy: [ :type | (self class typeAsSymbol: type) = aTypeSymbol ])
		ifTrue: [ ^ self ].
	self addType: (Smalltalk classNamed: 'FamixT' , aTypeSymbol asString)
	"We chose to recreate traits because the prefix is not meta-model-dependent. 
	This may cause problems if the user meant to use a class. 
	Example: 
		The user wrote 
			'TypeQuery new type: #Enum' 
		because he·she wanted a query doing 
			'aMooseGroup allWithType: FamixJavaEnum'.

		We interpret it as 
			'aMooseGroup allusing: FamixTEnum'
		but this trait does not exist, so the query will fail."
]

{ #category : #running }
FQTypeQuery >> allWantedIn: aMooseGroup [
	^ self types
		flatCollectAsSet: [ :type | 
			type isTrait
				ifTrue: [ aMooseGroup allUsing: type ]
				ifFalse: [ aMooseGroup allWithType: type ] ]
]

{ #category : #'available parameters' }
FQTypeQuery >> availableTypesFor: aMooseGroup [
	self
		flag: 'Selection of the named entities: all entities may not respond'.
	^ ((aMooseGroup allUsing: FamixTNamedEntity) collect: #class)
		removeDuplicates asOrderedCollection
		sort: [ :type1 :type2 | type1 name < type2 name ]
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

{ #category : #initialization }
FQTypeQuery >> initialize [
	super initialize.
	types := OrderedCollection new
]

{ #category : #testing }
FQTypeQuery >> isValid [
	"Large acceptance: 
MooseEntity. Could be using FamixTNamedEntity, ... 
isTrait could be more thorough."

	^ self types isNotEmpty
		and: [ types
				allSatisfy: [ :type | 
					(type isClass and: [ type inheritsFrom: MooseEntity ])
						or: [ type isTrait ] ] ]
]

{ #category : #'adding - removing' }
FQTypeQuery >> removeType: aType [
	self types size = 1
		ifTrue: [ FQCannotRemoveLastType
				signal: 'Removing the last type of a ' , self className , ' is forbidden' ].
	self types remove: aType
]

{ #category : #running }
FQTypeQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ MooseGroup withAll: (self allWantedIn: aMooseGroup)
]

{ #category : #printing }
FQTypeQuery >> storeOn: aStream [
	aStream << self simpleClassName << ' new '.
	self types
		allButLastDo: [ :type | 
			aStream << 'type: '.
			"(self class typeAsSymbol: type) storeOn: aStream."
			aStream << type name << '; ' ].
	aStream << 'type: ' << self types last name
	"(self class typeAsSymbol: self types last) storeOn: aStream"
]

{ #category : #'adding - removing' }
FQTypeQuery >> type: aType [
	self addType: aType
	"self addTypeSymbol: aTypeSymbol"
]

{ #category : #accessing }
FQTypeQuery >> types [
	^ types
]

{ #category : #accessing }
FQTypeQuery >> types: aCollection [
	types := aCollection asOrderedCollection
]
