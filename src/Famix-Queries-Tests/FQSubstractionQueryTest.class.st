Class {
	#name : #FQSubstractionQueryTest,
	#superclass : #FQBinaryQueryTest,
	#category : #'Famix-Queries-Tests-Binary'
}

{ #category : #running }
FQSubstractionQueryTest >> actualClass [
	^ FQSubstractionQuery
]

{ #category : #running }
FQSubstractionQueryTest >> expectedPrintOnString [
	^ 'a FQSubstractionQuery (' , self firstParentOfQuery name , ' \ '
		, self secondParentOfQuery name , ')'
]

{ #category : #running }
FQSubstractionQueryTest >> expectedResult [
	^ (self firstParentOfQuery runOn: helper classesAndMethods)
		difference: (self secondParentOfQuery runOn: helper classesAndMethods)
]

{ #category : #'tests - printing' }
FQSubstractionQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			'((aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: ({ FamixStReference . FamixStInheritance } flatCollect: [ :association | (entity queryIncoming: association) opposites ]).
			result ]) asMooseGroup) \ (aMooseGroup allWithType: FamixStClass)'
]

{ #category : #'tests - printing' }
FQSubstractionQueryTest >> testName [
	self
		assert: query name
		equals: 'Incoming References, Inheritances \ Classes'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Substraction'
]

{ #category : #tests }
FQSubstractionQueryTest >> testReversParents [
	| parent1 parent2 |
	parent1 := self firstParentOfQuery.
	parent2 := self secondParentOfQuery.
	
	query reverseParents.
	
	self assert: self firstParentOfQuery identicalTo: parent2.
	self assert: self secondParentOfQuery identicalTo: parent1
]
