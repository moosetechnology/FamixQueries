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
	^ self queryBuilder query
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
FQQueryConfigurationPresenterTest >> queryBuilder [
	^ presenter queryBuilder
]

{ #category : #helpers }
FQQueryConfigurationPresenterTest >> resetPresenterWithEntities: aMooseGroup [
	| superPresenter |
	superPresenter := FQQueryCreationPresenter
		on: (FQQueriesBrowserPresenter on: aMooseGroup).
	superPresenter queryTypesDropList selectItem: self classToTest.
	presenter := superPresenter presenters
		detect: [ :pres | pres class == self classToTest ]
]

{ #category : #running }
FQQueryConfigurationPresenterTest >> setUp [
	helper :=  FQTestsHelper current.
	self resetPresenterWithEntities: helper classesAndMethods
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testImpossibleQueryBuilderInitialization [
	self initializePresenterForNoEntities.
	self
		assert: presenter queryBuilder class
		identicalTo: self classToTest queryBuilderClass.
	self
		assert: presenter queryBuilder query class
		identicalTo: self classToTest queryBuilderClass queryClass.
	self deny: presenter queryBuilder queryIsValid
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testNormalQueryBuilderInitialization [
	self
		assert: presenter queryBuilder class
		identicalTo: self classToTest queryBuilderClass.
	self
		assert: presenter queryBuilder query class
		identicalTo: self classToTest queryBuilderClass queryClass.
	self assert: presenter queryBuilder queryIsValid
]
