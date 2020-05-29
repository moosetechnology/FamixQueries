Class {
	#name : #FQQueryCreationPresenterTest,
	#superclass : #SpTest,
	#instVars : [
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #running }
FQQueryCreationPresenterTest >> changeQueryType [
	presenter queryTypesDropList
		selectItem:
			(presenter queryTypesDropList listItems
				detect: [ :item | presenter queryTypesDropList selectedItem ~= item ]).
	presenter queryTypesDropList selectItem: FQScopeQuery
]

{ #category : #running }
FQQueryCreationPresenterTest >> classToTest [
	^ FQQueryCreationPresenter
]

{ #category : #running }
FQQueryCreationPresenterTest >> setUp [
	helper :=  FQTestsHelper current.
	presenter := FQQueryCreationPresenter
		on: (FQQueriesBrowserPresenter on: helper classesAndMethods)
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testCreateOnlyOneChild [
	self openInstance.
	self assert: presenter browser initialQuery children isEmpty.
	
	self changeQueryType.
	self assert: presenter browser initialQuery children isEmpty.
	
	presenter toolBar presenters first click.
	
	self assert: presenter browser initialQuery children size equals: 1.
	self
		assert: presenter browser initialQuery children anyOne
		identicalTo: presenter query
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
	query := helper queryFromCodeInPresenter: presenter.
	self assert: (query isKindOf: FQAbstractQuery).
	self assert: query isValid.
	self
		assert: query
		equals: presenter queryConfigurationPresenter query
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testQueryConfigurationPresenter [
	self
		assert:
			(presenter queryConfigurationPresenter
				isKindOf: FQQueryConfigurationPresenter).
	self
		assert: presenter queryConfigurationPresenter query class
		identicalTo: presenter queryTypesDropList selectedItem
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testQueryMatchesInAllSubpresenters [
	self
		assert: presenter query
		equals: (helper queryFromCodeInPresenter: presenter).
	self
		assertCollection: presenter queryConfigurationPresenter query result
		hasSameElements: presenter resultList items
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testQueryTypesDropList [
	self
		assert: presenter queryTypesDropList class
		identicalTo: SpDropListPresenter.
	self
		assertCollection: presenter queryTypesDropList listItems
		hasSameElements:
			{FQNavigationQuery.
			FQPropertyQuery.
			FQScopeQuery.
			FQTypeQuery}.
	presenter queryTypesDropList listItems
		do: [ :queryClass | 
			presenter queryTypesDropList selectItem: queryClass.
			self
				assert: (presenter queryConfigurationPresenter query isKindOf: queryClass) ]
]

{ #category : #tests }
FQQueryCreationPresenterTest >> testResultList [
	self
		assert: presenter resultList class
		identicalTo: FQResultTreePresenter.
	self
		assertCollection: presenter resultList items
		hasSameElements: presenter queryConfigurationPresenter query result
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
		equals: presenter queryConfigurationPresenter query
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
		equals: presenter queryConfigurationPresenter query parent.
	self
		deny:
			(presenter browser queries
				includes: presenter queryConfigurationPresenter query)
]
