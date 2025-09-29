Class {
	#name : 'FQRelationQueryTest',
	#superclass : 'FQUnaryQueryTest',
	#category : 'Famix-Queries-Tests-Unary',
	#package : 'Famix-Queries-Tests',
	#tag : 'Unary'
}

{ #category : 'running' }
FQRelationQueryTest >> actualClass [

	^ FQRelationQuery
]

{ #category : 'running' }
FQRelationQueryTest >> expectedPrintOnString [

	^ 'a FQRelationQuery (relation named: #instances)'
]

{ #category : 'running' }
FQRelationQueryTest >> expectedResult [

	^ helper modelExample allAnnotationInstances
]

{ #category : 'running' }
FQRelationQueryTest >> newQuery [

	^ self unConfiguredQuery
		  relationName: #instances;
		  yourself
]

{ #category : 'tests - printing' }
FQRelationQueryTest >> testDisplayOn [

	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
		'(MooseObjectQueryResult withAll: aMooseGroup) relationsNamed: #instances'
]

{ #category : 'tests' }
FQRelationQueryTest >> testName [

	self assert: query name equals: 'relation named: #instances'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Relation Query'
]

{ #category : 'tests - running' }
FQRelationQueryTest >> testRunOn [

	self assert: self expectedResult isNotEmpty.
	self
		assertCollection:
		(query runOn: helper modelExample allAnnotationTypes)
		hasSameElements: self expectedResult.
]
