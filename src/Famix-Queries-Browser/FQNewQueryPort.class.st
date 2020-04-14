Class {
	#name : #FQNewQueryPort,
	#superclass : #SpOutputPort,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #accessing }
FQNewQueryPort class >> portName [

	^ #newQueryPort
]

{ #category : #attaching }
FQNewQueryPort >> attachTransmission: aTransmission [
	"override this to add specific transmissions"

	self destinationPresenter button
		whenActivatedDo: [ :selection | 
			self
				transmitWith: aTransmission
				value: self destinationPresenter queryBuilder ]
]
