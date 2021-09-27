"
I am a query that can be applied on a MooseGroup.

----- Query -----
I select entities according to one of their numeric properties.
Selection is based on the comparison between the entity and a reference value 
	Example: 'aMooseGroup select: [ :entity | entity numberOfMethods > 10 ]'

----- Parameters -----
I have tree parameters:
	- property <Symbol>: the selector used to access the entities property.
	- comparator <Symbol>: the comparison operator.
	- valueToCompare <Number>: the reference value.

----- API -----
- Running : see FQAbstractQuery comment
- Printing : see FQAbstractQuery comment
- Changing parameters: 
	Use setting accessors.
- Comparing:
	Two type queries are equal if their parameters are the same.
- Available properties:
	Accessors to numeric properties that are common to all entities in the input MooseGroup.

----- Validity -----
I am valid if my parameters are set: if #property and #comparator are symbols and #valueToCompare is a Number.

----- Instance Creation -----
- Class method #forProperty:comparator:withValue: takes two selectors <Symbol> and a Number as argument.
- Simplified creation API:
		'FQNumericQuery new
			property: aSelector;
			comparator: aComparator;
			valueToCompare: aNumber'
"
Class {
	#name : #FQNumericQuery,
	#superclass : #FQPropertyQuery,
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #'available parameters' }
FQNumericQuery class >> comparators [
	self flag: #FQImprove.
	^ {#> . #>= . #= . #<= . #<}
]

{ #category : #default }
FQNumericQuery class >> defaultComparator [
	^ #>
]

{ #category : #accessing }
FQNumericQuery class >> defaultValueToCompare [
	^ 0
]

{ #category : #accessing }
FQNumericQuery class >> label [
	^ 'Numeric Query'
]

{ #category : #'instance creation' }
FQNumericQuery class >> property: aSymbol comparator: aComparingSymbol valueToCompare: aNumber [
	^ self new
		property: aSymbol;
		comparator: aComparingSymbol;
		valueToCompare: aNumber;
		yourself
]

{ #category : #'available parameters' }
FQNumericQuery class >> type [
	^ FM3Number
]

{ #category : #comparing }
FQNumericQuery >> hasSameParametersAs: aQuery [
	^ (super hasSameParametersAs: aQuery)
		and: [ comparator = aQuery comparator
				and: [ valueToCompare = aQuery valueToCompare ] ]
]

{ #category : #testing }
FQNumericQuery >> isValid [
	^ super isValid
		and: [ self comparator isSymbol and: [ self valueToCompare isNumber ] ]
]

{ #category : #printing }
FQNumericQuery >> valueToCompareAsString [
	^ self valueToCompare printString
]
