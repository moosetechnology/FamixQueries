Class {
	#name : #FQStringQueryTest,
	#superclass : #FQPropertyQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #running }
FQStringQueryTest >> actualClass [
	^ FQStringQuery
]

{ #category : #running }
FQStringQueryTest >> expectedPrintOnString [
	^ 'a FQStringQuery (name includesSubstring: ''LANP'')'
]

{ #category : #running }
FQStringQueryTest >> expectedResult [
	^ helper classes select: [ :c | c name includesSubstring: 'LANP' ]
]

{ #category : #running }
FQStringQueryTest >> newQuery [
	^ self unConfiguredQuery
		property: #name;
		comparator: #includesSubstring:;
		valueToCompare: 'LANP'
]

{ #category : #running }
FQStringQueryTest >> propertyType [
	^ String
]

{ #category : #'tests - printing' }
FQStringQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			'aMooseGroup select: [ :entity | entity name includesSubstring: ''LANP'' ]'
]

{ #category : #tests }
FQStringQueryTest >> testIsValid [
	super testIsValid.
	self deny: (self newQuery comparator: 'Not a comparator') isValid.
	self deny: (self newQuery valueToCompare: 10) isValid	"Not a string"
]

{ #category : #'tests - printing' }
FQStringQueryTest >> testName [
	self assert: query name equals: 'name includesSubstring: ''LANP'''.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid String Query'
]

{ #category : #tests }
FQStringQueryTest >> testRunOnNilProperty [
	query property: #kind.
	"No methods have a kind in this model. 
		'anEntity kind' returns nil"
	self assert: (query runOn: helper methods) isEmpty
]

{ #category : #tests }
FQStringQueryTest >> testValueToCompareAsString [
	self assert: query valueToCompareAsString equals: '''LANP'''
]
