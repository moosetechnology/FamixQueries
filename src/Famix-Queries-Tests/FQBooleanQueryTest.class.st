Class {
	#name : #FQBooleanQueryTest,
	#superclass : #FQPropertyQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #running }
FQBooleanQueryTest >> actualClass [
	^ FQBooleanQuery
]

{ #category : #running }
FQBooleanQueryTest >> differentTypeOfQuery [
	^ FQNumericQuery new
		property: #numberOfMethods;
		comparator: #<=;
		valueToCompare: 5
]

{ #category : #running }
FQBooleanQueryTest >> expectedPrintOnString [
	^ 'a FQBooleanQuery (isAbstract)'
]

{ #category : #running }
FQBooleanQueryTest >> expectedResult [
	^ helper classes select: #isAbstract
]

{ #category : #running }
FQBooleanQueryTest >> newQuery [
	^ self unConfiguredQuery property: #isAbstract
]

{ #category : #running }
FQBooleanQueryTest >> propertyType [
	^ Boolean
]

{ #category : #'tests - printing' }
FQBooleanQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup select: [ :entity | entity isAbstract ]'
]

{ #category : #'tests - printing' }
FQBooleanQueryTest >> testName [
	self assert: query name equals: 'isAbstract'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Boolean Query'
]

{ #category : #tests }
FQBooleanQueryTest >> testValueToCompareAsString [
	self
		should: [ query valueToCompareAsString ]
		raise: ShouldNotImplement
]
