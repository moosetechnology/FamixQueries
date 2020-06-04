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

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> assertCreationPresenterWasUpdated [
	self
		assertCollection: presenter owner owner resultList items
		hasSameElements: presenter owner query result.
	self
		assert: (helper queryFromCodeInPresenter: presenter owner owner)
		equals: presenter owner query
]

{ #category : #running }
FQPropertyQueryParametersPresenterTest >> queryClass [
	^ self subclassResponsibility
]

{ #category : #running }
FQPropertyQueryParametersPresenterTest >> setUp [
	| superPresenter |
	helper := FQTestsHelper current.
	superPresenter := FQQueryCreationPresenter
		on: (FQQueriesBrowserPresenter on: helper modelExample allBehaviourals).
	superPresenter updateQueryConfigurationFor: FQPropertyQuery.
	(superPresenter queryConfigurationPresenter firstParameter presenters
		detect:
			[ :radioButton | radioButton label = self queryClass label substrings first ])
		click.
	presenter := superPresenter queryConfigurationPresenter
		secondParameter
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testMatchesQuery [
	self
		assert: presenter query property
		equals: presenter properties selectedItem.
	presenter properties selectIndex: 2.
	self
		assert: presenter query property
		equals: presenter properties selectedItem
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testNormalQueryInitialization [
	self assert: presenter query class identicalTo: self queryClass.
	self assert: presenter query isValid
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testPropertiesDropList [
	self
		assert: presenter properties class
		identicalTo: SpDropListPresenter.
	self
		assertCollection: presenter properties listItems
		hasSameElements: presenter query availableProperties.
	self
		assert: presenter query property
		equals: presenter properties selectedItem
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testQueryMatchesOwnerQuery [
	self assert: presenter query equals: presenter owner query.
	presenter properties selectIndex: 2.
	self assert: presenter query equals: presenter owner query
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testQueryValidity [
	self assert: presenter query isValid.
	presenter properties selectIndex: 2.
	self assert: presenter query isValid
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testUpdateCreationBrowser [
	self assertCreationPresenterWasUpdated.
	presenter properties selectIndex: 2.
	self assertCreationPresenterWasUpdated
]

{ #category : #tests }
FQPropertyQueryParametersPresenterTest >> testUpdateDoesNotChangeOwnerPresenter [
	presenter properties selectIndex: 2.
	self assert: presenter owner secondParameter identicalTo: presenter
]
