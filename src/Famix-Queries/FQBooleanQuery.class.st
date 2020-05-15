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

{ #category : #'instance creation' }
FQBooleanQuery class >> forProperty: aBooleanSelector [
	^ self new
		property: aBooleanSelector;
		yourself
]

{ #category : #accessing }
FQBooleanQuery class >> label [
	^ 'Boolean Query'
]

{ #category : #testing }
FQBooleanQuery >> hasComparisonParameters [
	^ false
]

{ #category : #running }
FQBooleanQuery >> runOn: aMooseGroup [
	^ aMooseGroup select: [ :entity | self property value: entity ]
]

{ #category : #'available parameters' }
FQBooleanQuery >> type [
	^ FM3Boolean
]

{ #category : #printing }
FQBooleanQuery >> valueToCompareAsString [
	self shouldNotImplement
]
