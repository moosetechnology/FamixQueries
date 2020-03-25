Class {
	#name : #FQNumericQuery,
	#superclass : #FQPropertyQuery,
	#category : #'Famix-Queries-Terminal'
}

{ #category : #'instance creation' }
FQNumericQuery class >> fromProperty: aPropertySelector comparator: aComparisonSelector withValue: aNumericValue [
	^ self new
		property: aPropertySelector;
		comparator: aComparisonSelector;
		valueToCompare: aNumericValue;
		yourself
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