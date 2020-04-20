Class {
	#name : #FQStringQuery,
	#superclass : #FQPropertyQuery,
	#category : #'Famix-Queries-Terminal'
}

{ #category : #accessing }
FQStringQuery class >> defaultValueToCompare [
	^ ''
]

{ #category : #'instance creation' }
FQStringQuery class >> fromProperty: aPropertySelector comparator: aSelector withValue: aString [
	^ self new
		property: aPropertySelector;
		comparator: aSelector;
		valueToCompare: aString;
		yourself
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
		and: [ self comparator isNotNil and: [ self valueToCompare isNotNil ] ]
]

{ #category : #'available parameters' }
FQStringQuery >> type [
	^ FM3String
]

{ #category : #printing }
FQStringQuery >> valueToCompareAsString [
	^ self valueToCompare surroundedBySingleQuotes
]
