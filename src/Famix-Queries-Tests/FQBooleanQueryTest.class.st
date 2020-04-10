Class {
	#name : #FQBooleanQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Terminal'
}

{ #category : #helpers }
FQBooleanQueryTest >> actualClass [
	^ FQBooleanQuery
]

{ #category : #tests }
FQBooleanQueryTest >> testDisplayOn [
	query := self actualClass fromProperty: #isInstanceSide.
	
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup select: [ :entity | entity isInstanceSide ]'
]

{ #category : #tests }
FQBooleanQueryTest >> testRunOn [
	| grp queryResult expectedResult |
	grp := model allModelClasses.
	
	query := self actualClass fromProperty: #isInstanceSide.
	queryResult := query runOn: grp.
	
	expectedResult := model allModelClasses select: #isInstanceSide.
	
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]

{ #category : #tests }
FQBooleanQueryTest >> testStoreOn [
	| generatedQuery |
	query := self actualClass new.
	query property: (query availablePropertiesFor: model allModelClasses) first.
	
	generatedQuery := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).
	
	self assert: generatedQuery class equals: self actualClass.
	self assert: generatedQuery property equals: query property
]
