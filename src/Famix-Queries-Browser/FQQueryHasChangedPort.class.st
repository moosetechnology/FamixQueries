Class {
	#name : #FQQueryHasChangedPort,
	#superclass : #SpOutputPort,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #accessing }
FQQueryHasChangedPort class >> portName [

	^ #queryHasChangedPort
]

{ #category : #attaching }
FQQueryHasChangedPort >> attachTransmission: aTransmission [
	self destinationPresenter
		property: #queryHasChanged
		whenChangedDo: [ self
				transmitWith: aTransmission
				value: self destinationPresenter codeToDisplay ]
]
