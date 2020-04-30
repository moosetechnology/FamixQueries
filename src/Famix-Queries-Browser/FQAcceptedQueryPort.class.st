Class {
	#name : #FQAcceptedQueryPort,
	#superclass : #SpOutputPort,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #accessing }
FQAcceptedQueryPort class >> portName [
	^ #acceptedQuery
]

{ #category : #attaching }
FQAcceptedQueryPort >> attachTransmission: aTransmission [
	self destinationPresenter
		property: #acceptedQuery
		whenChangedDo: [ self
				transmitWith: aTransmission
				value: self destinationPresenter queryBuilder query ]
]
