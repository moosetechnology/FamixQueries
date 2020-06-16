Class {
	#name : #FQUnionQueryTest,
	#superclass : #FQBinaryQueryTest,
	#category : #'Famix-Queries-Tests-Binary'
}

{ #category : #running }
FQUnionQueryTest >> actualClass [
	^ FQUnionQuery
]

{ #category : #running }
FQUnionQueryTest >> expectedPrintOnString [
	^ 'a FQUnionQuery (' , self firstParentOfQuery name , ' | '
		, self secondParentOfQuery name , ')'
]

{ #category : #running }
FQUnionQueryTest >> expectedResult [
	^ (self firstParentOfQuery runOn: helper classesAndMethods)
		union: (self secondParentOfQuery runOn: helper classesAndMethods)
]

{ #category : #'tests - printing' }
FQUnionQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			'((aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: ({ FamixStReference . FamixStInheritance } flatCollect: [ :association | (entity queryIncoming: association) opposites ]).
			result ]) asMooseGroup) | (aMooseGroup allWithType: FamixStClass)'
]

{ #category : #'tests - printing' }
FQUnionQueryTest >> testName [
	self
		assert: query name
		equals: 'Incoming References, Inheritances | Classes'.
	self assert: self unConfiguredQuery name equals: 'Invalid Union'
]
