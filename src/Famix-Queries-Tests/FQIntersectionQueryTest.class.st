Class {
	#name : #FQIntersectionQueryTest,
	#superclass : #FQBinaryQueryTest,
	#category : #'Famix-Queries-Tests-Binary'
}

{ #category : #running }
FQIntersectionQueryTest >> actualClass [
	^ FQIntersectionQuery
]

{ #category : #running }
FQIntersectionQueryTest >> expectedPrintOnString [
	^ 'a FQIntersectionQuery (' , self firstParentOfQuery name , ' & '
		, self secondParentOfQuery name , ')'
]

{ #category : #running }
FQIntersectionQueryTest >> expectedResult [
	^ (self firstParentOfQuery runOn: helper classesAndMethods)
		intersection: (self secondParentOfQuery runOn: helper classesAndMethods)
]

{ #category : #'tests - printing' }
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

{ #category : #'tests - printing' }
FQIntersectionQueryTest >> testName [
	self
		assert: query name
		equals: 'Incoming References, Inheritances & Classes'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Intersection'
]
