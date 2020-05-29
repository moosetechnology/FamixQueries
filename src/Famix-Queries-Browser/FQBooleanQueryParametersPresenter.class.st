Class {
	#name : #FQBooleanQueryParametersPresenter,
	#superclass : #FQPropertyQueryParametersPresenter,
	#category : #'Famix-Queries-Browser-PropertyQuery-SubPresenters'
}

{ #category : #specs }
FQBooleanQueryParametersPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #properties
			expand: true
			fill: true
			padding: 50;
		yourself
]
