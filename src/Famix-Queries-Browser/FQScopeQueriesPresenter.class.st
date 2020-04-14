Class {
	#name : #FQScopeQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'scopesDropList',
		'directionsRadioButtons'
	],
	#category : #'Famix-Queries-Browser-Presenters'
}

{ #category : #specs }
FQScopeQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #directionsRadioButtons;
		add: self scopes;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #specs }
FQScopeQueriesPresenter class >> open [
	<script>
	super open
]

{ #category : #initialization }
FQScopeQueriesPresenter class >> queryBuilderClass [
	^ FQScopeQueryBuilder
]

{ #category : #specs }
FQScopeQueriesPresenter class >> scopes [
	^ SpBoxLayout newVertical
		add: #scopesDropList
			expand: true
			fill: true
			padding: 50;
		yourself
]

{ #category : #specs }
FQScopeQueriesPresenter class >> title [
	^ 'Scope Query'
]

{ #category : #'widgets configuration' }
FQScopeQueriesPresenter >> configureRadioButton: radioButton forScopeDirection: direction [
	radioButton
		label: direction label;
		whenActivatedDo: [ self queryBuilder changeQueryDirection: direction.
			self updateAccordingToDirection.
			self notifyQueryChanged ]
]

{ #category : #initialization }
FQScopeQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self intializeDirectionRadioButtons.
	self initializeScopesDropList
]

{ #category : #initialization }
FQScopeQueriesPresenter >> initializeScopesDropList [
	self updateAccordingToDirection
]

{ #category : #initialization }
FQScopeQueriesPresenter >> intializeDirectionRadioButtons [
	directionsRadioButtons := SpDynamicPresentersListBuilder new
		modelObjects: queryBuilder availableScopeDirections;
		presenter: SpRadioButtonPresenter
			configuredAs:
				[ :radioButton :direction | self configureRadioButton: radioButton forScopeDirection: direction ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	directionsRadioButtons presenters first
		associatedRadioButtons: directionsRadioButtons presenters allButFirst
]

{ #category : #'widgets configuration' }
FQScopeQueriesPresenter >> showNoScopeAvailable [
	^ scopesDropList := self
		instantiate: FQNoPossibleQueryPresenter
		on: 'scope'
]

{ #category : #'widgets configuration' }
FQScopeQueriesPresenter >> showScopesDropList [
	^ scopesDropList := self newDropList
		items: self queryBuilder availableScopes;
		display: [ :item | item name withoutPrefix: self modelPrefix ];
		whenSelectedItemChangedDo: [ :scope | 
			self queryBuilder changeQueryScope: scope.
			self notifyQueryChanged ]
]

{ #category : #update }
FQScopeQueriesPresenter >> updateAccordingToDirection [
	self queryBuilder availableScopes
		ifNotEmpty: [ self showScopesDropList.
			self button enable ]
		ifEmpty: [ self showNoScopeAvailable.
			self button disable ].
	self update
]
