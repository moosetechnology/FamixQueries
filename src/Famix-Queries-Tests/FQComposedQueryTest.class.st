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
		beChildOf: numericQuery.
	booleanQuery := FQBooleanQuery new
		property: #isDead;
		beChildOf: classQuery.
	methodQuery := FQTypeQuery new
		type: FamixStMethod;
		beChildOf: numericQuery.
	scopeToClassQuery := FQScopeQuery up
		scope: FamixStClass;
		beChildOf: methodQuery.
	unionQuery := FQUnionQuery new
		beChildOf:
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

{ #category : #tests }
FQComposedQueryTest >> testBeChildOf [
	| parent |
	parent := self differentTypeOfQuery.
	query beChildOf: parent.
	self assert: query parent identicalTo: parent.
	query roots
		do: [ :root | self assert: root parent identicalTo: parent ].
	self assert: parent children size equals: 1.
	self assert: parent children anyOne identicalTo: query
]

{ #category : #tests }
FQComposedQueryTest >> testCopy [
	| copy |
	query beChildOf: self differentTypeOfQuery.
	self differentTypeOfQuery beChildOf: query.

	"Copy"
	copy := query copy.
	self assert: copy parent isNil.
	copy roots do: [ :root | self assert: root parent isNil ].
	self assert: copy leaf children isEmpty.

	"Inner queries are copies"
	query queries
		with: copy queries
		do: [ :original :innerCopy | self deny: original identicalTo: innerCopy ].

	"Equal parent needed to be equal"
	copy beChildOf: self differentTypeOfQuery.
	self assert: (copy hasSameParametersAs: query)
]

{ #category : #tests }
FQComposedQueryTest >> testCopyDoesNotIncludeParentAndChildren [
	| copy parent child |
	parent := self differentTypeOfQuery.
	query beChildOf: parent.
	child := self differentTypeOfQuery.
	child beChildOf: query.
	copy := query copy.

	"Copy does not include parent"
	self deny: (copy queries anySatisfy: [ :q | q == parent ]).

	"Copy does not include child"
	self deny: (copy queries anySatisfy: [ :q | q == child ]).
	self assert: copy children isEmpty
]

{ #category : #tests }
FQComposedQueryTest >> testCopyGetsCorrectChildren [
	| copy numQ classQ boolQ methQ scopeQ unionQ |
	copy := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).

	"Queries"
	numQ := copy queries first.
	classQ := copy queries second.
	boolQ := copy queries third.
	methQ := copy queries fourth.
	scopeQ := copy queries fifth.
	unionQ := copy queries sixth.

	"Children"
	self
		assertCollection: numQ children asArray
		hasSameElements:
			{classQ.
			methQ}.
	self assert: classQ children anyOne identicalTo: boolQ.
	self assert: boolQ children anyOne identicalTo: unionQ.
	self assert: methQ children anyOne identicalTo: scopeQ.
	self assert: scopeQ children anyOne identicalTo: unionQ.
	self assert: unionQ children isEmpty
]

{ #category : #tests }
FQComposedQueryTest >> testCopyGetsCorrectParents [
	| copy parent numQ classQ boolQ methQ scopeQ unionQ |
	copy := self
		evaluate: (String streamContents: [ :s | query storeOn: s ]).

	"queries"
	numQ := copy queries first.
	classQ := copy queries second.
	boolQ := copy queries third.
	methQ := copy queries fourth.
	scopeQ := copy queries fifth.
	unionQ := copy queries sixth.

	"Parents"
	self assert: numQ parent isNil.
	self assert: classQ parent identicalTo: numQ.
	self assert: boolQ parent identicalTo: classQ.
	self assert: methQ parent identicalTo: numQ.
	self assert: scopeQ parent identicalTo: methQ.
	self assert: unionQ parents first identicalTo: boolQ.
	self assert: unionQ parents second identicalTo: scopeQ.

	"New parent"
	parent := self differentTypeOfQuery.
	copy beChildOf: parent.
	self assert: numQ parent identicalTo: parent
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

{ #category : #tests }
FQComposedQueryTest >> testReset [
	query beChildOf: self differentTypeOfQuery.
	self differentTypeOfQuery beChildOf: query.

	"Reset"
	query reset.
	self assert: query parent isNil.
	query roots do: [ :root | self assert: root parent isNil ].
	self assert: query leaf children isEmpty
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

{ #category : #tests }
FQComposedQueryTest >> testStoreOn [
]
