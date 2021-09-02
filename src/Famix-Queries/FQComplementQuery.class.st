"
A complement query can be seen as a ""negation"" query. In simple words, it returns the complement of the `queryToNegate` result.
In order to do that, this query is instantiated with a query to negate. It takes `queryToNegate parent result`. This returns all the entities (`allEntities`). And then it does the substraction of the current result (`queryToNegate result`) with allEntities.
This (`allEntities - queryToNegate result`) gives the complement of the current result.

_Note: The `parent` instance variable, that is defined in `FQUnaryQuery`, is not used in this query. But, we set the value of parent variable as the same as `queryToNegate` value. This is for all the functionalities that are defined in the parent class (`FQUnaryQuery`) works without problem. Because the parent class uses the parent instance variable.
But keep in mind that this query does not have a parent, only a queryToNegate._
"
Class {
	#name : #FQComplementQuery,
	#superclass : #FQUnaryQuery,
	#instVars : [
		'queryToNegate'
	],
	#category : #'Famix-Queries-Queries-Unary'
}

{ #category : #default }
FQComplementQuery class >> defaultForParent: aQuery [

	^ self queryToNegate: aQuery
]

{ #category : #testing }
FQComplementQuery class >> isAvailableForQueriesSize: numberOfQueriesInPresenter [

	^ numberOfQueriesInPresenter > 0
]

{ #category : #accessing }
FQComplementQuery class >> label [

	^ 'Negation Query'
]

{ #category : #accessing }
FQComplementQuery class >> queryToNegate: aQuery [

	^ self new
		  queryToNegate: aQuery;
		  yourself
]

{ #category : #default }
FQComplementQuery >> beDefaultForParent [
	"Nothing to do"

	
]

{ #category : #running }
FQComplementQuery >> computeResult [

	^ result := self isValid
		            ifTrue: [ self runOn: queryToNegate parent result ]
		            ifFalse: [ MooseGroup new ]
]

{ #category : #printing }
FQComplementQuery >> defaultName [

	^ '(' , queryToNegate name , ') not'
]

{ #category : #printing }
FQComplementQuery >> displayOn: aStream with: aString [
	aStream << 'aMooseGroup copyWithoutAll: ' << aString
]

{ #category : #comparing }
FQComplementQuery >> hasSameParametersAs: aQuery [

	^ aQuery parent hasSameParametersAs: queryToNegate
]

{ #category : #testing }
FQComplementQuery >> isValid [

	| isParentValid isQuerytoNegateValid |
	isParentValid := parent isNotNil and: [ parent isValid ].
	isQuerytoNegateValid := queryToNegate isNotNil and: [ 
		                        queryToNegate isValid ].
	^ isParentValid and: [ isQuerytoNegateValid ]
]

{ #category : #accessing }
FQComplementQuery >> parent: aQuery [

	"This method is overridden only for the purpose of using the queryToNegate instance variable instead of parent. The queryToNegate instance variable was created only for better readability. Does not add any functionality."

	parent := aQuery.
	queryToNegate := aQuery
]

{ #category : #accessing }
FQComplementQuery >> queryToNegate: aQuery [

	queryToNegate := aQuery.
	parent := aQuery
]

{ #category : #running }
FQComplementQuery >> runOn: allEntitiesMooseGroup [

	"^ MooseGroup withAll:
		  (allEntitiesMooseGroup copyWithoutAll: (queryToNegate runOn: allEntitiesMooseGroup))"

	| newItems |
	newItems := allEntitiesMooseGroup asSet.
	newItems removeAllFoundIn:
		(queryToNegate runOn: allEntitiesMooseGroup).
	^ MooseGroup withAll: newItems
]

{ #category : #printing }
FQComplementQuery >> storeOn: aStream [

	aStream << self className << ' new beChildOf: ('.
	queryToNegate storeOn: aStream.
	aStream << $)
]
