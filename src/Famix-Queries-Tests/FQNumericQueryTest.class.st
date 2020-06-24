Class {
	#name : #FQNumericQueryTest,
	#superclass : #FQPropertyQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #running }
FQNumericQueryTest >> actualClass [
	^ FQNumericQuery
]

{ #category : #running }
FQNumericQueryTest >> expectedPrintOnString [
	^ 'a FQNumericQuery (numberOfMethods > 10)'
]

{ #category : #running }
FQNumericQueryTest >> expectedResult [
	^ helper classes select: [ :class | class numberOfMethods > 10 ]
]

{ #category : #running }
FQNumericQueryTest >> newQuery [
	^ self unConfiguredQuery
		property: #numberOfMethods;
		comparator: #>;
		valueToCompare: 10
]

{ #category : #running }
FQNumericQueryTest >> propertyType [
	^ Number
]

{ #category : #'tests - printing' }
FQNumericQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup select: [ :entity | entity numberOfMethods > 10 ]'
]

{ #category : #tests }
FQNumericQueryTest >> testIsValid [
	super testIsValid.
	self deny: (self newQuery comparator: 'Not a comparator') isValid.
	self deny: (self newQuery valueToCompare: 'Not a Number') isValid
]

{ #category : #'tests - printing' }
FQNumericQueryTest >> testName [
	self assert: query name equals: 'numberOfMethods > 10'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Numeric Query'
]

{ #category : #tests }
FQNumericQueryTest >> testValueToCompareAsString [
	self
		shouldnt: [ query valueToCompareAsString asNumber ]
		raise: Error
		description: 'Reading a number failed: a digit between 0 and 9 expected'
]
