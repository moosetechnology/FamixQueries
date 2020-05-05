"
I am a query that can be applied on a MooseGroup.

----- Query -----
I select entities according to one of their string properties.
Selection is based on the comparison between the entity and a reference value 
	Example: 'aMooseGroup select: [ :entity | entity name includesSubstring: 'Prefix' ]'

----- Parameters -----
I have tree parameters:
	- property <Symbol>: the selector used to access the entities property.
	- comparator <Symbol>: the comparison operator.
	- valueToCompare <String>: the reference value.

----- API -----
- Running : see FQAbstractQuery comment
- Printing : see FQAbstractQuery comment
- Changing parameters: 
	Use setting accessors.
- Comparing:
	Two type queries are equal if their parameters are the same.
- Available properties:
	Accessors to string properties that are common to all entities in the input MooseGroup.

----- Validity -----
I am valid if my parameters are set: if #property and #comparator are symbols and #valueToCompare is a String.

----- Instance Creation -----
- Class method #forProperty:comparator:withValue: takes two selectors <Symbol> and a String as argument.
- Simplified creation API:
		'FQNumericQuery new
			property: aSelector;
			comparator: aComparator;
			valueToCompare: aString'
"
Class {
	#name : #FQStringQuery,
	#superclass : #FQPropertyQuery,
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #'as yet unclassified' }
FQStringQuery class >> color [
	"Light blue"

	^ Color colorFrom: '77AADD'
]

{ #category : #accessing }
FQStringQuery class >> defaultValueToCompare [
	^ ''
]

{ #category : #'instance creation' }
FQStringQuery class >> forProperty: aPropertySelector comparator: aSelector withValue: aString [
	^ self new
		property: aPropertySelector;
		comparator: aSelector;
		valueToCompare: aString;
		yourself
]

{ #category : #'as yet unclassified' }
FQStringQuery class >> label [
	^ 'String ', super label
]

{ #category : #comparing }
FQStringQuery >> = aQuery [
	^ super = aQuery
		and: [ comparator = aQuery comparator
				and: [ valueToCompare = aQuery valueToCompare ] ]
]

{ #category : #'available parameters' }
FQStringQuery >> availableComparators [
	self flag: 'To improve'.
	^ {#includesSubstring: . #beginsWith: . #matchesRegex:}
]

{ #category : #accessing }
FQStringQuery >> comparator [
	^ comparator ifNil: [ comparator := #includesSubString: ]
]

{ #category : #testing }
FQStringQuery >> isValid [
	^ super isValid
		and: [ self comparator isSymbol and: [ self valueToCompare isString ] ]
]

{ #category : #printing }
FQStringQuery >> roassalLabel [
	^ String
		streamContents: [ :s | 
			s
				<< self property;
				cr;
				<< self comparator;
				cr;
				<< self valueToCompareAsString ]
]

{ #category : #'available parameters' }
FQStringQuery >> type [
	^ FM3String
]

{ #category : #printing }
FQStringQuery >> valueToCompareAsString [
	^ self valueToCompare surroundedBySingleQuotes
]
