"
I am a Roassal representation of a sequence with arrowed shapes.

I open on a collection of models.

Users can configure:
	- The extent of the shapes (a Point)
	- The color, label and popup text of each shape (a Block with each model as arguement).

Example: 

'| presenter |
	presenter := (FQRoassalSequence on: { 1. 2. 3 })
		shapeColor: [ :model | 
			{Color yellow.
			Color orange.
			Color red} at: model ];
		shapeLabel: [ :model | model asString ];
		shapePopup: [ :model | {'One' . 'Two' . 'Three'} at: model ].
	presenter openWithSpec'
"
Class {
	#name : #FQRoassalSequence,
	#superclass : #SpRoassalPresenter,
	#instVars : [
		'models',
		'shapeExtent',
		'shapeColor',
		'shapeLabel',
		'shapePopup'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQRoassalSequence class >> title [
	^ 'Roassal Sequence'
]

{ #category : #default }
FQRoassalSequence >> defaultShapeColor [
	^ [ :model | Color gray ]
]

{ #category : #default }
FQRoassalSequence >> defaultShapeExtent [
	^ 100 @ self class toolbarHeight
]

{ #category : #default }
FQRoassalSequence >> defaultShapeLabel [
	^ [ :model | '' ]
]

{ #category : #initialization }
FQRoassalSequence >> defineInputPorts [
	^ {FQQueryPort new}
]

{ #category : #initialization }
FQRoassalSequence >> initialize [
	super initialize.
	self initializeScript
]

{ #category : #initialization }
FQRoassalSequence >> initializeScript [
	self script: [ :canvas | self sequenceScriptOn: canvas ]
]

{ #category : #'private - script' }
FQRoassalSequence >> label [
	| label |
	label := RSLabeled new text: self shapeLabel.
	label location
		inner;
		center;
		middle.
	^ label
]

{ #category : #'private - script' }
FQRoassalSequence >> newArrowedShape [
	| offset points |
	offset := 0.6.
	points := {(-1 @ -1).
	(offset @ -1).
	(1 @ 0).
	(offset @ 1).
	(-1 @ 1).
	(offset negated @ 0)}.
	^ RSShapeFactory polygonWithPoints: points
]

{ #category : #'private - script' }
FQRoassalSequence >> newArrowedShapeFor: model position: i [
	| shape |
	shape := self newArrowedShape
		model: model;
		extent: self shapeExtent;
		color: (self shapeColor value: model);
		addInteraction: self label;
		position: ((i - 1) * self shapeExtent x) @ 0.
	self shapePopup
		ifNotNil: [ shape popupText: (self shapePopup value: model) ].
	^ shape
]

{ #category : #'private - script' }
FQRoassalSequence >> sequenceScriptOn: canvas [
	models
		withIndexDo:
			[ :model :i | canvas add: (self newArrowedShapeFor: model position: i) ].
	canvas @ RSCanvasController new noLegend.
	^ canvas
]

{ #category : #'accessing model' }
FQRoassalSequence >> setModelBeforeInitialization: aCollectionOfModelObjects [
	models := aCollectionOfModelObjects
]

{ #category : #'accessing model' }
FQRoassalSequence >> setModels: aCollection [
	models := aCollection
]

{ #category : #accessing }
FQRoassalSequence >> shapeColor [
	^ shapeColor ifNil: [ self defaultShapeColor ]
]

{ #category : #accessing }
FQRoassalSequence >> shapeColor: anObject [
	shapeColor := anObject
]

{ #category : #accessing }
FQRoassalSequence >> shapeExtent [
	^ shapeExtent ifNil: [ self defaultShapeExtent ]
]

{ #category : #accessing }
FQRoassalSequence >> shapeExtent: anObject [
	shapeExtent := anObject
]

{ #category : #accessing }
FQRoassalSequence >> shapeLabel [
	^ shapeLabel ifNil: [ self defaultShapeLabel ]
]

{ #category : #accessing }
FQRoassalSequence >> shapeLabel: anObject [
	shapeLabel := anObject
]

{ #category : #accessing }
FQRoassalSequence >> shapePopup [
	^ shapePopup
]

{ #category : #accessing }
FQRoassalSequence >> shapePopup: anObject [
	shapePopup := anObject
]
