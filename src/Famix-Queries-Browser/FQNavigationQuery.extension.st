Extension { #name : #FQNavigationQuery }

{ #category : #'*Famix-Queries-Browser' }
FQNavigationQuery class >> color [
	"Light yellow"

	^ Color colorFrom: 'EEDD88'
]

{ #category : #'*Famix-Queries-Browser' }
FQNavigationQuery >> configureIn: aCreationPresenter [
	aCreationPresenter configureNavigationQuery: self
]
