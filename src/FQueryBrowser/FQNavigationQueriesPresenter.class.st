Class {
	#name : #FQNavigationQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'incoming',
		'outgoing',
		'associations'
	],
	#category : #'FQueryBrowser-Presenters'
}

{ #category : #specs }
FQNavigationQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		beNotHomogeneous;
		add:
			(SpBoxLayout newVertical
				add: #incoming;
				add: #outgoing;
				yourself);
		add: #associations;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #'instance creation' }
FQNavigationQueriesPresenter class >> open [
	<script>
	(self on: FQNavigationQueriesModel default) openWithSpec
]

{ #category : #'instance creation' }
FQNavigationQueriesPresenter class >> title [
	^ 'Navigation Query'
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializeAssociationsCheckBoxes [
	associations := SpDynamicPresentersListBuilder new
		modelObjects: model queriesDict associations;
		presenter: SpCheckBoxPresenter
			configuredAs: [ :presenter :modelObject | 
			presenter
				label: modelObject value;
				whenActivatedDo: [ model stateDict at: modelObject key put: true ];
				whenDeactivatedDo: [ model stateDict at: modelObject key put: false ];
				state: true;
				yourself ];
		layoutBuilder: (SpDynamicLeftToRightRowsLayout rows: 1);
		build
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializeDirectionRadioButtons [
	incoming := self newRadioButton
		label: 'Incoming';
		whenActivatedDo: [ self model direction: #incoming ].
	outgoing := self newRadioButton
		label: 'Outgoing';
		whenActivatedDo: [ self model direction: #outgoing ].
	incoming associatedRadioButtons: {outgoing}
]

{ #category : #initialization }
FQNavigationQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self initializeDirectionRadioButtons.
	self initializeAssociationsCheckBoxes
]
