Class {
	#name : #FQComparativeQueryParametersPresenterTest,
	#superclass : #FQPropertyQueryParametersPresenterTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #testing }
FQComparativeQueryParametersPresenterTest class >> isAbstract [
	^ self == FQComparativeQueryParametersPresenterTest
]

{ #category : #tests }
FQComparativeQueryParametersPresenterTest >> testComparatorsDropList [
	self
		assert: presenter comparators class
		identicalTo: SpDropListPresenter.
	self
		assert: presenter comparators listItems size
		equals: presenter queryBuilder availableComparators size.
	self
		assertCollection: presenter comparators listItems
		hasSameElements: presenter queryBuilder availableComparators
]

{ #category : #tests }
FQComparativeQueryParametersPresenterTest >> testQueryValidity [
	super testQueryValidity.
	presenter comparators selectIndex: 2.
	self assert: presenter queryBuilder queryIsValid.
	presenter valueInput text: self valueInput.
	self assert: presenter queryBuilder queryIsValid
]

{ #category : #tests }
FQComparativeQueryParametersPresenterTest >> testValueInput [
	self
		assert: presenter valueInput class
		identicalTo: self valueInputClass
]

{ #category : #helpers }
FQComparativeQueryParametersPresenterTest >> valueInput [
	^ self subclassResponsibility
]

{ #category : #helpers }
FQComparativeQueryParametersPresenterTest >> valueInputClass [
	^ self subclassResponsibility
]
