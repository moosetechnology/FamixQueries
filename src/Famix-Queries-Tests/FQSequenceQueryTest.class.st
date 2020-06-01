Class {
	#name : #FQSequenceQueryTest,
	#superclass : #FQBinaryQueryTest,
	#category : #'Famix-Queries-Tests-Binary'
}

{ #category : #running }
FQSequenceQueryTest >> actualClass [
	self
		flag: #FQUnused , 'this class is not useful, should be removed or modified'.
	^ FQSequenceQuery
]

{ #category : #running }
FQSequenceQueryTest >> expectedPrintOnString [
	^ 'a FQSequenceQuery (' , self secondParentOfQuery name , ' then '
		, self firstParentOfQuery name , ')'
]

{ #category : #running }
FQSequenceQueryTest >> expectedResult [
	^ self secondParentOfQuery
		runOn: (self firstParentOfQuery runOn: helper classesAndMethods)
]

{ #category : #'tests - printing' }
FQSequenceQueryTest >> testDisplayOn [
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			'((aMooseGroup
		inject: Set new
		into: [ :result :entity | 
			result addAll: ({ FamixTReference . FamixTInheritance } flatCollect: [ :association | (entity queryIncoming: association) opposites ]).
			result ]) asMooseGroup)
	 allWithType: FamixStClass'
]

{ #category : #'tests - printing' }
FQSequenceQueryTest >> testName [
	self
		assert: query name
		equals: 'Classes then Incoming references, inheritances'.
	self assert: self unConfiguredQuery name equals: 'Invalid Sequence'
]
