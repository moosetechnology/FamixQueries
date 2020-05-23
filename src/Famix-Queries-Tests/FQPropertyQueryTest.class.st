Class {
	#name : #FQPropertyQueryTest,
	#superclass : #FQUnaryQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #testing }
FQPropertyQueryTest class >> isAbstract [
	^ self = FQPropertyQueryTest
]

{ #category : #running }
FQPropertyQueryTest >> expectedResult [
	^ self subclassResponsibility
]

{ #category : #running }
FQPropertyQueryTest >> propertyType [
	^ self subclassResponsibility
]

{ #category : #'tests - available parameters' }
FQPropertyQueryTest >> testAvailablePropertiesFor [
	(self unConfiguredQuery
		availablePropertiesFor: helper classesAndMethods)
		do: [ :propertySelector | 
			self assert: propertySelector isSymbol.
			helper classesAndMethods
				do: [ :entity | 
					self
						assert: ((entity perform: propertySelector) isKindOf: self propertyType) ] ]
]

{ #category : #tests }
FQPropertyQueryTest >> testIsValid [
	super testIsValid.
	self deny: (self newQuery property: 'Not a selector') isValid
]

{ #category : #'tests - running' }
FQPropertyQueryTest >> testRunOn [
	self assert: self expectedResult isNotEmpty.
	self
		assertCollection: (query runOn: helper classes)
		hasSameElements: self expectedResult
]

{ #category : #tests }
FQPropertyQueryTest >> testStoreOn [
	| generatedQuery |
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	self assert: generatedQuery class equals: self actualClass.
	self assert: generatedQuery property equals: query property.

	"End here for boolean query"
	query hasComparisonParameters
		ifFalse: [ ^ self ].
	self assert: generatedQuery comparator equals: query comparator.
	self
		assert: generatedQuery valueToCompare
		equals: query valueToCompare
]

{ #category : #tests }
FQPropertyQueryTest >> testValueToCompareAsString [
	self subclassResponsibility
]
