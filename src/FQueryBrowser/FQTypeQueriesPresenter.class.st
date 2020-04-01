Class {
	#name : #FQTypeQueriesPresenter,
	#superclass : #FQQueryConfigurationPresenter,
	#instVars : [
		'types'
	],
	#category : #'FQueryBrowser-Presenters'
}

{ #category : #specs }
FQTypeQueriesPresenter class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add: #types;
		add: self creationButton;
		spacing: 5;
		yourself
]

{ #category : #'instance creation' }
FQTypeQueriesPresenter class >> open [
	<script>
	(self on: FQTypeQueriesModel default) openWithSpec
]

{ #category : #specs }
FQTypeQueriesPresenter class >> title [
	^ 'Type Query'
]

{ #category : #initialization }
FQTypeQueriesPresenter >> initializePresenters [
	super initializePresenters.
	self instanciateTypeCheckBoxes
]

{ #category : #initialization }
FQTypeQueriesPresenter >> instanciateTypeCheckBoxes [
	types := SpDynamicPresentersListBuilder new
		modelObjects: model queriesDict associations;
		presenter: SpCheckBoxPresenter
			configuredAs: [ :presenter :modelObject | 
			presenter
				label: modelObject value;
				whenActivatedDo: [ model stateDict at: modelObject key put: true ];
				whenDeactivatedDo: [ model stateDict at: modelObject key put: false ];
				state: true;
				yourself ];
		layoutBuilder: (SpDynamicLeftToRightRowsLayout rows: model queriesDict size // 3);
		build
]
