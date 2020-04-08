Extension { #name : #FQTypeQuery }

{ #category : #'*Famix-Queries-Browser' }
FQTypeQuery >> addType: aType [
	(self types includes: aType)
		ifTrue: [ ^ self ].
	self types add: aType
]

{ #category : #'*Famix-Queries-Browser' }
FQTypeQuery class >> label [
	^ 'Type Query'
]

{ #category : #'*Famix-Queries-Browser' }
FQTypeQuery >> removeType: aType [
	self types size = 1
		ifTrue: [ FQTypeQueryMustHaveAtLeastOneType
				signal: 'Removing the last type of a ' , self className , ' is forbidden' ].
	self types remove: aType ifAbsent: [  ]
]
