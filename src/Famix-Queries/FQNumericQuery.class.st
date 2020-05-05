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

{ #category : #'as yet unclassified' }
FQNumericQuery class >> color [
	"Light cyan"

	^ Color colorFrom: '99DDFF'
]

{ #category : #accessing }
FQNumericQuery class >> defaultValueToCompare [
	^ 0
]

{ #category : #'instance creation' }
FQNumericQuery class >> forProperty: aPropertySelector comparator: aComparisonSelector withValue: aNumericValue [
	^ self new
		property: aPropertySelector;
		comparator: aComparisonSelector;
		valueToCompare: aNumericValue;
		yourself
]

{ #category : #'as yet unclassified' }
FQNumericQuery class >> label [
	^ 'Number ', super label
]

{ #category : #comparing }
FQNumericQuery >> = aQuery [
	^ super = aQuery
		and: [ comparator = aQuery comparator
				and: [ valueToCompare = aQuery valueToCompare ] ]
]

{ #category : #'available parameters' }
FQNumericQuery >> availableComparators [
	self flag: 'To improve'.
	^ {#> . #>= . #= . #<= . #<}
]

{ #category : #testing }
FQNumericQuery >> isValid [
	^ super isValid
		and: [ self comparator isSymbol and: [ self valueToCompare isNumber ] ]
]

{ #category : #printing }
FQNumericQuery >> roassalLabel [
	^ String
		streamContents: [ :s | 
			s
				<< self property;
				cr;
				<< self comparator;
				<< self valueToCompareAsString ]
]

{ #category : #'available parameters' }
FQNumericQuery >> type [
	^ FM3Number
]

{ #category : #printing }
FQNumericQuery >> valueToCompareAsString [
	^ self valueToCompare asString
]
