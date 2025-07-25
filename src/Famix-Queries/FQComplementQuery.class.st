"
A complement query can be seen as a ""negation"" query. In simple words, it returns the complement of the `queryToNegate` result.
In order to do that, this query is instantiated with a query to negate. It takes `queryToNegate parent result`. This returns all the entities (`allEntities`). And then it does the substraction of the current result (`queryToNegate result`) with allEntities.
This (`allEntities - queryToNegate result`) gives the complement of the current result
"
Class {
	#name : 'FQComplementQuery',
	#superclass : 'FQAbstractQuery',
	#instVars : [
		'queryToNegate'
	],
	#category : 'Famix-Queries-Complement-Query',
	#package : 'Famix-Queries',
	#tag : 'Complement-Query'
}

{ #category : 'accessing' }
FQComplementQuery class >> label [

	^ 'Negation Query'
]

{ #category : 'accessing' }
FQComplementQuery class >> queryToNegate: aQuery [

	^ self new
		  queryToNegate: aQuery;
		  yourself
]

{ #category : 'default' }
FQComplementQuery >> beDefaultForParent [
	"Nothing to do"

	
]

{ #category : 'running' }
FQComplementQuery >> computeResult [

	^ result := self isValid
		            ifTrue: [ self runOn: queryToNegate parent result ]
		            ifFalse: [ MooseGroup new ]
]

{ #category : 'printing' }
FQComplementQuery >> defaultName [

	^ '(' , queryToNegate name , ') not'
]

{ #category : 'accessing' }
FQComplementQuery >> dependencies [

	^ OrderedCollection with: queryToNegate
]

{ #category : 'printing' }
FQComplementQuery >> displayOn: aStream [

	aStream << 'aMooseGroup copyWithoutAll: ' << $(.
	queryToNegate displayOn: aStream.
	aStream << $)
]

{ #category : 'accessing' }
FQComplementQuery >> hasSameParametersAs: aQuery [

	^ aQuery queryToNegate = queryToNegate
]

{ #category : 'comparing' }
FQComplementQuery >> hash [

	^ super hash bitXor: queryToNegate hash
]

{ #category : 'testing' }
FQComplementQuery >> isValid [

	^ queryToNegate isNotNil and: [ queryToNegate isValid ]
]

{ #category : 'accessing' }
FQComplementQuery >> parentSequence [

	"This query has no parent"

	^ #(  )
]

{ #category : 'removing' }
FQComplementQuery >> prepareRemoval [

	queryToNegate := nil
]

{ #category : 'accessing' }
FQComplementQuery >> queryToNegate [

	^ queryToNegate
]

{ #category : 'accessing' }
FQComplementQuery >> queryToNegate: aQuery [

	queryToNegate := aQuery
]

{ #category : 'running' }
FQComplementQuery >> rawRunOn: allEntitiesMooseGroup [

	| newItems |
	newItems := allEntitiesMooseGroup asSet.
	newItems removeAllFoundIn: (queryToNegate runOn: allEntitiesMooseGroup).
	^ newItems
]

{ #category : 'execution' }
FQComplementQuery >> rootQuery: aFQRootQuery [

	queryToNegate rootQuery: aFQRootQuery
]

{ #category : 'printing' }
FQComplementQuery >> storeOn: aStream [

	aStream << self className.
	queryToNegate ifNil: [ ^ self ].
	aStream << ' queryToNegate: ('.
	queryToNegate storeWithParentsOn: aStream.
	aStream << $)
]

{ #category : 'printing' }
FQComplementQuery >> storeWithParentsOn: aStream [

	aStream << '('.
	self storeOn: aStream.
	aStream << ')'
]
