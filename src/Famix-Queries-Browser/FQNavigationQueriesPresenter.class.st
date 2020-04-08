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
		beNotHomogeneous;
		add: #directionsRadioButtons;
		add: #associationsCheckBoxes;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #'instance creation' }
FQNavigationQueriesPresenter class >> open [
	<script>
	(self
		on:
			(FQQueryBuilder default
				buildNavigationQuery;
				yourself)) openWithSpec
]

{ #category : #accessing }
FQNavigationQueriesPresenter class >> queryClass [
	^ FQNavigationQuery
]

{ #category : #'instance creation' }
FQNavigationQueriesPresenter class >> title [
	^ 'Navigation Query'
]

{ #category : #'widgets configuration' }
FQNavigationQueriesPresenter >> configureCheckBox: checkBox forNavigationAssociation: associationTrait [
	checkBox
		label: (associationTrait name withoutPrefix: 'FamixT');
		whenActivatedDo: [ queryBuilder addAssociation: associationTrait ];
		whenDeactivatedDo: [ queryBuilder removeAssociation: associationTrait ].
	(queryBuilder availableAssociations includes: associationTrait)
		ifTrue: [ checkBox state: true ]
		ifFalse: [ checkBox disable ]
]

{ #category : #'widgets configuration' }
FQNavigationQueriesPresenter >> configureRadioButton: radioButton forNavigationDirection: direction [
	radioButton
		label: direction label;
		whenActivatedDo: [ queryBuilder changeQueryNavigationDirection: direction.
			self updateAssociationsCheckBoxes ]
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializeAssociationsCheckBoxes [
	self updateAssociationsCheckBoxes
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializeBuilder [
	queryBuilder buildNavigationQuery
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializeDirectionRadioButtons [
	directionsRadioButtons := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availableDirections;
		presenter: SpRadioButtonPresenter
			configuredAs:
				[ :radioButton :direction | self configureRadioButton: radioButton forNavigationDirection: direction ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	directionsRadioButtons presenters first
		associatedRadioButtons: directionsRadioButtons presenters allButFirst.
		
	queryBuilder
		changeQueryNavigationDirection: queryBuilder availableDirections first
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self initializeDirectionRadioButtons.
	self initializeAssociationsCheckBoxes
]

{ #category : #update }
FQNavigationQueriesPresenter >> updateAssociationsCheckBoxes [
	associationsCheckBoxes := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder defaultAssociations;
		presenter: SpCheckBoxPresenter
			configuredAs: [ :checkBox :associationTrait | 
			self
				configureCheckBox: checkBox
				forNavigationAssociation: associationTrait ];
		layoutBuilder: (SpDynamicLeftToRightRowsLayout rows: 1);
		build.
	associationsCheckBoxes presenters
		detect: #state
		ifNone: [ self button disable ]
]
