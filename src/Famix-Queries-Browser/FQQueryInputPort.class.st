Class {
	#name : #FQQueryInputPort,
	#superclass : #SpInputPort,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #accessing }
FQQueryInputPort class >> portName [
	^ #queryInputPort
]

{ #category : #'handling transmission' }
FQQueryInputPort >> incomingTransmission: aQuery from: outPort [
	self destinationPresenter updateForQuery: aQuery
]
