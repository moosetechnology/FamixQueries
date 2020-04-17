Class {
	#name : #FQNumericQueryParametersPresenterTest,
	#superclass : #FQComparativeQueryParametersPresenterTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #helpers }
FQNumericQueryParametersPresenterTest >> presenterClass [
	^ FQNumericQueryParametersPresenter
]

{ #category : #helpers }
FQNumericQueryParametersPresenterTest >> valueInput [
	^ '5'
]

{ #category : #helpers }
FQNumericQueryParametersPresenterTest >> valueInputClass [
	^ SpNumberInputFieldPresenter
]
