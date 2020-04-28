Extension { #name : #FQNumericQuery }

{ #category : #'*Famix-Queries-Browser' }
FQNumericQuery class >> color [
	^ Color colorFrom: '99DDFF'
]

{ #category : #'*Famix-Queries-Browser' }
FQNumericQuery class >> label [
	^ 'Number ', super label
]
