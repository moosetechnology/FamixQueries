Class {
	#name : #FQDropListConfigurator,
	#superclass : #FQWidgetConfigurator,
	#instVars : [
		'items'
	],
	#category : #'FQueryBrowser-Tools'
}

{ #category : #'api-shortcuts' }
FQDropListConfigurator class >> items: anItemsCollection [
	^ self new
		items: anItemsCollection;
		yourself
]

{ #category : #'api-shortcuts' }
FQDropListConfigurator class >> model: aModel items: anItemsCollection [
	^ (self model: aModel)
		items: anItemsCollection;
		yourself
]

{ #category : #'api-shortcuts' }
FQDropListConfigurator class >> model: aModel parameterToChange: aParameter items: anItemsCollection [
	^ (self model: aModel parameterToChange: aParameter)
		items: anItemsCollection;
		yourself
]

{ #category : #'as yet unclassified' }
FQDropListConfigurator >> configurePresenter: aDropList [
	^ aDropList
		items: self items;
		whenSelectedItemChangedDo: [ :item | model queryAt: self parameterToChange put: item ];
		selectIndex: 1;
		yourself
]

{ #category : #accessing }
FQDropListConfigurator >> items [
	^ items
]

{ #category : #accessing }
FQDropListConfigurator >> items: anObject [
	items := anObject
]

{ #category : #accessing }
FQDropListConfigurator >> presenterClass [
	^ SpDropListPresenter
]
