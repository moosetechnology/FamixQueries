Class {
	#name : 'FQIntersectionQueryTest',
	#superclass : 'FQNAryQueryTest',
	#category : 'Famix-Queries-Tests-N-ary',
	#package : 'Famix-Queries-Tests',
	#tag : 'N-ary'
}

{ #category : 'running' }
FQIntersectionQueryTest >> actualClass [
	^ FQIntersectionQuery
]

{ #category : 'running' }
FQIntersectionQueryTest >> expectedPrintOnString [
	^ 'a FQIntersectionQuery (' , self firstParentOfQuery name , ' & '
		, self secondParentOfQuery name , ')'
]

{ #category : 'running' }
FQIntersectionQueryTest >> expectedResult [
	^ (self firstParentOfQuery runOn: helper classesAndMethods)
		intersection: (self secondParentOfQuery runOn: helper classesAndMethods)
]

{ #category : 'tests - printing' }
FQIntersectionQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			'((aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: ({ FamixStReference . FamixStInheritance } flatCollect: [ :association | (entity queryIncoming: association) opposites ]).
			result ]) asMooseGroup) & (aMooseGroup allWithType: FamixStClass)'
]

{ #category : 'tests - printing' }
FQIntersectionQueryTest >> testName [

	self
		assert: query name
		equals: 'Incoming References, Inheritances & Classes'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid And Query'
]
