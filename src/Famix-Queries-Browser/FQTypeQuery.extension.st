Extension { #name : #FQTypeQuery }

{ #category : #'*Famix-Queries-Browser' }
FQTypeQuery class >> color [
	"Pear"

	^ Color colorFrom: 'BBCC33'
]

{ #category : #'*Famix-Queries-Browser' }
FQTypeQuery >> configureIn: aCreationPresenter [
	aCreationPresenter configureTypeQuery: self
]
