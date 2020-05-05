Class {
	#name : #FQQueryConfigurationPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter',
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #testing }
FQQueryConfigurationPresenterTest class >> isAbstract [
	^ self == FQQueryConfigurationPresenterTest
]

{ #category : #helpers }
FQQueryConfigurationPresenterTest >> currentQuery [
	^ self queryBuilder query
]

{ #category : #helpers }
FQQueryConfigurationPresenterTest >> initializePresenterForNoEntities [
	presenter := self presenterClass on: helper noEntities
]

{ #category : #helpers }
FQQueryConfigurationPresenterTest >> presenterClass [
	^ self subclassResponsibility
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
	presenter := self presenterClass
		owner: superPresenter
		on: aMooseGroup
]

{ #category : #running }
FQQueryConfigurationPresenterTest >> setUp [
	super setUp.
	helper := FQBrowserTestsHelper new.
	self resetPresenterWithEntities: helper classesAndMethods
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testImpossibleQueryBuilderInitialization [
	self initializePresenterForNoEntities.
	self
		assert: presenter queryBuilder class
		identicalTo: self presenterClass queryBuilderClass.
	self
		assert: presenter queryBuilder query class
		identicalTo: self presenterClass queryBuilderClass queryClass.
	self deny: presenter queryBuilder queryIsValid
]

{ #category : #tests }
FQQueryConfigurationPresenterTest >> testNormalQueryBuilderInitialization [
	self
		assert: presenter queryBuilder class
		identicalTo: self presenterClass queryBuilderClass.
	self
		assert: presenter queryBuilder query class
		identicalTo: self presenterClass queryBuilderClass queryClass.
	self assert: presenter queryBuilder queryIsValid
]
