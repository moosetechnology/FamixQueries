Extension { #name : #Array }

{ #category : #'*Famix-Queries' }
Array >> --> aChildQuery [
	(self size = 2
		and: [ self allSatisfy: [ :elt | elt isKindOf: FQAbstractQuery ] ])
		ifFalse: [ ^ aChildQuery ].
	^ aChildQuery
		beChildOf: self;
		yourself
]
