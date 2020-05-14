Class {
	#name : #FQQueryOutputPort,
	#superclass : #SpOutputPort,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #accessing }
FQQueryOutputPort class >> portName [

	^ #queryOutputPort
]

{ #category : #attaching }
FQQueryOutputPort >> attachTransmission: aTransmission [
	self destinationPresenter
		property: #query
		whenChangedDo: [ self
				transmitWith: aTransmission
				value: self destinationPresenter query ]
]
