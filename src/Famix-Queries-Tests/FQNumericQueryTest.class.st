Class {
	#name : #FQNumericQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQNumericQueryTest >> actualClass [
	^ FQNumericQuery
]

{ #category : #'tests - available parameters' }
FQNumericQueryTest >> testAvailablePropertiesFor [
	| availableProperties |
	query := self actualClass new.
	availableProperties := query
		availablePropertiesFor: classesAndMethods.
		
	availableProperties
		do: [ :propertySelector | 
			self assert: propertySelector isSymbol.
			classesAndMethods
				do:
					[ :entity | self assert: ((entity perform: propertySelector) isKindOf: Number) ] ]
]

{ #category : #'tests - running' }
FQNumericQueryTest >> testDisplayOn [
	query := self actualClass forProperty: #numberOfMethods comparator: #> withValue: 10.

	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup select: [ :entity | entity numberOfMethods > 10 ]'
]

{ #category : #'tests - printing' }
FQNumericQueryTest >> testEquals [
	query := self actualClass
		forProperty: #numberOfMethods
		comparator: #>
		withValue: 10.
	
	"Same query"
	self assert: query equals: (self actualClass
		forProperty: #numberOfMethods
		comparator: #>
		withValue: 10).
	
	"Different property"
	self deny: query equals: (self actualClass
		forProperty: #numberOfMethods
		comparator: #>
		withValue: 5).
	
	"Different comparator"
	self deny: query equals: (self actualClass
		forProperty: #numberOfMethods
		comparator: #>=
		withValue: 10).
		
		
	"Different value to compare"
	self deny: query equals: (self actualClass
		forProperty: #numberOfMembers
		comparator: #>
		withValue: 10).
	
	"Different class of query"
	self deny: query equals: (FQBooleanQuery
		forProperty: #isAbstract)
]

{ #category : #tests }
FQNumericQueryTest >> testIsValid [
	query := self actualClass
		forProperty: #numberOfMethods
		comparator: #<=
		withValue: 10.
	self assert: query isValid.

	query := self actualClass
		forProperty: 'Not a selector'
		comparator: #<=
		withValue: 10.
	self deny: query isValid.

	query := self actualClass
		forProperty: #numberOfMethods
		comparator: 'Not a comparator'
		withValue: 10.
	self deny: query isValid.

	query := self actualClass
		forProperty: #numberOfMethods
		comparator: #<=
		withValue: 'Not a Number'.
	self deny: query isValid.
	
	query := self actualClass new.
	self deny: query isValid
]

{ #category : #'tests - printing' }
FQNumericQueryTest >> testRunOn [
	| classes queryResult expectedResult |	
	classes := model allModelClasses.
	
	query := self actualClass forProperty: #numberOfMethods comparator: #> withValue: 10.
	queryResult := query runOn: classes.
	
	expectedResult := model allModelClasses
		select: [ :class | class numberOfMethods > 10 ].
	
	self assert: queryResult size equals: expectedResult size.
	self
		assertCollection: (query runOn: classes)
		hasSameElements: expectedResult
]

{ #category : #'tests - printing' }
FQNumericQueryTest >> testStoreOn [
	| generatedQuery |
	query := self actualClass new.
	query property: (query availablePropertiesFor: model allModelClasses) first.
	query comparator: query availableComparators first.
	query valueToCompare: 10.
		
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	
	self assert: generatedQuery class equals: self actualClass.
	self assert: generatedQuery property equals: query property.
	self assert: generatedQuery comparator equals: query comparator.
	self assert: generatedQuery valueToCompare equals: query valueToCompare
]
