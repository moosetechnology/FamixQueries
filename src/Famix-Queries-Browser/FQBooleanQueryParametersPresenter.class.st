Class {
	#name : #FQBooleanQueryParametersPresenter,
	#superclass : #FQPropertyQueryParametersPresenter,
	#category : #'Famix-Queries-Browser-PropertyQueryParametersPresenters'
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

{ #category : #initialization }
FQBooleanQueryParametersPresenter class >> queryBuilderClass [
	^ FQBooleanPropertyQueryBuilder
]
