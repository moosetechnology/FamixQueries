Class {
	#name : 'FQSelectScriptQueryTest',
	#superclass : 'FQUnaryQueryTest',
	#category : 'Famix-Queries-Tests-Unary',
	#package : 'Famix-Queries-Tests',
	#tag : 'Unary'
}

{ #category : 'running' }
FQSelectScriptQueryTest >> actualClass [
	^ FQSelectScriptQuery 
]

{ #category : 'running' }
FQSelectScriptQueryTest >> newQuery [
	^ self unConfiguredQuery
		script: [ :each | false ]
]

{ #category : 'tests - printing' }
FQSelectScriptQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals: 'aMooseGroup select: [ :each | false ]'.
]

{ #category : 'tests - printing' }
FQSelectScriptQueryTest >> testName [
	self assert: query name equals: 'select: [ :each | false ]'.
]

{ #category : 'tests - printing' }
FQSelectScriptQueryTest >> testPrintOn [

	self assert: query printString equals: 'a FQSelectScriptQuery (select: [ :each | false ])'.
	self
		assert: self unConfiguredQuery printString
		equals: 'a FQSelectScriptQuery (invalid)'
]

{ #category : 'tests - running' }
FQSelectScriptQueryTest >> testRunOn [
	self assertEmpty: (query runOn: #(1 2 3)).

	query := self unConfiguredQuery
		script: #odd.
	self assertCollection: (query runOn: #(1 2 3)) hasSameElements:  #(1 3).

]
