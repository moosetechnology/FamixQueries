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

{ #category : #running }
FQQueryConfigurationPresenterTest >> assertCreationPresenterWasUpdated [
	self
		assertCollection: presenter owner resultList items
		hasSameElements: presenter query result.
	self
		assert: (helper queryFromCodeInPresenter: presenter owner)
		equals: presenter query
]

{ #category : #helpers }
FQQueryConfigurationPresenterTest >> classToTest [
	^ self subclassResponsibility
]

{ #category : #helpers }
FQQueryConfigurationPresenterTest >> currentQuery [
	^ presenter query
]

{ #category : #helpers }
FQQueryConfigurationPresenterTest >> initializePresenterForNoEntities [
	self resetPresenterWithEntities: helper noEntities
]

{ #category : #running }
FQQueryConfigurationPresenterTest >> openInstance [
	window
		ifNil: [ window := presenter owner
				queryConfigurationPresenter: presenter;
				openWithSpec ]
]

{ #category : #helpers }
FQQueryConfigurationPresenterTest >> queryClass [
	^ self subclassResponsibility
]

{ #category : #helpers }
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

{ #category : #accessing }
FQQueryConfigurationPresenterTest >> testFirstParameter [
	^ self subclassResponsibility
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testImpossibleQueryInitialization [
	self initializePresenterForNoEntities.
	self assert: (presenter query isKindOf: self queryClass).
	self deny: presenter query isValid
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testNormalQueryInitialization [
	self assert: (presenter query isKindOf: self queryClass).
	self assert: presenter query isValid
]

{ #category : #accessing }
FQQueryConfigurationPresenterTest >> testQueryValidity [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQQueryConfigurationPresenterTest >> testSecondParameter [
	^ self subclassResponsibility
]

{ #category : #accessing }
FQQueryConfigurationPresenterTest >> testUpdateCreationBrowser [
	^ self subclassResponsibility
]
