Class {
	#name : #FQSubtractionQueryTest,
	#superclass : #FQBinaryQueryTest,
	#category : #'Famix-Queries-Tests-Binary'
}

{ #category : #running }
FQSubtractionQueryTest >> actualClass [
	^ FQSubtractionQuery
]

{ #category : #running }
FQSubtractionQueryTest >> expectedPrintOnString [

	^ 'a FQSubtractionQuery (' , self firstParentOfQuery name , ' \ '
	  , self secondParentOfQuery name , ')'
]

{ #category : #running }
FQSubtractionQueryTest >> expectedResult [
	^ (self firstParentOfQuery runOn: helper classesAndMethods)
		difference: (self secondParentOfQuery runOn: helper classesAndMethods)
]

{ #category : #'tests - printing' }
FQSubtractionQueryTest >> testDisplayOn [
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
FQSubtractionQueryTest >> testName [
	self
		assert: query name
		equals: 'Incoming References, Inheritances \ Classes'.
	self
		assert: self unConfiguredQuery name
		equals: 'Invalid Substraction'
]

{ #category : #tests }
FQSubtractionQueryTest >> testReversParents [
	| parent1 parent2 |
	parent1 := self firstParentOfQuery.
	parent2 := self secondParentOfQuery.
	
	query reverseParents.
	
	self assert: self firstParentOfQuery identicalTo: parent2.
	self assert: self secondParentOfQuery identicalTo: parent1
]
