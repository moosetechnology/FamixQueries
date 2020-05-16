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
	#category : #'Famix-Queries-Browser-Widgets'
}

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> adaptName: aString [
	^ aString
		copyReplaceAll: Character space asString
		with: Character cr asString
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> adaptToBrowser: aBrowser [
	browser := aBrowser.
	selectedQuery := aBrowser selectedQuery.
	self script: [ :canvas | self roassalScriptOn: canvas ]
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> boxDraggedAction: box [
	| potentialParents |
	owner selectQuery: box model.
	potentialParents := box canvas shapes
		select: [ :shape | 
			(shape isKindOf: RSBox)
				and: [ shape ~= box
						and: [ shape encompassingRectangle intersects: box encompassingRectangle ] ] ].
	potentialParents size == 1
		ifTrue: [ owner
				openCombinationPresenterFor: potentialParents first model
				and: box model ].
	self refresh
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> boxInteractions: box [
	hasInteractions
		ifFalse: [ ^ self ].
	box @ RSDraggable.
	box
		when: RSMouseClick
			do: [ :event | self boxSelectionAction: event shape ];
		when: RSMouseDoubleClick
			do: [ :event | browser openQueryCreationPresenter ];
		when: RSMouseDragEnd
			do: [ :event | self boxDraggedAction: event shape ]
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> boxLabel [
	| label |
	label := RSLabeled new
		text: [ :model | 
			self flag: #FQImprove.
			self adaptName: model name ].
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
FQRoassalQueryPresenter >> boxSelectionAction: box [
	selectedQuery := box model.
	browser selectQuery: selectedQuery.
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

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> buildTreeOn: canvas for: boxes [
	RSEdgeBuilder line
		canvas: canvas;
		attachPoint: RSBorderAttachPoint new;
		shapes: boxes;
		connectToAll: #children.
	RSDominanceTreeLayout on: canvas nodes
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> createBoxes [
	| boxes |
	boxes := queries
		collect: [ :query | self buildBoxFor: query ]
		as: RSGroup.
	boxes
		@
			(RSMenuActivable new
				menuDo: [ :menu :box | self boxMenu: menu box: box ]).
	^ boxes
]

{ #category : #'boxes configuration' }
FQRoassalQueryPresenter >> decorateSelectedBox: box [
	box model == selectedQuery
		ifFalse: [ ^ self ].
	box border: (RSBorder new width: 2).

	"Does not work because the label is built (then known from the shape) only when the canvas is built."
	box properties at: #RSLabeled ifPresent: [ :label | label bold ]
]

{ #category : #initialization }
FQRoassalQueryPresenter >> initialize [
	super initialize.
	self withInteractions
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> legendOn: canvas [
	| legend |
	queries size == 1
		ifTrue: [ ^ self ].
	legend := RSLegend new.
	legend container: canvas.
	(queries allButFirst collectAsSet: [ :query | query class ])
		do: [ :queryClass | legend text: queryClass label withCircleColor: queryClass color ].
	legend
		leyendDo: [ :l | 
			l
				withBorder;
				padding: 20 ].
	legend location
		outer;
		bottom;
		offset: 0 @ 70.
	legend onDemand: 'Legend'.
	legend build
]

{ #category : #interactions }
FQRoassalQueryPresenter >> noInteractions [
	hasInteractions := false
]

{ #category : #update }
FQRoassalQueryPresenter >> removeQuery: aQuery [
	owner removeQuery: aQuery.
	self refresh
]

{ #category : #'roassal script' }
FQRoassalQueryPresenter >> roassalScriptOn: canvas [
	| boxes |
	boxes := self createBoxes.
	canvas addAll: boxes.
	self buildTreeOn: canvas for: boxes.
	self legendOn: canvas.
	canvas @ RSCanvasController new noLegend.
	^ canvas
]

{ #category : #update }
FQRoassalQueryPresenter >> selectItem: aQuery [
	selectedQuery := aQuery.
	self refresh
]

{ #category : #accessing }
FQRoassalQueryPresenter >> selectedItem [
	^ selectedQuery
]

{ #category : #'accessing model' }
FQRoassalQueryPresenter >> setModelBeforeInitialization: aQueriesCollection [
	queries := aQueriesCollection asOrderedCollection
]

{ #category : #update }
FQRoassalQueryPresenter >> updateForQuery: newQuery [
	self
		flag:
			#FQImprove
				, 'maybe change mechanism, why is there 2 #update... methods ?'.
	queries add: newQuery.
	self selectItem: newQuery
]

{ #category : #update }
FQRoassalQueryPresenter >> updateWithQueries: aQueriesCollection [
	queries := aQueriesCollection asOrderedCollection.
	self selectItem: aQueriesCollection last
]

{ #category : #interactions }
FQRoassalQueryPresenter >> withInteractions [
	hasInteractions := true
]
