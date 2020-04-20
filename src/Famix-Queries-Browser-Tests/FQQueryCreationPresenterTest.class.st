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
FQQueryCreationPresenterTest >> testQueryCode [
	| query |
	self assert: presenter queryCode class identicalTo: SpCodePresenter.
	query := Smalltalk compiler evaluate: presenter queryCode text.
	self assert: (query isKindOf: FQAbstractQuery).
	self assert: query isValid.
	self
		assert: query
		equals: presenter queryConfigurationPresenter queryBuilder query
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testQueryConfigurationPresenter [
	self
		assert:
			(presenter queryConfigurationPresenter
				isKindOf: FQQueryConfigurationPresenter).
	self
		assert: presenter queryConfigurationPresenter class
		identicalTo: presenter queryTypesDropList selectedItem
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testQueryMatchesInAllSubpresenters [
	self
		assert: presenter queryConfigurationPresenter queryBuilder query
		equals: (Smalltalk compiler evaluate: presenter queryCode text).
	self
		assertCollection: presenter queryConfigurationPresenter queryBuilder applyQuery
		hasSameElements: presenter resultList items
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
FQQueryCreationPresenterTest >> testResultList [
	self assert: presenter resultList class identicalTo: SpListPresenter.
	self
		assertCollection: presenter resultList items
		hasSameElements: presenter queryConfigurationPresenter queryBuilder applyQuery
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testResultListTitle [
	self
		assert: presenter resultListTitle class
		identicalTo: SpLabelPresenter
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testToolBar [
	| initialQueriesSize |
	
	self assert: presenter toolBar class identicalTo: SpToolBarPresenter.
	self
		assert: presenter toolBar presenters first class
		identicalTo: SpToolBarButton.
	
	initialQueriesSize := presenter browser queriesTree model items size.
	presenter toolBar presenters first click.
	self
		assert: presenter browser queriesTree model items size
		equals: initialQueriesSize + 1.
	self
		assert: presenter browser queriesTree model items first
		equals: presenter queryConfigurationPresenter queryBuilder query
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testTransmissions [
	presenter queryTypesDropList selectIndex: 2.
	self testQueryMatchesInAllSubpresenters.
	presenter queryTypesDropList selectIndex: 3.
	self testQueryMatchesInAllSubpresenters.
	presenter queryTypesDropList selectIndex: 4.
	self testQueryMatchesInAllSubpresenters
]
