Class {
	#name : #FQQueryPort,
	#superclass : #SpInputPort,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #accessing }
FQQueryPort class >> portName [
	^ 'Query port'
]

{ #category : #'handling transmission' }
FQQueryPort >> incomingTransmission: aQuery from: outPort [
	self destinationPresenter updateForQuery: aQuery
]
