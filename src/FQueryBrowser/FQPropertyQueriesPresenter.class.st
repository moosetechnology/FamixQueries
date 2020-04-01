Class {
	#name : #FQPropertyQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'queryParameters',
		'propertyType'
	],
	#category : #'FQueryBrowser-Presenters'
}

{ #category : #specs }
FQPropertyQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #propertyType;
		add: #queryParameters;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #'instance creation' }
FQPropertyQueriesPresenter class >> open [
	<script>
	(self on: FQPropertyQueriesModel default) openWithSpec
]

{ #category : #specs }
FQPropertyQueriesPresenter class >> title [
	^ 'Property Query'
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self initializeQueryTypeRadioButtons.
	queryParameters := self newNullPresenter.
	self initializeQueryParameters
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeQueryParameters [
	self updateQueryParameters: #boolean
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> initializeQueryTypeRadioButtons [
	propertyType := SpDynamicPresentersListBuilder new
		modelObjects: model propertiesTypes;
		presenter: SpRadioButtonPresenter
			configuredAs: [ :presenter :modelObject | 
			presenter
				label: modelObject asString capitalized;
				whenActivatedDo: [ self updateQueryParameters: modelObject ];
				yourself ];
		layoutBuilder: (SpDynamicTopToBottomRowsLayout rows: 1);
		build.
	propertyType presenters first
		associatedRadioButtons: propertyType presenters allButFirst
]

{ #category : #accessing }
FQPropertyQueriesPresenter >> queryParameters [
	^ queryParameters
]

{ #category : #accessing }
FQPropertyQueriesPresenter >> queryParameters: anObject [
	queryParameters := anObject
]

{ #category : #initialization }
FQPropertyQueriesPresenter >> updateQueryParameters: aQueryType [
	| builder |
	model newQueryTyped: aQueryType.
	builder := SpDynamicPresentersListBuilder new
		modelObjects: (model parametersDict at: aQueryType);
		presenterProvidedBy: [ :configurator | configurator presenterClass ]
			configuredAs:
				[ :presenter :configurator | configurator configurePresenter: presenter ];
		layoutBuilder:
			((SpDynamicTopToBottomRowsLayout rows: 1)
				constraintBlock: [ :c | 
					c
						height: self class buttonHeight + 5;
						padding: 5;
						yourself ];
				yourself).
	self
		newDynamicPresentersListIn: #queryParameters
		usingBuilder: builder
]
