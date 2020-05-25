Class {
	#name : #FQPropertyQueryParametersPresenterTest,
	#superclass : #SpTest,
	#instVars : [
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #testing }
FQPropertyQueryParametersPresenterTest class >> isAbstract [
	^ self == FQPropertyQueryParametersPresenterTest
]

{ #category : #asserting }
FQPropertyQueryParametersPresenterTest >> assertCreationPresenterWasUpdated [
	self
		assertCollection: presenter owner owner resultList items
		hasSameElements: presenter owner query result.
	self
		assert: (helper queryFromCodeInPresenter: presenter owner owner)
		equals: presenter owner query
]

{ #category : #running }
FQPropertyQueryParametersPresenterTest >> setUp [
	| superPresenter |
	helper := FQTestsHelper current.
	superPresenter := FQQueryCreationPresenter
		on: (FQQueriesBrowserPresenter on: helper modelExample allBehaviourals).
	"So there is more than 1 property for each type"
	superPresenter
		updateConfigurationPresenter: FQPropertyQueriesPresenter.
	(superPresenter queryConfigurationPresenter firstParameter presenters
		detect: [ :radioButton | radioButton label = self classToTest label ])
		click.
	presenter := superPresenter queryConfigurationPresenter
		secondParameter
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testMatchesQuery [
	presenter properties selectIndex: 2.
	self
		assert: presenter queryBuilder query property
		equals: presenter properties selectedItem
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testNormalQueryBuilderInitialization [
	self
		assert: presenter queryBuilder class
		identicalTo: self classToTest queryBuilderClass.
	self
		assert: presenter queryBuilder query class
		identicalTo: self classToTest queryBuilderClass queryClass.
	self assert: presenter queryBuilder queryIsValid
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testPropertiesDropList [
	self
		assert: presenter properties class
		identicalTo: SpDropListPresenter.
	self
		assert: presenter properties listItems size
		equals: presenter queryBuilder availableProperties size.
	self
		assertCollection: presenter properties listItems
		hasSameElements: presenter queryBuilder availableProperties
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testQueryValidity [
	self assert: presenter queryBuilder queryIsValid.
	presenter properties selectIndex: 2.
	self assert: presenter queryBuilder queryIsValid
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testUpdateCreationBrowser [
	self assertCreationPresenterWasUpdated.
	presenter properties selectIndex: 2.
	self assertCreationPresenterWasUpdated
]
