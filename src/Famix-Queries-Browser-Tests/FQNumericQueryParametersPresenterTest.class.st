Class {
	#name : #FQNumericQueryParametersPresenterTest,
	#superclass : #FQComparativeQueryParametersPresenterTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #helpers }
FQNumericQueryParametersPresenterTest >> classToTest [
	^ FQNumericQueryParametersPresenter
]

{ #category : #running }
FQNumericQueryParametersPresenterTest >> queryClass [
	^ FQNumericQuery
]

{ #category : #helpers }
FQNumericQueryParametersPresenterTest >> valueInput [
	^ '5'
]

{ #category : #helpers }
FQNumericQueryParametersPresenterTest >> valueInputClass [
	^ SpNumberInputFieldPresenter
]
