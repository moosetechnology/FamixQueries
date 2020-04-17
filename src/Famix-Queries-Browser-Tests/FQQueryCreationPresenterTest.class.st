Class {
	#name : #FQQueryCreationPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #running }
FQQueryCreationPresenterTest >> setUp [
	super setUp.
	helper := FQBrowserTestsHelper new.
	presenter := FQQueryCreationPresenter
		owner: FQMockWindow new
		on: FQQueriesBrowserPresenter default
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testPresenters [


	self
		assert:
			(presenter queryConfigurationPresenter
				isKindOf: FQQueryConfigurationPresenter).
	self assert: presenter queryCode class identicalTo: SpCodePresenter.
	self
		assert: presenter resultListTitle class
		identicalTo: SpLabelPresenter.
	self assert: presenter resultList class identicalTo: SpListPresenter
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testQueryTypesDropList [
	self
		assert: presenter queryTypesDropList class
		identicalTo: SpDropListPresenter.
	self
		assertCollection: presenter queryTypesDropList listItems
		hasSameElements: FQQueryConfigurationPresenter allSubclasses.
	
	presenter queryTypesDropList listItems
		do: [ :presenterClass | 
			presenter queryTypesDropList selectItem: presenterClass.
			self
				assert: presenter queryConfigurationPresenter class
				identicalTo: presenterClass ]
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testToolBar [
	self assert: presenter toolBar class identicalTo: SpToolBarPresenter.
	self assert: presenter toolBar presenters size equals: 1.
	self
		assert: presenter toolBar presenters first class
		identicalTo: SpToolBarButton.
	presenter toolBar presenters first click.
	self assert: presenter browser queriesTree model items size equals: 1
]
