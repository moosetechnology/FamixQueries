Class {
	#name : #FQComplementQueryTest,
	#superclass : #FQAbstractQueryTest,
	#category : #'Famix-Queries-Tests-Combinator'
}

{ #category : #helpers }
FQComplementQueryTest >> actualClass [
	^ FQComplementQuery
]

{ #category : #tests }
FQComplementQueryTest >> testDisplayOn [
	| subQuery |

	subQuery := FQBooleanQuery forProperty: #isInstanceSide.
	query := self actualClass forQuery: subQuery.

	self
		assert: (String streamContents: [ :s | query displayOn: s ])
		equals:
			(String
				streamContents: [ :s | 
					s << 'aMooseGroup copyWithoutAll: ('.
					subQuery displayOn: s.
					s << ')' ])
]

{ #category : #tests }
FQComplementQueryTest >> testRunOn [
	| classes subQuery queryResult expectedResult |
	classes := model allModelClasses.
	
	subQuery := FQBooleanQuery forProperty: #isInstanceSide. 
	query := self actualClass
		forQuery: subQuery.
	
	queryResult := query runOn: classes.
	expectedResult := classes copyWithoutAll: (subQuery runOn: classes).
	
	self assert: expectedResult isNotEmpty.
	self assert: queryResult size equals: expectedResult size.
	self assertCollection: queryResult hasSameElements: expectedResult
]
