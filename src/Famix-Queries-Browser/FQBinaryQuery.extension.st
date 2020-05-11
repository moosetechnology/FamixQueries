Extension { #name : #FQBinaryQuery }

{ #category : #'*Famix-Queries-Browser' }
FQBinaryQuery >> prepareRemovalFrom: aBrowser [
	aBrowser selectQuery: parents first.
	parents do: [ :parent | parent removeChild: self ].
	parents := OrderedCollection new
]
