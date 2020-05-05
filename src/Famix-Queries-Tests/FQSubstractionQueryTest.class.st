Class {
	#name : #FQSubstractionQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Combinator'
}

{ #category : #helpers }
FQSubstractionQueryTest >> actualClass [
	^ FQSubstractionQuery
]

{ #category : #tests }
FQSubstractionQueryTest >> testDisplayOn [
	| subQuery1 subQuery2 |
	subQuery1 := FQBooleanQuery forProperty: #isAbstract.
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
					s << '('.
					subQuery1 displayOn: s.
					s << ') \ ('.
					subQuery2 displayOn: s.
					s << ')' ])
]

{ #category : #tests }
FQSubstractionQueryTest >> testEquals [
	| subQuery1 subQuery2 |
	subQuery1 := FQBooleanQuery forProperty: #isInstanceSide.
	subQuery2 := FQBooleanQuery forProperty: #isAbstract.
	query := self actualClass
		forQueries:
			{subQuery1.
			subQuery2}.
	
	"Same children"
	self
		assert: query
		equals:
			(self actualClass
				forQueries:
					{subQuery1.
					subQuery2}).
					
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
FQSubstractionQueryTest >> testIsValid [
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
FQSubstractionQueryTest >> testRunOn [
	| classes subQuery1 subQuery2 queryResult expectedResult |
	self flag: #FQImprove , 'runOn: behavior has changed for combinator queries'.
	classes := model allModelClasses.

	subQuery1 := FQBooleanQuery forProperty: #isInstanceSide.
	subQuery2 := FQStringQuery forProperty: #name comparator: #includesSubstring:  withValue: 'LANP'.
	query := self actualClass
		forQueries:
			{subQuery1.
			subQuery2}.

	queryResult := query runOn: ({subQuery1. subQuery2} collect: [ :q | q runOn: classes ]).
	expectedResult := (subQuery1 runOn: classes)
		difference: (subQuery2 runOn: classes).
	
	self assert: expectedResult isNotEmpty.
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]
