Class {
	#name : #FQQueryCreationPresenterTest,
	#superclass : #SpTest,
	#instVars : [
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #running }
FQQueryCreationPresenterTest >> classToTest [
	^ FQQueryCreationPresenter
]

{ #category : #running }
FQQueryCreationPresenterTest >> setUp [
	helper := FQBrowserTestsHelper new.
	presenter := FQQueryCreationPresenter
		on: (FQQueriesBrowserPresenter on: helper classesAndMethods)
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testDisabledToolBarButton [
	presenter := FQQueryCreationPresenter
		on: (FQQueriesBrowserPresenter on: helper noEntities).
	self openInstance.
	self deny: presenter toolBar presenters first isEnabled
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
		assertCollection: presenter queryConfigurationPresenter queryBuilder queryResult
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
	self
		assert: presenter resultList class
		identicalTo: FQResultTreePresenter.
	self
		assertCollection: presenter resultList items
		hasSameElements: presenter queryConfigurationPresenter queryBuilder queryResult
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testToolBar [
	| initialQueriesSize |
	self openInstance.
	self assert: presenter toolBar class identicalTo: SpToolBarPresenter.
	self
		assert: presenter toolBar presenters first class
		identicalTo: SpToolBarButtonPresenter.
	self assert: presenter toolBar presenters first isEnabled.
	initialQueriesSize := presenter browser queries size.
	
	presenter toolBar presenters first click.
	self
		assert: presenter browser queries size
		equals: initialQueriesSize + 1.
	self
		assert: presenter browser selectedQuery
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

{ #category : #tests }
FQQueryCreationPresenterTest >> testWindowClosedAction [
	| initialQueriesSize |
	self openInstance.
	initialQueriesSize := presenter browser queries size.
	presenter window close.
	self
		assert: presenter browser queries size
		equals: initialQueriesSize.
	self
		assert: presenter browser selectedQuery
		equals: presenter queryConfigurationPresenter queryBuilder query parent.
	self
		deny:
			(presenter browser queries
				includes: presenter queryConfigurationPresenter queryBuilder query)
]
