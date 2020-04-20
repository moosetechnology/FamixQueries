Class {
	#name : #FQTypeQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQTypeQueriesPresenter class >> addFirstParameterToLayout: defaultLayout [
	defaultLayout add: #firstParameter width: 0
]

{ #category : #specs }
FQTypeQueriesPresenter class >> firstParameterConstraints [
	^ [ :constraint | constraint width: 0 ]
]

{ #category : #specs }
FQTypeQueriesPresenter class >> maximumCheckBoxesPerColumn [
	^ 6
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
		state: (queryBuilder currentQueryTypes includes: type);
		enabled: queryBuilder currentQueryTypes size > 1
]

{ #category : #initialization }
FQTypeQueriesPresenter >> initializePresenters [
	firstParameter := self newNullPresenter hide.
	self initializeTypeCheckBoxes
]

{ #category : #initialization }
FQTypeQueriesPresenter >> initializeTypeCheckBoxes [
	queryBuilder availableTypes
		ifEmpty: [ secondParameter := self noParameterMessage: 'type' ]
		ifNotEmpty: [ self showTypesCheckBoxes ]
]

{ #category : #'widgets configuration' }
FQTypeQueriesPresenter >> setTypeCheckBoxesConstraints [
	| checkBoxes |
	"Dynamic layout involves NullPresenters, they will not answer to #enable, #disable"
	checkBoxes := secondParameter presenters
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
FQTypeQueriesPresenter >> showTypesCheckBoxes [
	secondParameter := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availableTypes;
		presenter: SpCheckBoxPresenter
			configuredAs:
				[ :presenter :type | self configureTypeCheckBox: presenter forType: type ];
		layoutBuilder: self typeCheckBoxesLayout;
		build.
	^ self setTypeCheckBoxesConstraints
]

{ #category : #'widgets configuration' }
FQTypeQueriesPresenter >> typeCheckBoxesLayout [
	^ SpDynamicTopToBottomColumnsLayout
		columns:
			(queryBuilder availableTypes size
				min: self class maximumCheckBoxesPerColumn)
]
