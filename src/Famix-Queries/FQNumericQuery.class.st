Class {
	#name : #FQNumericQuery,
	#superclass : #FQPropertyQuery,
	#category : #'Famix-Queries-Terminal'
}

{ #category : #accessing }
FQNumericQuery class >> defaultValueToCompare [
	^ 0
]

{ #category : #'instance creation' }
FQNumericQuery class >> fromProperty: aPropertySelector comparator: aComparisonSelector withValue: aNumericValue [
	^ self new
		property: aPropertySelector;
		comparator: aComparisonSelector;
		valueToCompare: aNumericValue;
		yourself
]

{ #category : #'available parameters' }
FQNumericQuery >> availableComparators [
	self flag: 'To improve'.
	^ {#> . #>= . #= . #<= . #<}
]

{ #category : #'available parameters' }
FQNumericQuery >> type [
	^ FM3Number
]

{ #category : #printing }
FQNumericQuery >> valueToCompareAsString [
	^ self valueToCompare asString
]
