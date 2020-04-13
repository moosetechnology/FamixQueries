Class {
	#name : #FQSequenceQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Combinator'
}

{ #category : #helpers }
FQSequenceQueryTest >> actualClass [
	^ FQSequenceQuery
]

{ #category : #tests }
FQSequenceQueryTest >> testDisplayOn [
	| subQuery1 subQuery2 |
	subQuery1 := FQBooleanQuery fromProperty: #isInstanceSide.
	subQuery2 := FQStringQuery fromProperty: #name comparator: #includesSubstring:  withValue: 'LANP'.
	query := self actualClass
		forQueries:
			{subQuery1.
			subQuery2}.
	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			(String
				streamContents: [ :s | 
					s
						<<
							'(aMooseGroup select: [ :entity | entity isInstanceSide ])
	 select: [ :entity | entity name includesSubstring: ''LANP'' ]' ])
]

{ #category : #tests }
FQSequenceQueryTest >> testRunOn [
	| classes subQuery1 subQuery2 queryResult expectedResult |
	classes := model allModelClasses.
	
	subQuery1 := FQBooleanQuery fromProperty: #isInstanceSide.
	subQuery2 := FQStringQuery fromProperty: #name comparator: #includesSubstring:  withValue: 'LANP'.
	query := self actualClass
		forQueries:
			{subQuery1.
			subQuery2}.
	
	queryResult := query runOn: classes.
	expectedResult :=  (subQuery2 runOn: (subQuery1 runOn: classes)).

	self assert: expectedResult isNotEmpty.
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]
