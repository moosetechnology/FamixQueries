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

{ #category : #'available properties' }
FQNumericQuery >> availableComparators [
	self flag: 'To improve'.
	^ {#> . #>= . #= . #<= . #<}
]

{ #category : #running }
FQNumericQuery >> displayOn: aStream with: aString [
	(aStream << aString << ' select: [ :entity | entity ')
		<< self property asString;
		space;
		<< self comparator asString;
		space;
		<< self valueToCompare asString;
		<< ' ]'
]

{ #category : #running }
FQNumericQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ aMooseGroup
		select: [ :entity | 
			(self property value: entity)
				perform: self comparator
				with: self valueToCompare ]
]

{ #category : #'available properties' }
FQNumericQuery >> type [
	^ FM3Number
]

{ #category : #'as yet unclassified' }
FQNumericQuery >> valueToCompareAsString [
	^ self valueToCompare asString
]
