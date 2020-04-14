Class {
	#name : #FQTypeQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'typesCheckBoxes'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQTypeQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #typesCheckBoxes;
		yourself
]

{ #category : #'instance creation' }
FQTypeQueriesPresenter class >> open [
	<script>
	super open
]

{ #category : #initialization }
FQTypeQueriesPresenter class >> queryBuilderClass [
	^ FQTypeQueryBuilder 
]

{ #category : #specs }
FQTypeQueriesPresenter class >> title [
	^ 'Type Query'
]

{ #category : #'widgets configuration' }
FQTypeQueriesPresenter >> configureTypeCheckBox: checkBox forType: type [
	checkBox
		label: (type name withoutPrefix: self modelPrefix);
		whenActivatedDo: [ queryBuilder addTypeToQuery: type ];
		whenDeactivatedDo: [ [ queryBuilder removeTypeFromQuery: type ]
				on: FQTypeQueryMustHaveAtLeastOneType
				do: [ checkBox state: true
					"Spec does not allow this to work" ] ];
		whenChangedDo: [ self notifyQueryChanged ];
		state: (queryBuilder currentQueryTypes includes: type)
]

{ #category : #initialization }
FQTypeQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self initializeTypeCheckBoxes
]

{ #category : #initialization }
FQTypeQueriesPresenter >> initializeTypeCheckBoxes [
	queryBuilder availableTypes
		ifEmpty: [ self resetLayoutForImpossibleQuery.
			^ self ].
	typesCheckBoxes := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availableTypes;
		presenter: SpCheckBoxPresenter
			configuredAs:
				[ :presenter :type | self configureTypeCheckBox: presenter forType: type ];
		layoutBuilder: self typeCheckBoxesLayout;
		build.
	self setTypeCheckBoxesConstraints
]

{ #category : #update }
FQTypeQueriesPresenter >> resetLayoutForImpossibleQuery [
	layout := SpBoxLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: 'No type available'
				expand: true
				fill: true
				padding: 55);
		yourself
]

{ #category : #'widgets configuration' }
FQTypeQueriesPresenter >> setTypeCheckBoxesConstraints [
	| checkBoxes |
	"Dynamic layout involves NullPresenters, they will not answer to #enable, #disable"
	checkBoxes := typesCheckBoxes presenters
		reject: [ :pres | pres class == SpNullPresenter ].

	"Disable active checkBoxes when the query has only one type, to forbid removing it."
	checkBoxes
		do: [ :type | 
			type
				whenChangedDo: [ queryBuilder currentQueryTypes size == 1
						ifTrue: [ checkBoxes select: #state thenDo: #disable ]
						ifFalse: [ checkBoxes do: #enable ] ] ]
]

{ #category : #'widgets configuration' }
FQTypeQueriesPresenter >> typeCheckBoxesLayout [
	^ SpDynamicTopToBottomColumnsLayout
		columns: (queryBuilder availableTypes size min: 6)	"min: 6 to avoid more than 6 checkboxes / column"
]
