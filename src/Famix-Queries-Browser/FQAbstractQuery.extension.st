Extension { #name : #FQAbstractQuery }

{ #category : #'*Famix-Queries-Browser' }
FQAbstractQuery class >> color [
	^ self subclassResponsibility
]

{ #category : #'*Famix-Queries-Browser' }
FQAbstractQuery >> prepareRemovalFrom: aBrowser [
	^ self subclassResponsibility
]
