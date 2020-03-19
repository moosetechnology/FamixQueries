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
	subQuery1 := FQBooleanQuery fromProperty: #isAbstract.
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
					s << '('.
					subQuery1 displayOn: s.
					s << ') \ ('.
					subQuery2 displayOn: s.
					s << ')' ])
]

{ #category : #tests }
FQSubstractionQueryTest >> testRunOn [
	| classes subQuery1 subQuery2 queryResult expectedResult |

	classes := model allModelClasses.

	subQuery1 := FQBooleanQuery fromProperty: #isInstanceSide.
	subQuery2 := FQStringQuery fromProperty: #name comparator: #includesSubstring:  withValue: 'LANP'.
	query := self actualClass
		forQueries:
			{subQuery1.
			subQuery2}.

	queryResult := query runOn: classes.
	expectedResult := (subQuery1 runOn: classes)
		difference: (subQuery2 runOn: classes).
	
	self assert: expectedResult isNotEmpty.
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]
