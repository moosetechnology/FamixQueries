Class {
	#name : #FQStringQueryParametersPresenterTest,
	#superclass : #FQComparativeQueryParametersPresenterTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #running }
FQStringQueryParametersPresenterTest >> classToTest [
	^ FQStringQueryParametersPresenter
]

{ #category : #running }
FQStringQueryParametersPresenterTest >> queryClass [
	^ FQStringQuery
]

{ #category : #running }
FQStringQueryParametersPresenterTest >> valueInput [
	^ 'LAN'
]

{ #category : #running }
FQStringQueryParametersPresenterTest >> valueInputClass [
	^ SpTextInputFieldPresenter
]
