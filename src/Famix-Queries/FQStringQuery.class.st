Class {
	#name : #FQStringQuery,
	#superclass : #FQPropertyQuery,
	#category : #'Famix-Queries-Terminal'
}

{ #category : #'instance creation' }
FQStringQuery class >> fromProperty: aPropertySelector selector: aSelector withPattern: aString [
	^ (self fromProperty: aPropertySelector)
		comparator: aSelector;
		valueToCompare: aString;
		yourself
]

{ #category : #accessing }
FQStringQuery >> comparator [
	^ comparator ifNil: [ comparator := #includesSubString: ]
]

{ #category : #running }
FQStringQuery >> displayOn: aStream [
	aStream << 'mooseGroup select: [ :entity | entity '
		<< self property asString << ' includesSubstring: '
		<< self valueToCompare << ' ]'
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

{ #category : #accessing }
FQStringQuery >> valueToCompare [
	^ valueToCompare ifNil: [ valueToCompare := '' ]
]
