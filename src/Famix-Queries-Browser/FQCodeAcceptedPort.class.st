Class {
	#name : #FQCodeAcceptedPort,
	#superclass : #SpOutputPort,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #attaching }
FQCodeAcceptedPort >> attachTransmission: aTransmission [
	"override this to add specific transmissions"

	self destinationPresenter
		whenTextIsAcceptedDo: [ :text | 
			"Not sure if destinationPresenter is the code or the configuration browser. To test when code presenters transmissions are ok in Spec"
			self
				transmitWith: aTransmission
				value: (self destinationPresenter updateQueryBuilderFor: text) ]
]
