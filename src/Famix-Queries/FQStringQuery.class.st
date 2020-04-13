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

{ #category : #'available parameters' }
FQStringQuery >> availableComparators [
	self flag: 'To improve'.
	^ {#includesSubstring: . #beginsWith: . #matchesRegex:}
]

{ #category : #accessing }
FQStringQuery >> comparator [
	^ comparator ifNil: [ comparator := #includesSubString: ]
]

{ #category : #'available parameters' }
FQStringQuery >> type [
	^ FM3String
]

{ #category : #printing }
FQStringQuery >> valueToCompareAsString [
	^ self valueToCompare surroundedBySingleQuotes
]
