Class {
	#name : #FQResultSizeQueryTest,
	#superclass : #FQUnaryQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #running }
FQResultSizeQueryTest >> actualClass [

	^ FQResultSizeQuery
]

{ #category : #running }
FQResultSizeQueryTest >> expectedPrintOnString [

	^ 'a FQResultSizeQuery (({1}) size > 20)' format:
		  { self innerQuery name }
]

{ #category : #running }
FQResultSizeQueryTest >> expectedResult [

	^ helper classes select: [ :class | 
		  (self innerQuery runOn: class asMooseGroup) size > 20 ]
]

{ #category : #running }
FQResultSizeQueryTest >> innerQuery [

	^ FQScopeQuery down scope: FamixStMethod
]

{ #category : #running }
FQResultSizeQueryTest >> newQuery [

	^ FQResultSizeQuery new
		  innerQuery: self innerQuery;
		  comparator: #>;
		  valueToCompare: 20
]

{ #category : #tests }
FQResultSizeQueryTest >> testDependencies [

	| q1 q2 |
	q1 := FQBooleanQuery property: #isStub.
	q1 parent: self newParentQuery.
	q2 := FQBooleanQuery property: #isDead.
	q2 parent: q1.
	query parent: q2.
	self assert: query dependencies asArray equals: { query innerQuery. q2. q1 }
]

{ #category : #'tests - printing' }
FQResultSizeQueryTest >> testDisplayOn [

	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
		'aMooseGroup select: [ :entity | ((MooseObjectQueryResult withAll: entity asMooseGroup) toScope: FamixStMethod) size > 20 ]'
]

{ #category : #'tests - printing' }
FQResultSizeQueryTest >> testName [

	self assert: query name equals: '(Down to Methods) size > 20'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Result Size Query'
]

{ #category : #'tests - running' }
FQResultSizeQueryTest >> testRunOn [

	self assert: self expectedResult isNotEmpty.
	self
		assertCollection: (query runOn: helper classes)
		hasSameElements: self expectedResult
]
