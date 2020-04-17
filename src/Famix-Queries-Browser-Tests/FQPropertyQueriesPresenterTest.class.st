Class {
	#name : #FQPropertyQueriesPresenterTest,
	#superclass : #FQQueryConfigurationPresenterTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #helpers }
FQPropertyQueriesPresenterTest >> presenterClass [
	^ FQPropertyQueriesPresenter
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

	presenter := self presenterClass on: helper noEntities.
	self assert:
		(presenter firstParameter presenters
			allSatisfy: [ :pres | pres class == SpRadioButtonPresenter ])
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testNoAvailableProperties [
	presenter := self presenterClass on: helper noEntities.
	(self radioButtons detect: [ :rb | rb label = 'Number' ]) click.
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
	
	(self radioButtons detect: [ :rb | rb label ='Number' ]) click.
	self assert: presenter secondParameter class identicalTo: FQNumericQueryParametersPresenter.
	
	(self radioButtons detect: [ :rb | rb label ='String' ]) click.
	self assert: presenter secondParameter class identicalTo: FQStringQueryParametersPresenter
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testQueryType [
	(self radioButtons detect: [ :rb | rb label ='Boolean' ]) click.
	self assert: self queryBuilder query class identicalTo: FQBooleanQuery.
	
	(self radioButtons detect: [ :rb | rb label ='Number' ]) click.
	self assert: self queryBuilder query class identicalTo: FQNumericQuery.
	
	(self radioButtons detect: [ :rb | rb label ='String' ]) click.
	self assert: self queryBuilder query class identicalTo: FQStringQuery.
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testQueryValidity [
	self assert: self queryBuilder queryIsValid.
	
	(self radioButtons detect: [ :rb | rb state not ]) click.
	self assert: self queryBuilder queryIsValid.
	
	presenter := self presenterClass on: helper noEntities.
	self deny: self queryBuilder queryIsValid
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
		assert: presenter secondParameter class label
		equals: (self radioButtons detect: #state) label.
	
	presenter := self presenterClass on: helper noEntities.
	self
		assert: presenter secondParameter class
		identicalTo: FQNoPossibleQueryPresenter
]

{ #category : #tests }
FQPropertyQueriesPresenterTest >> testSubPresenterMatchesRadioButton [
	| initialQueryBuilderClass |
	
	initialQueryBuilderClass := self queryBuilder class.
	self
		assert: presenter secondParameter class queryBuilderClass
		equals: initialQueryBuilderClass.
	
	(self radioButtons detect: [ :rb | rb state not ]) click.
	
	self deny: self queryBuilder class equals: initialQueryBuilderClass.
	self
		assert: presenter secondParameter class queryBuilderClass
		equals: self queryBuilder class.
]
