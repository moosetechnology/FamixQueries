Class {
	#name : #FQQueryConfigurationPresenterTest,
	#superclass : #SpTest,
	#instVars : [
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #testing }
FQQueryConfigurationPresenterTest class >> isAbstract [
	^ self == FQQueryConfigurationPresenterTest
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> assertCreationPresenterWasUpdated [
	self
		assertCollection: presenter owner resultList items
		hasSameElements: presenter query result.
	self
		assert: (helper queryFromCodeInPresenter: presenter owner)
		equals: presenter query
]

{ #category : #running }
FQQueryConfigurationPresenterTest >> classToTest [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQQueryConfigurationPresenterTest >> currentQuery [
	^ presenter query
]

{ #category : #running }
FQQueryConfigurationPresenterTest >> openInstance [
	window
		ifNil: [ window := presenter owner
				queryConfigurationPresenter: presenter;
				openWithSpec ]
]

{ #category : #running }
FQQueryConfigurationPresenterTest >> queryClass [
	^ self subclassResponsibility
]

{ #category : #running }
FQQueryConfigurationPresenterTest >> resetPresenterWithEntities: aMooseGroup [
	| superPresenter |
	superPresenter := FQQueryCreationPresenter
		on: (FQQueriesBrowserPresenter on: aMooseGroup).
	superPresenter queryTypesDropList selectItem: self queryClass.
	presenter := superPresenter presenters
		detect: [ :pres | pres class == self classToTest ]
]

{ #category : #running }
FQQueryConfigurationPresenterTest >> setUp [
	helper := FQTestsHelper current.
	self resetPresenterWithEntities: helper classesAndMethods
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testFirstParameter [
	^ self subclassResponsibility
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testImpossibleQueryInitialization [
	self resetPresenterWithEntities: helper noEntities.
	self assert: (presenter query isKindOf: self queryClass).
	self deny: presenter query isValid
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testNormalQueryInitialization [
	self assert: (presenter query isKindOf: self queryClass).
	self assert: presenter query isValid
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testQueryValidity [
	^ self subclassResponsibility
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testSecondParameter [
	^ self subclassResponsibility
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testUpdateCreationBrowser [
	^ self subclassResponsibility
]
