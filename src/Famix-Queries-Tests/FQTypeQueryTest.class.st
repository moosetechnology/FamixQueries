Class {
	#name : #FQTypeQueryTest,
	#superclass : #FQUnaryQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #running }
FQTypeQueryTest >> actualClass [
	^ FQTypeQuery
]

{ #category : #'tests - available parameters' }
FQTypeQueryTest >> allNamedEntitiesTypes [
	^ (helper modelExample allUsing: TEntityMetaLevelDependency) collectAsSet: #class
]

{ #category : #'tests - running' }
FQTypeQueryTest >> assertRunOnResult [
	self
		assertCollection: (query runOn: helper modelExample)
		hasSameElements: self expectedResult
]

{ #category : #running }
FQTypeQueryTest >> expectedPrintOnString [
	^ 'a FQTypeQuery (Classes, Methods)'
]

{ #category : #'tests - running' }
FQTypeQueryTest >> expectedResult [
	"does not reject #isStub"

	^ {(helper modelExample allWithType: FamixStClass).
	(helper modelExample allWithType: FamixStMethod)} flatten
		asMooseGroup
]

{ #category : #'instance creation' }
FQTypeQueryTest >> newParentQuery [
	^ FQRootQuery new result: helper modelExample
]

{ #category : #running }
FQTypeQueryTest >> newQuery [
	^ self unConfiguredQuery
		type: FamixStClass;
		type: FamixStMethod
]

{ #category : #'tests - adding - removing' }
FQTypeQueryTest >> testAddType [
	query := self unConfiguredQuery.
	query addType: FamixStMethod.
	self assert: (query types includes: FamixStMethod).
	query addType: FamixStMethod.
	self assert: (query types occurrencesOf: FamixStMethod) equals: 1
]

{ #category : #'tests - available parameters' }
FQTypeQueryTest >> testAvailableTypesFor [
	| availableTypes |
	availableTypes := query availableTypesFor: helper modelExample.
	self
		assertCollection: availableTypes
		includesAll: self allNamedEntitiesTypes.
	availableTypes
		do:
			[ :type | self assert: (availableTypes occurrencesOf: type) equals: 1 ]
]

{ #category : #'tests - printing' }
FQTypeQueryTest >> testDisplayOn [
	"Class"
	query := self unConfiguredQuery type: FamixStClass.
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals: 'aMooseGroup allWithType: FamixStClass'.

	"Trait"
	query := self unConfiguredQuery type: FamixTClass.
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals: 'aMooseGroup allUsing: FamixTClass'.

	"Both"
	query type: FamixStMethod.
	self
		assert: (String streamContents: [ :stream | query displayOn: stream ])
		equals:
			'(aMooseGroup allUsing: FamixTClass) | (aMooseGroup allWithType: FamixStMethod)'
]

{ #category : #tests }
FQTypeQueryTest >> testIsValid [
	super testIsValid.

	"Trait"
	self assert: (self unConfiguredQuery type: FamixTClass) isValid.
	self deny: (self newQuery type: 'Not a type') isValid
]

{ #category : #'tests - printing' }
FQTypeQueryTest >> testName [
	self assert: query name equals: 'Classes, Methods'.
	self assert: self unConfiguredQuery name equals: 'Invalid Type Query'
]

{ #category : #'tests - adding - removing' }
FQTypeQueryTest >> testRemoveType [
	query removeType: FamixStMethod.
	self deny: (query types includes: FamixStMethod).
	self
		should: [ query removeType: FamixStClass ]
		raise: FQCannotRemoveLastType
]

{ #category : #'tests - running' }
FQTypeQueryTest >> testRunOn [
	self assert: self expectedResult isNotEmpty.

	"Classes"
	self assertRunOnResult.

	"Traits"
	query := self unConfiguredQuery
		type: FamixTClass;
		type: FamixTMethod.
	self assertRunOnResult.

	"Both"
	query := self unConfiguredQuery
		type: FamixStClass;
		type: FamixTMethod.
	self assertRunOnResult
]

{ #category : #tests }
FQTypeQueryTest >> testSyntacticSugar [
	query := self unConfiguredQuery type: FamixTMethod.
	self assertCollection: query types hasSameElements: {FamixTMethod}.
	
	query type: FamixStClass.
	self
		assertCollection: query types
		hasSameElements:
			{FamixTMethod.
			FamixStClass}
]

{ #category : #'tests - adding - removing' }
FQTypeQueryTest >> testTypes [
	query := self unConfiguredQuery.
	query
		types:
			{FamixStMethod.
			FamixStClass}.
	self
		assert:
			(query types
				includesAll:
					{FamixStMethod.
					FamixStClass})
]
