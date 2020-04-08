Class {
	#name : #FQBooleanQueryParametersPresenter,
	#superclass : #FQPropertyQueryParametersPresenter,
	#category : #'Famix-Queries-Browser-PropertyQueryParametersPresenters'
}

{ #category : #specs }
FQBooleanQueryParametersPresenter class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #properties
			expand: true
			fill: true
			padding: 50;
		yourself
]

{ #category : #'instance creation' }
FQBooleanQueryParametersPresenter class >> open [
	<script>
	^ self basicNew
		setModelBeforeInitialization:
			(FQQueryBuilder default
				buildPropertyQuery: FQBooleanQuery;
				yourself);
		initialize;
		openWithSpec
]

{ #category : #accessing }
FQBooleanQueryParametersPresenter class >> queryClass [
	^ FQBooleanQuery
]
