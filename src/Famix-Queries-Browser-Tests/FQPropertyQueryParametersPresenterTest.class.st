Class {
	#name : #FQPropertyQueryParametersPresenterTest,
	#superclass : #TestCase,
	#instVars : [
		'helper',
		'presenter'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #testing }
FQPropertyQueryParametersPresenterTest class >> isAbstract [
	^ self == FQPropertyQueryParametersPresenterTest
]

{ #category : #helpers }
FQPropertyQueryParametersPresenterTest >> presenterClass [
	^ self subclassResponsibility
]

{ #category : #running }
FQPropertyQueryParametersPresenterTest >> setUp [
	| superPresenter |
	super setUp.
	helper := FQBrowserTestsHelper new.
	superPresenter := FQPropertyQueriesPresenter
		on: helper modelExample allBehaviourals.	"So there is more than 1 property for each type"
	superPresenter updateQueryParametersPresenter: self presenterClass.
	presenter := superPresenter secondParameter
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
		identicalTo: self presenterClass queryBuilderClass.
	self
		assert: presenter queryBuilder query class
		identicalTo: self presenterClass queryBuilderClass queryClass.
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
