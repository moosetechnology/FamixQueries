Extension { #name : #FQStringQuery }

{ #category : #'*Famix-Queries-Browser' }
FQStringQuery class >> color [
	"Light blue"

	^ Color colorFrom: '77AADD'
]

{ #category : #'*Famix-Queries-Browser' }
FQStringQuery class >> label [
	^ 'String ', super label
]
