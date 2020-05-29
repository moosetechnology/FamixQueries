Class {
	#name : #FQPropertyQueriesPresenterTest,
	#superclass : #FQQueryConfigurationPresenterTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #helpers }
FQPropertyQueriesPresenterTest >> classToTest [
	^ FQPropertyQueriesPresenter
]

{ #category : #helpers }
FQPropertyQueriesPresenterTest >> queryClass [
	^ FQPropertyQuery
]

{ #category : #helpers }
FQPropertyQueriesPresenterTest >> radioButtons [
	^ presenter firstParameter presenters
		reject: [ :pres | pres class = SpNullPresenter ]
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testFirstParameter [
	self assert:
		(presenter firstParameter presenters
			allSatisfy: [ :pres | pres class == SpRadioButtonPresenter ]).

	self resetPresenterWithEntities: helper noEntities.
	self assert:
		(presenter firstParameter presenters
			allSatisfy: [ :pres | pres class == SpRadioButtonPresenter ])
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testNoAvailableProperties [
	self resetPresenterWithEntities: helper noEntities.
	(self radioButtons detect: [ :rb | rb label = 'Numeric' ]) click.
	self
		assert: presenter secondParameter class
		identicalTo: FQNoPossibleQueryPresenter.
	(self radioButtons detect: [ :rb | rb label = 'String' ]) click.
	self
		assert: presenter secondParameter class
		identicalTo: FQNoPossibleQueryPresenter.
	(self radioButtons detect: [ :rb | rb label = 'Boolean' ]) click.
	self
		assert: presenter secondParameter class
		identicalTo: FQNoPossibleQueryPresenter
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testQueryBuilderType [
	(self radioButtons detect: [ :rb | rb label ='Boolean' ]) click.
	self assert: presenter secondParameter class identicalTo: FQBooleanQueryParametersPresenter.
	
	(self radioButtons detect: [ :rb | rb label ='Numeric' ]) click.
	self assert: presenter secondParameter class identicalTo: FQNumericQueryParametersPresenter.
	
	(self radioButtons detect: [ :rb | rb label ='String' ]) click.
	self assert: presenter secondParameter class identicalTo: FQStringQueryParametersPresenter
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testQueryType [
	(self radioButtons detect: [ :rb | rb label ='Boolean' ]) click.
	self assert: presenter query class identicalTo: FQBooleanQuery.
	
	(self radioButtons detect: [ :rb | rb label ='Numeric' ]) click.
	self assert: presenter query class identicalTo: FQNumericQuery.
	
	(self radioButtons detect: [ :rb | rb label ='String' ]) click.
	self assert: presenter query class identicalTo: FQStringQuery.
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testQueryValidity [
	self assert: presenter query isValid.
	
	(self radioButtons detect: [ :rb | rb state not ]) click.
	self assert: presenter query isValid.
	
	self resetPresenterWithEntities: helper noEntities.
	self deny: presenter query isValid
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testRadioButtonsMatchQuery [
	| initialQueryClass |
	initialQueryClass := self currentQuery class.
	self
		assert: (self radioButtons detect: #state) label
		equals: initialQueryClass label substrings first.
	
	(self radioButtons detect: [ :rb | rb state not ]) click.
	
	self
		assert: (self radioButtons detect: #state) label
		equals: self currentQuery class label substrings first.
	self deny: self currentQuery class identicalTo: initialQueryClass
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testSecondParameter [
	self
		assert: presenter secondParameter query class label substrings first
		equals: (self radioButtons detect: #state) label.
	
	self resetPresenterWithEntities: helper noEntities.
	self
		assert: presenter secondParameter class
		identicalTo: FQNoPossibleQueryPresenter
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testSubPresenterMatchesRadioButton [
	| initialQueryClass |
	
	initialQueryClass := presenter query class.
	self
		assert: presenter secondParameter query class
		equals: initialQueryClass.
	
	(self radioButtons detect: [ :rb | rb state not ]) click.
	
	self deny: presenter query class equals: initialQueryClass.
	self
		assert: presenter secondParameter query class
		equals: presenter query class.
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testUpdateCreationBrowser [
	self assertCreationPresenterWasUpdated.
	(self radioButtons detect: [ :rb | rb state not ]) click.
	self assertCreationPresenterWasUpdated
]
