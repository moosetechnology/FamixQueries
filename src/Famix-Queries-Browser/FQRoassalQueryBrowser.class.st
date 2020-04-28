Class {
	#name : #FQRoassalQueryBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'queriesGraph',
		'queriesCombinator',
		'selectedQuery'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #'instance creation' }
FQRoassalQueryBrowser class >> classesAndMethods [
	| model |
	model := self modelExample.
	^ MooseGroup
		withAll:
			{model allModelClasses.
			model allModelMethods} flatten
]

{ #category : #specs }
FQRoassalQueryBrowser class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #queriesGraph;
		yourself
]

{ #category : #'instance creation' }
FQRoassalQueryBrowser class >> modelExample [
	| model |
	model := FamixStModel new.
	MoosePharoImporterTask new
		importerClass: SmalltalkImporter;
		model: model;
		addFromPackageNamed: #'Moose-TestResources-LAN';
		run.
	^ model
]

{ #category : #'instance creation' }
FQRoassalQueryBrowser class >> open [
	<script>
	(self on: self classesAndMethods) openWithSpec
]

{ #category : #specs }
FQRoassalQueryBrowser class >> title [
	^ 'Roassal Queries Browser'
]

{ #category : #roassal }
FQRoassalQueryBrowser >> boxDraggedAction: event [
	self selectedQuery: event shape model.
	(event canvas shapes
		select: [ :shape | 
			(shape isKindOf: RSBox)
				and: [ shape ~= event shape
						and: [ shape encompassingRectangle
								intersects: event shape encompassingRectangle ] ] ])
		ifNotEmpty: [ :parents | 
			queriesCombinator
				addUnionQueryBetween: parents first model
				and: event shape model ].
	queriesGraph refresh
]

{ #category : #roassal }
FQRoassalQueryBrowser >> boxLabel [
	| label |
	label := RSLabeled new
		text: [ :model | model label substrings first ].
	label location
		inner;
		middle.
	^ label
]

{ #category : #roassal }
FQRoassalQueryBrowser >> boxMenu: aMenuMorph box: aBox [
	(aMenuMorph
		add: 'Create a new query after this one'
		target: self
		selector: #openQueryCreationPresenter)
		icon: (UITheme iconNamed: #add).
	(aMenuMorph
		add: 'Inspect query'
		target: aBox model
		selector: #inspect) icon: (UITheme iconNamed: #inspect).
	aBox model == queriesCombinator initialQuery
		ifTrue: [ ^ self ].
	(aMenuMorph
		add: 'Remove this query'
		target: self
		selector: #removeQuery:
		argumentList: {aBox model}) icon: (UITheme iconNamed: #remove)
]

{ #category : #roassal }
FQRoassalQueryBrowser >> boxPopup [
	| label |
	label := RSPopup new text: [ :model | model label ].
	^ label
]

{ #category : #roassal }
FQRoassalQueryBrowser >> boxSelection: event [
	self selectedQuery: event shape model.
	queriesGraph refresh
]

{ #category : #roassal }
FQRoassalQueryBrowser >> boxSize [
	^ 90
]

{ #category : #roassal }
FQRoassalQueryBrowser >> buildBoxFor: queryWrapper [
	| box |
	box := RSBox new
		size: self boxSize;
		model: queryWrapper;
		color: queryWrapper color;
		addInteraction: self boxLabel;
		addInteraction: self boxPopup;
		when: RSMouseClick do: [ :event | self boxSelection: event ];
		when: RSMouseDoubleClick
			do: [ :event | self openQueryCreationPresenter ];
		when: RSMouseDragEnd do: [ :event | self boxDraggedAction: event ];
		yourself.
	self decorateSelectedBox: box.
	^ box
]

{ #category : #roassal }
FQRoassalQueryBrowser >> decorateSelectedBox: box [
	box model == selectedQuery
		ifTrue: [ box border: RSBorder new ]
]

{ #category : #roassal }
FQRoassalQueryBrowser >> displayScript: canvas [
	| boxes |
	boxes := queriesCombinator queries
		collect: [ :queryWrapper | self buildBoxFor: queryWrapper ]
		as: RSGroup.
	boxes @ RSDraggable.
	boxes
		@
			(RSMenuActivable new
				menuDo: [ :menu :box | self boxMenu: menu box: box ]).
	canvas addAll: boxes.
	RSEdgeBuilder orthoVertical
		canvas: canvas;
		attachPoint: RSVerticalAttachPoint new;
		shapes: boxes;
		connectToAll: #children.
	RSTreeLayout on: canvas nodes.
	canvas @ RSCanvasController.
	^ canvas
]

{ #category : #'plugin interface' }
FQRoassalQueryBrowser >> entities [
	^ queriesCombinator resultOfQuery: self selectedQuery
]

{ #category : #initialization }
FQRoassalQueryBrowser >> initializePresenters [
	queriesGraph := (self instantiate: SpRoassalPresenter)
		script: [ :canvas | self displayScript: canvas ]
]

{ #category : #initialization }
FQRoassalQueryBrowser >> openQueryCreationPresenter [
	(FQQueryCreationPresenter on: self) openWithSpec
]

{ #category : #roassal }
FQRoassalQueryBrowser >> removeQuery: aQuery [
	queriesCombinator removeQuery: aQuery.
	self update
]

{ #category : #accessing }
FQRoassalQueryBrowser >> selectedQuery [
	^ selectedQuery
]

{ #category : #accessing }
FQRoassalQueryBrowser >> selectedQuery: aQueryWrapper [
	selectedQuery := aQueryWrapper
]

{ #category : #'accessing model' }
FQRoassalQueryBrowser >> setModelBeforeInitialization: aMooseGroup [
	queriesCombinator := FQQueriesCombinator newWithEntities: aMooseGroup.
	selectedQuery := queriesCombinator initialQuery
]

{ #category : #update }
FQRoassalQueryBrowser >> updateForQuery: aQuery [
	self
		selectedQuery: (queriesCombinator addQuery: aQuery after: self selectedQuery).
	queriesGraph refresh.
	self update
]
