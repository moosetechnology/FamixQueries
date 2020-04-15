Class {
	#name : #FQTypeQueriesPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #helpers }
FQTypeQueriesPresenterTest >> actualPresenterClass [
	^ FQTypeQueriesPresenter
]

{ #category : #running }
FQTypeQueriesPresenterTest >> setUp [
	helper := FQPresenterTestsHelper new.
	presenter := self actualPresenterClass on: helper classesAndMethods
]

{ #category : #tests }
FQTypeQueriesPresenterTest >> testCheckBoxesAction [
	| checkBoxes initialSize |
	checkBoxes := presenter secondParameter presenters
		reject: [ :pres | pres class = SpNullPresenter ].
	initialSize := presenter queryBuilder currentQueryTypes size.	
		
	checkBoxes first click.
	self
		assert: presenter queryBuilder currentQueryTypes size
		equals: initialSize - 1.
	
	checkBoxes first click.
	self
		assert: presenter queryBuilder currentQueryTypes size
		equals: initialSize
]

{ #category : #tests }
FQTypeQueriesPresenterTest >> testCheckBoxesMatchAvailableTypes [
	| checkBoxes types |
	
	checkBoxes := presenter secondParameter presenters
		reject: [ :pres | pres class = SpNullPresenter ].
	types := presenter queryBuilder availableTypes.
	
	self assert: checkBoxes size equals: types size.

	types
		do: [ :type | 
			self assert:
				((checkBoxes collect: #label)
					includes: (type name withoutPrefix: presenter modelPrefix)) ]
]

{ #category : #tests }
FQTypeQueriesPresenterTest >> testCheckBoxesMatchQuery [
	| checkBoxes |
	checkBoxes := presenter secondParameter presenters
		reject: [ :pres | pres class = SpNullPresenter ].
	
	checkBoxes first click.
	
	presenter queryBuilder currentQueryTypes
		do: [ :type | | typeName |
			typeName := type name withoutPrefix: presenter modelPrefix.
			self assert:
				((checkBoxes select: #state thenCollect: #label) includes: typeName).
			self deny:
				((checkBoxes reject: #state thenCollect: #label) includes: typeName) ]
]

{ #category : #running }
FQTypeQueriesPresenterTest >> testFirstParameter [
	self
		assert: presenter firstParameter class
		identicalTo: SpNullPresenter
]

{ #category : #tests }
FQTypeQueriesPresenterTest >> testLastCheckBoxeDisabled [
	| checkBoxes |
	checkBoxes := presenter secondParameter presenters
		reject: [ :pres | pres class = SpNullPresenter ].
	
	checkBoxes first click.

	self assert: checkBoxes first isEnabled.
	self deny: checkBoxes first state.
	
	self deny: checkBoxes second isEnabled.
	self assert: checkBoxes second state.
]

{ #category : #running }
FQTypeQueriesPresenterTest >> testQueryBuilderInitialization [
	"Normal initialization"
	self assert: presenter queryBuilder class identicalTo: FQTypeQueryBuilder.
	self assert: presenter queryBuilder query class identicalTo: FQTypeQuery.
	self assert: presenter queryBuilder queryIsValid.

	"Impossible initialization"
	presenter := self actualPresenterClass on: helper noEntities.
	self assert: presenter queryBuilder class identicalTo: FQTypeQueryBuilder.
	self assert: presenter queryBuilder query class identicalTo: FQTypeQuery.
	self deny: presenter queryBuilder queryIsValid.
]

{ #category : #running }
FQTypeQueriesPresenterTest >> testSecondParameter [
	self
		assert:
			(presenter secondParameter presenters
				allSatisfy:
					[ :pres | pres class == SpCheckBoxPresenter 
					"Could be some SpNullPresenter depending on the dynamic layout 
					but it is not the case here, since there is only 2 types"
					and: [ pres state ] ]).
				
	presenter := self actualPresenterClass on: helper noEntities.
	self
		assert: presenter secondParameter class
		identicalTo: FQNoPossibleQueryPresenter
]
