"
I am a query that can be applied on a MooseGroup.

----- Query -----
I select entities according to one of their boolean properties.
Selection is based on the value of the entity.
	Example: 'aMooseGroup select: #isAbstract'.

----- Parameters -----
#property <Symbol>: the selector used to access the entities property.

----- API -----
- Running : see FQAbstractQuery comment
- Printing : see FQAbstractQuery comment
- Changing property: 
	Use #property:.
- Comparing:
	Two type queries are equal if their properties are the same.
- Available properties:
	Accessors to boolean properties that are common to all entities in the input MooseGroup.

----- Validity -----
I am valid if my property is a symbol.

----- Instance Creation -----
- Class method #forProperty: takes a selector <Symbol> as argument.
- Simplified creation API:
		'FQBooleanQuery new
			property: aSelector
"
Class {
	#name : #FQBooleanQuery,
	#superclass : #FQPropertyQuery,
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #'available parameters' }
FQBooleanQuery class >> comparators [
	^ {#yourself . #not}
]

{ #category : #default }
FQBooleanQuery class >> defaultComparator [
	^ #yourself
]

{ #category : #accessing }
FQBooleanQuery class >> label [
	^ 'Boolean Query'
]

{ #category : #'instance creation' }
FQBooleanQuery class >> property: aSymbol [
	^ self new
		property: aSymbol;
		yourself
]

{ #category : #'available parameters' }
FQBooleanQuery class >> type [
	^ FM3Boolean
]

{ #category : #running }
FQBooleanQuery >> applyComparatorOnEntityProperty: entityProperty [
	"#comparator for Booleanqueries has no argument, it is #not or #yourself"
	^entityProperty perform: self comparator
]

{ #category : #testing }
FQBooleanQuery >> hasComparisonParameters [
	^ false
]

{ #category : #testing }
FQBooleanQuery >> isValid [
	^ super isValid
		and: [ self comparator isSymbol ]
]

{ #category : #printing }
FQBooleanQuery >> valueToCompareAsString [
	self shouldNotImplement
]
