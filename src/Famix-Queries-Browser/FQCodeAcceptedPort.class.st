Class {
	#name : #FQCodeAcceptedPort,
	#superclass : #SpInputPort,
	#category : #'Famix-Queries-Browser-Tools'
}

{ #category : #'handling transmission' }
FQCodeAcceptedPort >> incomingTransmission: aText from: outPort [
	self flag: 'Repare when code transmission in Spec is OK.'.
	self destinationPresenter updateQueryBuilderFor: aText
]
