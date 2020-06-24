Class {
	#name : #FQRootQueryTest,
	#superclass : #FQUnaryQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #running }
FQRootQueryTest >> actualClass [
	^ FQRootQuery
]

{ #category : #running }
FQRootQueryTest >> expectedPrintOnString [
	^ 'a FQRootQuery (Model)'
]

{ #category : #running }
FQRootQueryTest >> newQuery [
	^ self actualClass new
]

{ #category : #tests }
FQRootQueryTest >> testBeChildOf [
	self
		should: [ query beChildOf: self newParentQuery ]
		raise: FQNoParentForRootQuery
]

{ #category : #'tests - printing' }
FQRootQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals: 'aMooseGroup'
]

{ #category : #tests }
FQRootQueryTest >> testIsValid [
	self assert: query isValid.
	query result: nil.
	self deny: query isValid
]

{ #category : #'tests - printing' }
FQRootQueryTest >> testName [
	self assert: query name equals: 'Model'
]

{ #category : #'tests - printing' }
FQRootQueryTest >> testPrintOn [
	self assert: query printString equals: self expectedPrintOnString
]

{ #category : #tests }
FQRootQueryTest >> testResult [
	self deny: query result isNil
]

{ #category : #'tests - running' }
FQRootQueryTest >> testRunOn [
	self
		assertCollection: (self newQuery runOn: helper modelExample)
		hasSameElements: helper modelExample.
	self
		assertCollection: (self newQuery runOn: helper classesAndMethods)
		hasSameElements: helper classesAndMethods.
	self
		assertCollection: (self newQuery runOn: helper noEntities)
		hasSameElements: helper noEntities
]
