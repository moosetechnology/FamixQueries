Class {
	#name : #FQNavigationQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'outgoing',
		'associations',
		'directions'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQNavigationQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		beNotHomogeneous;
		add: #directions;
		add: #associations;
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

{ #category : #'instance creation' }
FQNavigationQueriesPresenter class >> title [
	^ 'Navigation Query'
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
	directions := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availableDirections;
		presenter: SpRadioButtonPresenter
			configuredAs: [ :presenter :direction | 
			presenter
				label: direction label;
				whenActivatedDo: [ queryBuilder changeQueryNavigationDirection: direction.
					self updateAssociationsCheckBoxes ];
				yourself ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	directions presenters first
		associatedRadioButtons: directions presenters allButFirst.
	queryBuilder
		changeQueryNavigationDirection: queryBuilder availableDirections first
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self initializeDirectionRadioButtons.
	self initializeAssociationsCheckBoxes
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> updateAssociationsCheckBoxes [
	associations := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder defaultAssociations;
		presenter: SpCheckBoxPresenter
			configuredAs: [ :presenter :associationTrait | 
			presenter
				label: (associationTrait name withoutPrefix: 'FamixT');
				whenActivatedDo: [ queryBuilder addAssociation: associationTrait ];
				whenDeactivatedDo: [ queryBuilder removeAssociation: associationTrait ].
			(queryBuilder availableAssociations includes: associationTrait)
				ifTrue: [ presenter state: true ]
				ifFalse: [ presenter disable ] ];
		layoutBuilder: (SpDynamicLeftToRightRowsLayout rows: 1);
		build.
	associations presenters
		detect: #state
		ifNone: [ self button disable ]
]
