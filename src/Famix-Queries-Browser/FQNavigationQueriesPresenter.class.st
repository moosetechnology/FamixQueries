Class {
	#name : #FQNavigationQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#category : #'Famix-Queries-Browser-Presenters'
}

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
				on: FQCannotRemoveLastNavigationAssociation
				do: [ checkBox state: true
					"Spec does not allow this to work" ] ];
		whenChangedDo: [ self notifyQueryChanged ];
		enabled: queryBuilder query associationStrategy associations size > 1.
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
		whenActivatedDo: [ [ queryBuilder changeQueryNavigationDirection: direction ]
				on: FQImpossibleQuery
				do: [ self flag: 'Manage this error better' ].
			self updateAccordingToDirection ]
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializeAssociationsCheckBoxes [
	self updateAccordingToDirection
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializeDirectionRadioButtons [
	firstParameter := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availableDirections;
		presenter: SpRadioButtonPresenter
			configuredAs: [ :radioButton :direction | 
			self
				configureRadioButton: radioButton
				forNavigationDirection: direction ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	firstParameter presenters first
		associatedRadioButtons: firstParameter presenters allButFirst
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializePresenters [
	self initializeDirectionRadioButtons.
	self initializeAssociationsCheckBoxes
]

{ #category : #'widgets configuration' }
FQNavigationQueriesPresenter >> setAssociationsCheckBoxesConstraints [
	| checkBoxes |
	"Dynamic layout involves NullPresenters, they will not answer to #enable, #disable"
	checkBoxes := secondParameter presenters
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
	secondParameter := SpDynamicPresentersListBuilder new
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
		ifEmpty: [ secondParameter := self noParameterMessage: 'association' ]
		ifNotEmpty: [ self showAssociationsCheckBoxes ].
	self update
]
