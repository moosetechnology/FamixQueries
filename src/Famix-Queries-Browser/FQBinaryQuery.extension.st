Extension { #name : #FQBinaryQuery }

{ #category : #'*Famix-Queries-Browser' }
FQBinaryQuery >> prepareRemovalFrom: aBrowser [
	aBrowser selectQuery: self parents anyOne.
	self prepareRemoval
]
