Extension { #name : #FQBinaryQuery }

{ #category : #'*Famix-Queries-Browser' }
FQBinaryQuery >> prepareRemovalFrom: aBrowser [
	aBrowser selectQuery: parents anyOne.
	self prepareRemoval
]
