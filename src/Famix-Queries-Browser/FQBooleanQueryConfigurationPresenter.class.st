Class {
	#name : #FQBooleanQueryConfigurationPresenter,
	#superclass : #FQPropertyQueryConfigurationPresenter,
	#category : #'Famix-Queries-Browser-PropertyQueryConfigurationPresenters'
}

{ #category : #specs }
FQBooleanQueryConfigurationPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #properties
			expand: true
			fill: true
			padding: 50;
		yourself
]

{ #category : #'instance creation' }
FQBooleanQueryConfigurationPresenter class >> open [
	<script>
	^ self basicNew
		setModelBeforeInitialization:
			(FQQueryBuilder default
				buildPropertyQueryTyped: #boolean;
				yourself);
		initialize;
		openWithSpec
]
