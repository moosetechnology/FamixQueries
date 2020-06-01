Extension { #name : #FQScopeQuery }

{ #category : #'*Famix-Queries-Browser' }
FQScopeQuery class >> color [
	"Blue-green"

	^ Color colorFrom: '009292'
]

{ #category : #'*Famix-Queries-Browser' }
FQScopeQuery >> configureIn: aCreationPresenter [
	aCreationPresenter configureScopeQuery: self
]
