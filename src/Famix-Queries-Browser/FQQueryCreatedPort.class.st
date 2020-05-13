Class {
	#name : #FQQueryCreatedPort,
	#superclass : #SpInputPort,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #'handling transmission' }
FQQueryCreatedPort >> incomingTransmission: anObject from: outPort [
	self destinationPresenter updateForQuery: anObject
]
