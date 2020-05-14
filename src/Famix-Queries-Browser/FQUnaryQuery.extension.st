Extension { #name : #FQUnaryQuery }

{ #category : #'*Famix-Queries-Browser' }
FQUnaryQuery >> prepareRemovalFrom: aBrowser [
	aBrowser selectQuery: parent.
	self prepareRemoval
]
