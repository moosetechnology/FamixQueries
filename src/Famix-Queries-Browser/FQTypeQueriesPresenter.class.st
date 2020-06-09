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
FQTypeQueriesPresenter class >> maximumCheckBoxesPerColumn [
	^ 6
]

{ #category : #running }
FQTypeQueriesPresenter class >> queryClass [
	^ FQTypeQuery
]

{ #category : #specs }
FQTypeQueriesPresenter class >> title [
	^ 'Type Query'
]

{ #category : #'widgets configuration' }
FQTypeQueriesPresenter >> configureTypeCheckBox: checkBox forType: type [
	checkBox
		state: (self query types includes: type);
		enabled: self query types size > 1;
		label: type mooseDescription name;
		whenActivatedDo: [ self query addType: type ];
		whenDeactivatedDo: [ [ self query removeType: type ]
				on: FQCannotRemoveLastType
				do: [ checkBox state: true.
					self flag: #FQSpecPb	"Spec does not allow this to work" ] ];
		whenChangedDo: [ self update.
			self notifyQueryChanged ]
]

{ #category : #initialization }
FQTypeQueriesPresenter >> initializePresenters [
	firstParameter := self newNullPresenter hide.
	self initializeTypeCheckBoxes
]

{ #category : #initialization }
FQTypeQueriesPresenter >> initializeTypeCheckBoxes [
	self query availableTypes
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
				whenChangedDo: [ self query types size == 1
						ifTrue: [ checkBoxes select: #state thenDo: #disable ]
						ifFalse: [ checkBoxes do: #enable ] ] ]
]

{ #category : #'widgets configuration' }
FQTypeQueriesPresenter >> showTypesCheckBoxes [
	secondParameter := SpDynamicPresentersListBuilder new
		modelObjects: self query availableTypes;
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
		columns: (self query types size min: self class maximumCheckBoxesPerColumn)
]

{ #category : #update }
FQTypeQueriesPresenter >> updateForQuery: aQuery [
	super updateForQuery: aQuery.
	self updateTypeCheckBoxesForTypes: aQuery types
]

{ #category : #update }
FQTypeQueriesPresenter >> updateTypeCheckBoxesForTypes: types [
	| checkBoxesToTick |
	checkBoxesToTick := firstParameter presenters
		select: [ :checkBox | 
			(types collect: [ :type | type mooseDescription name ])
				includes: checkBox label ].
	checkBoxesToTick do: [ :cb | cb state: true ].
	firstParameter presenters \ checkBoxesToTick
		do: [ :cb | cb state: false ]
]
