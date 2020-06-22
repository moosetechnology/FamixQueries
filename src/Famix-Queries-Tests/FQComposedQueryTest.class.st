Class {
	#name : #FQComposedQueryTest,
	#superclass : #FQUnaryQueryTest,
	#category : #'Famix-Queries-Tests-Unary'
}

{ #category : #running }
FQComposedQueryTest >> actualClass [
	^ FQComposedQuery
]

{ #category : #running }
FQComposedQueryTest >> expectedPrintOnString [
	^ 'a FQComposedQuery (No name)'
]

{ #category : #running }
FQComposedQueryTest >> expectedResult [
	| numericResult classes abstractClasses methods scopedClasses |
	numericResult := helper classesAndMethods
		select: [ :entity | entity numberOfLinesOfCode > 20 ].
	classes := numericResult allWithType: FamixStClass.
	abstractClasses := classes select: #isDead.
	methods := numericResult allWithType: FamixStMethod.
	scopedClasses := methods
		flatCollect: [ :m | m atScope: FamixStClass ].
	^ abstractClasses union: scopedClasses
]

{ #category : #running }
FQComposedQueryTest >> newQuery [
	| numericQuery classQuery booleanQuery methodQuery scopeToClassQuery unionQuery |
	numericQuery := FQNumericQuery new
		property: #numberOfLinesOfCode;
		comparator: #>;
		valueToCompare: 20.
	classQuery := FQTypeQuery new
		type: FamixStClass;
		parent: numericQuery.
	booleanQuery := FQBooleanQuery new
		property: #isDead;
		parent: classQuery.
	methodQuery := FQTypeQuery new
		type: FamixStMethod;
		parent: numericQuery.
	scopeToClassQuery := FQScopeQuery up
		scope: FamixStClass;
		parent: methodQuery.
	unionQuery := FQUnionQuery new
		parents:
			{booleanQuery.
			scopeToClassQuery}.
	^ FQComposedQuery new
		queries:
			{numericQuery.
			classQuery.
			booleanQuery.
			methodQuery.
			scopeToClassQuery.
			unionQuery}
]

{ #category : #'tests - printing' }
FQComposedQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			'(((aMooseGroup select: [ :entity | entity numberOfLinesOfCode > 20 ]) allWithType: FamixStClass) select: [ :entity | entity isDead ]) | ((MooseObjectQueryResult withAll: ((aMooseGroup select: [ :entity | entity numberOfLinesOfCode > 20 ]) allWithType: FamixStMethod)) atScope: FamixStClass)'
]

{ #category : #'tests - printing' }
FQComposedQueryTest >> testName [
	self assert: query name equals: 'No name'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Composed Query'
]

{ #category : #'tests - running' }
FQComposedQueryTest >> testRoots [
	self assert: query roots size equals: 1.
	query := self actualClass
		queries:
			(FQTypeQuery types: {FamixStClass})
				| (FQBooleanQuery property: #isAbstract).
	self assert: query roots size equals: 2
]

{ #category : #'tests - running' }
FQComposedQueryTest >> testRunOn [
	self assert: self expectedResult isNotEmpty.
	self
		assertCollection: (query runOn: helper classesAndMethods)
		hasSameElements: self expectedResult
]
