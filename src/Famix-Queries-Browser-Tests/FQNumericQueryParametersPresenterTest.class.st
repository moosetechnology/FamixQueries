Class {
	#name : #FQNumericQueryParametersPresenterTest,
	#superclass : #FQComparativeQueryParametersPresenterTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #running }
FQNumericQueryParametersPresenterTest >> classToTest [
	^ FQNumericQueryParametersPresenter
]

{ #category : #running }
FQNumericQueryParametersPresenterTest >> queryClass [
	^ FQNumericQuery
]

{ #category : #running }
FQNumericQueryParametersPresenterTest >> valueInput [
	^ '5'
]

{ #category : #running }
FQNumericQueryParametersPresenterTest >> valueInputClass [
	^ SpNumberInputFieldPresenter
]
