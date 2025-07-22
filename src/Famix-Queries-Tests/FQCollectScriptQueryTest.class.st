"
Test for FQCollectScriptQuery
"
Class {
	#name : 'FQCollectScriptQueryTest',
	#superclass : 'FQUnaryQueryTest',
	#category : 'Famix-Queries-Tests-Unary',
	#package : 'Famix-Queries-Tests',
	#tag : 'Unary'
}

{ #category : 'running' }
FQCollectScriptQueryTest >> actualClass [
	^ FQCollectScriptQuery 
]

{ #category : 'running' }
FQCollectScriptQueryTest >> newQuery [
	^ self unConfiguredQuery
		script: [ :each | each ]
]

{ #category : 'tests - printing' }
FQCollectScriptQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals: 'aMooseGroup collect: [ :each | each ]'.
]

{ #category : 'tests - printing' }
FQCollectScriptQueryTest >> testName [
	self assert: query name equals: 'collect: [ :each | each ]'.
]

{ #category : 'tests - printing' }
FQCollectScriptQueryTest >> testPrintOn [

	self assert: query printString equals: 'a FQCollectScriptQuery (collect: [ :each | each ])'.
	self
		assert: self unConfiguredQuery printString
		equals: 'a FQCollectScriptQuery (invalid)'
]

{ #category : 'tests - running' }
FQCollectScriptQueryTest >> testRunOn [
	| clazz |
	clazz := FamixStClass new name: 'clazz'; yourself.
	FamixStMethod new name: 'method1' ; parentType: clazz.
	FamixStMethod new name: 'method2' ; parentType: clazz.
	FamixStMethod new name: 'method3' ; parentType: clazz.

	query := self unConfiguredQuery
		script: [:c | c].
	self assert: (query runOn: {clazz} asMooseGroup) size equals: 1.

	query := self unConfiguredQuery
		script: [:c | c methods].
	self assert: (query runOn: {clazz} asMooseGroup) size equals: 3.

]
