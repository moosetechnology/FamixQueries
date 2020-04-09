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
	(self
		on:
			(FQQueryBuilder default
				buildScopeQueryWithDirection: FQScopeUpDirection;
				yourself)) openWithSpec
]

{ #category : #initialization }
FQScopeQueriesPresenter class >> queryBuilderClass [
	^ FQScopeQueryBuilder
]

{ #category : #accessing }
FQScopeQueriesPresenter class >> queryClass [
	^ FQScopeQuery
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
			self updateScopesDropList ]
]

{ #category : #initialization }
FQScopeQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self intializeDirectionRadioButtons.
	self initializeScopesDropList.
	self updateScopesDropList
]

{ #category : #initialization }
FQScopeQueriesPresenter >> initializeScopesDropList [
	scopesDropList := self newDropList
		whenSelectedItemChangedDo: [ :scope | 
			self queryBuilder changeQueryScope: scope.
			self notifyQueryChanged ];
		items: self queryBuilder availableScopes;
		display: [ :item | item name withoutPrefix: self modelPrefix ]
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

{ #category : #update }
FQScopeQueriesPresenter >> updateScopesDropList [
	scopesDropList
		resetSelection;
		items: self queryBuilder availableScopes.
	scopesDropList listItems
		ifEmpty: [ self button disable ]
		ifNotEmpty: [ self button enable ]
]
