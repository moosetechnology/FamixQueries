Class {
	#name : 'FQSequenceQueryTest',
	#superclass : 'TestCase',
	#instVars : [
		'helper',
		'querySequence',
		'nAryQuerySequence',
		'complementQuerySequence'
	],
	#category : 'Famix-Queries-Tests-Core',
	#package : 'Famix-Queries-Tests',
	#tag : 'Core'
}

{ #category : 'as yet unclassified' }
FQSequenceQueryTest >> initializeComplementQuerySequence [

	complementQuerySequence := FQComplementQuery queryToNegate:
		                           (FQTypeQuery types: { FamixStClass })
]

{ #category : 'as yet unclassified' }
FQSequenceQueryTest >> initializeNAryQuerySequence [

	nAryQuerySequence := (FQTypeQuery types: { FamixStClass })
	                     | (FQStringQuery
			                      property: #name
			                      comparator: #beginsWith:
			                      valueToCompare: 'i')
]

{ #category : 'as yet unclassified' }
FQSequenceQueryTest >> initializeQuerySequence [

	querySequence := (FQTypeQuery types: { FamixStClass })
	                 --> (FQScopeQuery downTo: FamixStMethod)
	                 --> (FQStringQuery
			                  property: #name
			                  comparator: #beginsWith:
			                  valueToCompare: 'i')
]

{ #category : 'as yet unclassified' }
FQSequenceQueryTest >> querySequence [

	^ querySequence
]

{ #category : 'running' }
FQSequenceQueryTest >> setUp [

	super setUp.
	helper := FQTestsHelper new.
	self initializeQuerySequence.
	self initializeNAryQuerySequence.
	self initializeComplementQuerySequence
]

{ #category : 'tests' }
FQSequenceQueryTest >> testExecuteOn [

	self
		assertCollection:
		(self querySequence executeOn: helper modelExample)
		hasSameElements: (querySequence runOn: (querySequence parent runOn:
					  (querySequence parent parent runOn: helper modelExample)))
]

{ #category : 'tests' }
FQSequenceQueryTest >> testExecuteOnWithComplementQuery [

	self
		denyCollection: (OrderedCollection withAll:
				 (complementQuerySequence executeOn: helper modelExample))
		includesAny:
		(complementQuerySequence queryToNegate executeOn:
			 helper modelExample)
]

{ #category : 'tests' }
FQSequenceQueryTest >> testExecuteOnWithNAryQuery [

	self
		assertCollection: (nAryQuerySequence executeOn: helper modelExample)
		hasSameElements:
			(nAryQuerySequence subqueries first executeOn: helper modelExample)
			|
			(nAryQuerySequence subqueries second executeOn: helper modelExample)
]

{ #category : 'tests' }
FQSequenceQueryTest >> testHasParent [

	self assert: querySequence parent isNotNil
]
