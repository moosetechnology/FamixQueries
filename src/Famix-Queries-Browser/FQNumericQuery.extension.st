Extension { #name : #FQNumericQuery }

{ #category : #'*Famix-Queries-Browser' }
FQNumericQuery class >> color [
	"Light cyan"

	^ Color colorFrom: '99DDFF'
]

{ #category : #'*Famix-Queries-Browser' }
FQNumericQuery class >> label [
	^ 'Number ', super label
]
