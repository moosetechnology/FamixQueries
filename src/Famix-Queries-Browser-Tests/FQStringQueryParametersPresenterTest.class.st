Class {
	#name : #FQStringQueryParametersPresenterTest,
	#superclass : #FQComparativeQueryParametersPresenterTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #helpers }
FQStringQueryParametersPresenterTest >> classToTest [
	^ FQStringQueryParametersPresenter
]

{ #category : #helpers }
FQStringQueryParametersPresenterTest >> valueInput [
	^ 'LAN'
]

{ #category : #helpers }
FQStringQueryParametersPresenterTest >> valueInputClass [
	^ SpTextInputFieldPresenter
]
