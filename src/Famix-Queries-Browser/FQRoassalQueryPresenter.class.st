Class {
	#name : #FQRoassalQueryPresenter,
	#superclass : #SpRoassalPresenter,
	#instVars : [
		'hasInteractions',
		'queries',
		'selectedQuery',
		'shapePopup',
		'browser'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #'accessing model' }
FQRoassalQueryPresenter >> applyScript [
	self script: [ :canvas | self roassalScript: canvas ]
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> boxDraggedAction: box [
	| potentialParents |
	owner selectQuery: box model.
	potentialParents := box canvas shapes
		select: [ :shape | 
			(shape isKindOf: RSBox)
				and: [ shape ~= box
						and:
							[ shape encompassingRectangle intersects: box encompassingRectangle ] ] ].
	potentialParents size == 1
		ifTrue:
			[ owner combineQuery: potentialParents first model with: box model ].
	self refresh
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> boxLabel [
	| label |
	label := RSLabeled new
		text: [ :model | 
			model
				ifNil: [ 'Initial
Entities' ]
				ifNotNil: [ :query | query roassalLabel ] ].
	label location
		inner;
		center;
		middle.
	^ label
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> boxMenu: aMenuMorph box: aBox [
	(aMenuMorph
		add: 'Create a new query after this one'
		target: browser
		selector: #openQueryCreationPresenter)
		icon: (UITheme iconNamed: #add).
	(aMenuMorph
		add: 'Inspect query'
		target: aBox model
		selector: #inspect) icon: (UITheme iconNamed: #inspect).
	aBox model == browser initialQuery
		ifTrue: [ ^ self ].
	(aMenuMorph
		add: 'Remove this query'
		target: self
		selector: #removeQuery:
		argumentList: {aBox model}) icon: (UITheme iconNamed: #remove)
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> boxPopup [
	| label |
	label := RSPopup new
		text: [ :model | browser mooseGroupDetails: model result ].
	^ label
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> boxSelection: event [
	browser selectQuery: event shape model.
	self refresh
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> boxSize [
	^ 150
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> buildBoxFor: aQuery [
	| box |
	box := RSBox new
		size: self boxSize;
		model: aQuery;
		color: aQuery class color;
		addInteraction: self boxLabel;
		addInteraction: self boxPopup;
		yourself.
	self boxInteractions: box.
	self decorateSelectedBox: box.
	^ box
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> decorateSelectedBox: box [
	box model == selectedQuery
		ifTrue: [ box border: RSBorder new ]
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> legendOn: canvas [
	| legend |
	queries size == 1
		ifTrue: [ ^ self ].
	legend := RSLegend new.
	legend container: canvas.
	(queries allButFirst collectAsSet: [ :query | query class ])
		do: [ :query | legend text: query label withCircleColor: query color ].
	legend
		leyendDo: [ :l | 
			l
				withBorder;
				padding: 20 ].
	legend location
		outer;
		bottom;
		offset: 0 @ 70.
	legend onDemand: 'Legend'.	"To remove for the legend to be always seen."
	legend build
]

{ #category : #'accessing model' }
FQRoassalQueryPresenter >> openQueryCreationPresenter [
	(FQQueryCreationPresenter on: owner) openWithSpec
]

{ #category : #update }
FQRoassalQueryPresenter >> removeQuery: aQuery [
	owner removeQuery: aQuery.
	self refresh
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> roassalScript: canvas [
	| boxes |
	boxes := owner queries
		collect: [ :queryWrapper | self buildBoxFor: queryWrapper ]
		as: RSGroup.
	boxes @ RSDraggable.
	boxes
		@
			(RSMenuActivable new
				menuDo: [ :menu :box | self boxMenu: menu box: box ]).
	canvas addAll: boxes.
	RSEdgeBuilder line
		canvas: canvas;
		attachPoint: RSBorderAttachPoint new;
		shapes: boxes;
		connectToAll: #children.
	RSDominanceTreeLayout on: canvas nodes.
	self legendOn: canvas.
	canvas @ RSCanvasController new noLegend.
	^ canvas
]

{ #category : #update }
FQRoassalQueryPresenter >> selectItem: aQuery [
	selectedQuery := aQuery.
	self refresh
]
