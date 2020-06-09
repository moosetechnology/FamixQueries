Class {
	#name : #FQNavigationQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #running }
FQNavigationQueriesPresenter class >> queryClass [
	^ FQNavigationQuery
]

{ #category : #specs }
FQNavigationQueriesPresenter class >> title [
	^ 'Navigation Query'
]

{ #category : #'widgets configuration' }
FQNavigationQueriesPresenter >> configureCheckBox: checkBox forNavigationAssociation: associationTrait [
	self setStateOfCheckBox: checkBox association: associationTrait.
	checkBox
		label: (associationTrait name withoutPrefix: self class traitPrefix);
		whenActivatedDo: [ self query addAssociation: associationTrait ];
		whenDeactivatedDo: [ [ self query removeAssociation: associationTrait ]
				on: FQCannotRemoveLastNavigationAssociation
				do: [ checkBox state: true
					"Spec does not allow this to work" ] ].
	checkBox
		whenChangedDo: [ self update.
			self notifyQueryChanged ]
]

{ #category : #'widgets configuration' }
FQNavigationQueriesPresenter >> configureRadioButton: radioButton forNavigationDirection: direction [
	radioButton
		state: self query directionStrategy == direction;
		label: direction label;
		whenActivatedDo: [ self query resetAndChangeDirection: direction.
			self updateAccordingToDirection.
			self notifyQueryChanged ]
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializeAssociationsCheckBoxes [
	self updateAccordingToDirection
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializeDirectionRadioButtons [
	firstParameter := SpDynamicPresentersListBuilder new
		modelObjects: self query class directionStrategies;
		presenter: SpRadioButtonPresenter
			configuredAs: [ :radioButton :direction | 
			self
				configureRadioButton: radioButton
				forNavigationDirection: direction ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	(firstParameter presenters detect: #state)
		associatedRadioButtons: firstParameter presenters allButFirst
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializePresenters [
	self initializeDirectionRadioButtons.
	self initializeAssociationsCheckBoxes
]

{ #category : #'widgets configuration' }
FQNavigationQueriesPresenter >> selectCurrentQueryDirection [
	(firstParameter presenters
		detect:
			[ :radioButton | radioButton label = self query directionStrategy label ])
		state: true
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> setAssociationsCheckBoxesConstraints [
	| checkBoxes |
	"Dynamic layout involves NullPresenters, they will not answer to #enable, #disable"
	checkBoxes := secondParameter presenters
		reject: [ :pres | pres class == SpNullPresenter ].

	"Disable active checkBoxes when the query has only one association, to forbid removing it."
	checkBoxes
		do: [ :association | 
			association
				whenChangedDo: [ self query associationStrategy associations size == 1
						ifTrue: [ checkBoxes select: #state thenDo: #disable ]
						ifFalse: [ checkBoxes select: #state thenDo: #enable ] ] ]
]

{ #category : #'widgets configuration' }
FQNavigationQueriesPresenter >> setStateOfCheckBox: checkBox association: associationTrait [
	checkBox
		state:
			(self query associationStrategy associations
				includes: associationTrait).
	checkBox
		enabled:
			(self query associationStrategy associations size > 1
				and: [ self query availableAssociations includes: associationTrait ])
]

{ #category : #update }
FQNavigationQueriesPresenter >> showAssociationsCheckBoxes [
	secondParameter := SpDynamicPresentersListBuilder new
		modelObjects: self query class allPossibleAssociations;
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
	self query availableAssociations
		ifEmpty: [ secondParameter := self noParameterMessage: 'association' ]
		ifNotEmpty: [ self showAssociationsCheckBoxes ].
	self update
]
