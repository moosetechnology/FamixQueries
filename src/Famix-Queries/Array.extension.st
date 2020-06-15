Extension { #name : #Array }

{ #category : #'*Famix-Queries' }
Array >> --> aChildQuery [
	(self size = 2
		and: [ self allSatisfy: [ :elt | elt isKindOf: FQAbstractQuery ] ])
		ifFalse: [ FQInvalidParentsArray
				signal: 'Parent array does not contain two queries' ].
	^ aChildQuery
		beChildOf: self;
		yourself
]
