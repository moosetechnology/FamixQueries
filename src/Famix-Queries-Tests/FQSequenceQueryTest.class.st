Class {
	#name : #FQSequenceQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Combinator'
}

{ #category : #helpers }
FQSequenceQueryTest >> actualClass [
	self
		flag: #FQUnused , 'this class is not useful, maybe it shoud be removed.'.
	^ FQSequenceQuery
]

{ #category : #tests }
FQSequenceQueryTest >> testDisplayOn [
	| subQuery1 subQuery2 |
	subQuery1 := FQBooleanQuery forProperty: #isInstanceSide.
	subQuery2 := FQStringQuery forProperty: #name comparator: #includesSubstring:  withValue: 'LANP'.
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
FQSequenceQueryTest >> testEquals [
	| subQuery1 subQuery2 |
	subQuery1 := FQBooleanQuery forProperty: #isInstanceSide.
	subQuery2 := FQBooleanQuery forProperty: #isAbstract.
	query := self actualClass
		forQueries:
			{subQuery1.
			subQuery2}.

	"Same query"
	self
		assert: query
		equals:
			(self actualClass
				forQueries:
					{subQuery1.
					subQuery2}).
	
	"Children in different order"
	self
		deny: query
		equals:
			(self actualClass
				forQueries:
					{subQuery2.
					subQuery1}).
	
	"Different children"
	self
		deny: query
		equals:
			(self actualClass
				forQueries:
					{subQuery1.
					(FQTypeQuery forType: FamixStClass)})
]

{ #category : #tests }
FQSequenceQueryTest >> testIsValid [
	| subQuery1 subQuery2 invalidQuery |
	subQuery1 := FQBooleanQuery forProperty: #isInstanceSide.
	subQuery2 := FQBooleanQuery forProperty: #isAbstract.
	invalidQuery := FQBooleanQuery new.
	query := self actualClass
		forQueries:
			{subQuery1.
			subQuery2}.
			
	self assert: query isValid.
	
	query := self actualClass
		forQueries:
			{subQuery1.
			invalidQuery}.
	self deny: query isValid.
]

{ #category : #tests }
FQSequenceQueryTest >> testRunOn [
	| classes subQuery1 subQuery2 queryResult expectedResult |
	classes := model allModelClasses.
	
	subQuery1 := FQBooleanQuery forProperty: #isInstanceSide.
	subQuery2 := FQStringQuery forProperty: #name comparator: #includesSubstring:  withValue: 'LANP'.
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
