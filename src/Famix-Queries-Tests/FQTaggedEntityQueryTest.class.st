Class {
	#name : #FQTaggedEntityQueryTest,
	#superclass : #FQUnaryQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #running }
FQTaggedEntityQueryTest >> actualClass [
	^FQTaggedEntityQuery 
]

{ #category : #running }
FQTaggedEntityQueryTest >> expectedPrintOnString [
	^ 'a FQTaggedEntityQuery (tag named: #aTag)'
]

{ #category : #running }
FQTaggedEntityQueryTest >> expectedResult [

	^ helper classesAndMethods
]

{ #category : #running }
FQTaggedEntityQueryTest >> newQuery [

	^ self unConfiguredQuery
		  tagName: #aTag;
		  yourself
]

{ #category : #'tests - printing' }
FQTaggedEntityQueryTest >> testDisplayOn [

	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
		'(MooseObjectQueryResult withAll: aMooseGroup) tagNamed: #aTag'
]

{ #category : #'tests - printing' }
FQTaggedEntityQueryTest >> testName [

	self assert: query name equals: 'tag named: #aTag'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Tag Query'
]

{ #category : #'tests - running' }
FQTaggedEntityQueryTest >> testRunOn [
	self assert: self expectedResult isNotEmpty.
	self
		assertCollection:
		(query runOn: helper modelExample entities)
		hasSameElements: self expectedResult.

]
