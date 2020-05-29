Class {
	#name : #FQBooleanQueryParametersPresenterTest,
	#superclass : #FQPropertyQueryParametersPresenterTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #helpers }
FQBooleanQueryParametersPresenterTest >> classToTest [
	^ FQBooleanQueryParametersPresenter
]

{ #category : #running }
FQBooleanQueryParametersPresenterTest >> queryClass [
	^ FQBooleanQuery
]
