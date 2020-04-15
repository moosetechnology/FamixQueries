Class {
	#name : #FQNavigationQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'directionsRadioButtons',
		'associationsCheckBoxes'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQNavigationQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #directionsRadioButtons;
		add: #associationsCheckBoxes;
		yourself
]

{ #category : #'instance creation' }
FQNavigationQueriesPresenter class >> open [
	<script>
	super open
]

{ #category : #initialization }
FQNavigationQueriesPresenter class >> queryBuilderClass [
	^ FQNavigationQueryBuilder
]

{ #category : #'instance creation' }
FQNavigationQueriesPresenter class >> title [
	^ 'Navigation Query'
]

{ #category : #'widgets configuration' }
FQNavigationQueriesPresenter >> configureCheckBox: checkBox forNavigationAssociation: associationTrait [
	checkBox
		label: (associationTrait name withoutPrefix: 'FamixT');
		whenActivatedDo: [ queryBuilder addAssociationToQuery: associationTrait ];
		whenDeactivatedDo: [ [ queryBuilder removeAssociationFromQuery: associationTrait ]
				on: FQNavigationQueryMustHaveAtLeastOneAssociation
				do: [ checkBox state: true
					"Spec does not allow this to work" ] ];
		whenChangedDo: [ self notifyQueryChanged ].
	(queryBuilder availableAssociations includes: associationTrait)
		ifTrue: [ checkBox state: true ]
		ifFalse: [ checkBox
				state: false;
				disable ]
]

{ #category : #'widgets configuration' }
FQNavigationQueriesPresenter >> configureRadioButton: radioButton forNavigationDirection: direction [
	radioButton
		label: direction label;
		whenActivatedDo: [ queryBuilder changeQueryNavigationDirection: direction.
			self updateAccordingToDirection ]
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializeAssociationsCheckBoxes [
	self updateAccordingToDirection
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializeDirectionRadioButtons [
	directionsRadioButtons := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availableDirections;
		presenter: SpRadioButtonPresenter
			configuredAs: [ :radioButton :direction | 
			self
				configureRadioButton: radioButton
				forNavigationDirection: direction ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	directionsRadioButtons presenters first
		associatedRadioButtons: directionsRadioButtons presenters allButFirst
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self initializeDirectionRadioButtons.
	self initializeAssociationsCheckBoxes
]

{ #category : #'widgets configuration' }
FQNavigationQueriesPresenter >> setAssociationsCheckBoxesConstraints [
	| checkBoxes |
	"Dynamic layout involves NullPresenters, they will not answer to #enable, #disable"
	checkBoxes := associationsCheckBoxes presenters
		reject: [ :pres | pres class == SpNullPresenter ].

	"Disable active checkBoxes when the query has only one type, to forbid removing it."
	checkBoxes
		do: [ :type | 
			type
				whenChangedDo: [ queryBuilder currentQueryAssociations size == 1
						ifTrue: [ checkBoxes select: #state thenDo: #disable ]
						ifFalse: [ checkBoxes select: #state thenDo: #enable ] ] ]
]

{ #category : #update }
FQNavigationQueriesPresenter >> showAssociationsCheckBoxes [
	associationsCheckBoxes := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder allPossibleAssociations;
		presenter: SpCheckBoxPresenter
			configuredAs: [ :checkBox :associationTrait | 
			self
				configureCheckBox: checkBox
				forNavigationAssociation: associationTrait ];
		layoutBuilder: (SpDynamicLeftToRightRowsLayout rows: 1);
		build.
	self setAssociationsCheckBoxesConstraints
]

{ #category : #update }
FQNavigationQueriesPresenter >> updateAccordingToDirection [
	queryBuilder availableAssociations
		ifEmpty: [ associationsCheckBoxes := self noParameterMessage: 'association' ]
		ifNotEmpty: [ self showAssociationsCheckBoxes ].
	self update
]
