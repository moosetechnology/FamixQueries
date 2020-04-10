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

{ #category : #'available properties' }
FQStringQuery >> availableComparators [
	self flag: 'To improve'.
	^ {#includesSubstring: . #beginsWith: . #matchesRegex:}
]

{ #category : #accessing }
FQStringQuery >> comparator [
	^ comparator ifNil: [ comparator := #includesSubString: ]
]

{ #category : #running }
FQStringQuery >> displayOn: aStream with: aString [
	(aStream << aString << ' select: [ :entity | entity ')
		<< self property asString;
		space;
		<< self comparator asString;
		space;
		<< '''';
		<< self valueToCompare;
		<< '''';
		<< ' ]'
]

{ #category : #running }
FQStringQuery >> runOn: aMooseGroup [
	"I should run myself on the MooseGroup as parameter and return a new MooseGroup with my result."

	^ aMooseGroup
		select: [ :entity | 
			(self property value: entity)
				perform: self comparator
				with: self valueToCompare ]
]

{ #category : #'available properties' }
FQStringQuery >> type [
	^ FM3String
]

{ #category : #'as yet unclassified' }
FQStringQuery >> valueToCompareAsString [
	^ self valueToCompare surroundedBySingleQuotes
]
