Class {
	#name : #FQTypeQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'types'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQTypeQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #types;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #'instance creation' }
FQTypeQueriesPresenter class >> open [
	<script>
	(self
		on:
			(FQQueryBuilder default
				buildTypeQuery;
				yourself)) openWithSpec
]

{ #category : #specs }
FQTypeQueriesPresenter class >> title [
	^ 'Type Query'
]

{ #category : #initialization }
FQTypeQueriesPresenter >> configureTypeChecBox: presenter forType: type [
	^ presenter
		label: (type name withoutPrefix: self modelPrefix);
		whenActivatedDo: [ queryBuilder addTypeToQuery: type ];
		whenDeactivatedDo: [ [ queryBuilder removeTypeFromQuery: type ]
				on: FQTypeQueryMustHaveAtLeastOneType
				do: [ presenter state: true.
					self flag: 'Spec does not allow this to work' ] ];
		state: true;
		yourself
]

{ #category : #initialization }
FQTypeQueriesPresenter >> initializeBuilder [
	queryBuilder buildTypeQuery
]

{ #category : #initialization }
FQTypeQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self instanciateTypeCheckBoxes
]

{ #category : #initialization }
FQTypeQueriesPresenter >> instanciateTypeCheckBoxes [
	queryBuilder availableTypes
		ifEmpty: [ self resetLayoutForImpossibleQuery.
			^ self ].
	types := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availableTypes;
		presenter: SpCheckBoxPresenter
			configuredAs:
				[ :presenter :type | self configureTypeChecBox: presenter forType: type ];
		layoutBuilder: self typeCheckBoxesLayout;
		build.
	self setTypeCheckboxesConstraints
]

{ #category : #initialization }
FQTypeQueriesPresenter >> resetLayoutForImpossibleQuery [
	layout := SpBoxLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: 'No type available'
				expand: true
				fill: true
				padding: 55);
		add: self class creationButton;
		yourself.
	self button disable
]

{ #category : #initialization }
FQTypeQueriesPresenter >> setTypeCheckboxesConstraints [
	| checkBoxes |
	"Dynamic layout involves NullPresenters, they will not answer to #enable, #disable"
	checkBoxes := types presenters
		reject: [ :pres | pres class == SpNullPresenter ].

	"Disable active checkBoxes when the query has only one type, to forbid removing it."
	checkBoxes
		do: [ :type | 
			type
				whenChangedDo: [ queryBuilder query types size == 1
						ifTrue: [ checkBoxes select: #state thenDo: #disable ]
						ifFalse: [ checkBoxes do: #enable ] ] ]
]

{ #category : #initialization }
FQTypeQueriesPresenter >> typeCheckBoxesLayout [
	^ SpDynamicTopToBottomColumnsLayout
		columns: (queryBuilder availableTypes size min: 6)	"min: 6 to avoid more than 6 checkboxes / column"
]
