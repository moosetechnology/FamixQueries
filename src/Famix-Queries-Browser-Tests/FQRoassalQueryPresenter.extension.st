Extension { #name : #FQRoassalQueryPresenter }

{ #category : #'*Famix-Queries-Browser-Tests' }
FQRoassalQueryPresenter >> selectedItem [
	^ (currentCanvas shapes
		detect: [ :shape | shape class == RSBox and: [ shape border isNotNil ] ])
		model
]
