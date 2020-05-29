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
		equals: presenter query availableComparators size.
	self
		assertCollection: presenter comparators listItems
		hasSameElements: presenter query availableComparators
]

{ #category : #tests }
FQComparativeQueryParametersPresenterTest >> testMatchesQuery [
	super testMatchesQuery.
	presenter comparators selectIndex: 2.
	self
		assert: presenter query comparator
		equals: presenter comparators selectedItem.
	presenter valueInput text: self valueInput.
	self
		assert: presenter query valueToCompare asString
		equals: presenter valueInput text
]

{ #category : #tests }
FQComparativeQueryParametersPresenterTest >> testQueryValidity [
	super testQueryValidity.
	presenter comparators selectIndex: 2.
	self assert: presenter query isValid.
	presenter valueInput text: self valueInput.
	self assert: presenter query isValid
]

{ #category : #tests }
FQComparativeQueryParametersPresenterTest >> testUpdateCreationBrowser [
	super testUpdateCreationBrowser.
	presenter comparators selectIndex: 2.
	self assertCreationPresenterWasUpdated.
	presenter valueInput text: self valueInput.
	self assertCreationPresenterWasUpdated
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
