Class {
	#name : #FQRoassalSequenceTest,
	#superclass : #SpTest,
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #running }
FQRoassalSequenceTest >> classToTest [
	^ FQRoassalSequence
]

{ #category : #helpers }
FQRoassalSequenceTest >> colors [
	^ {Color brown.
	Color red.
	Color orange.
	Color yellow.
	Color green.
	Color cyan.
	Color blue.
	Color purple.
	Color pink.
	Color magenta}
]

{ #category : #helpers }
FQRoassalSequenceTest >> labels [
	^ {'One' . 'Two' . 'Tree' . 'Four' . 'Five' . 'Six' . 'Seven' . 'Eight'.
	'Nine' . 'Ten'}
]

{ #category : #helpers }
FQRoassalSequenceTest >> modelsCollection [
	^ (1 to: 10) asOrderedCollection
]

{ #category : #running }
FQRoassalSequenceTest >> setUp [
	super setUp.
	presenter := self classToTest on: self modelsCollection
]

{ #category : #tests }
FQRoassalSequenceTest >> testShapeColor [
	presenter shapeColor: [ :model | self colors at: model ].
	self openInstance.
	self
		assertCollection: (presenter canvas nodes collect: #color)
		hasSameElements: self colors
]

{ #category : #tests }
FQRoassalSequenceTest >> testShapeExtent [
	presenter shapeExtent: 100 @ 200.
	self openInstance.
	(presenter canvas nodes collect: #extent)
		do: [ :extent | self assert: extent equals: 100 @ 200 ]
]

{ #category : #tests }
FQRoassalSequenceTest >> testShapeLabel [
	presenter shapeLabel: [ :model | self labels at: model ].
	self openInstance.
	self
		assertCollection:
			(presenter canvas nodes
				collect: [ :shape | (shape propertyAt: #RSLabeled) text ])
		hasSameElements: self labels
]

{ #category : #tests }
FQRoassalSequenceTest >> testShapeModel [
	self openInstance.
	self
		assertCollection: (presenter canvas nodes collect: #model)
		hasSameElements: self modelsCollection
]

{ #category : #tests }
FQRoassalSequenceTest >> testShapePopup [
	presenter shapePopup: [ :model | self labels at: model ].
	self openInstance.
	presenter canvas nodes first announce: RSMouseMove.
	self
		assert:
			(presenter canvas fixedShapes
				detect: [ :shape | shape class == RSComposite ]) children second
				text
		equals: 'One'
]
