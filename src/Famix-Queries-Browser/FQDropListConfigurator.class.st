Class {
	#name : #FQDropListConfigurator,
	#superclass : #FQWidgetConfigurator,
	#instVars : [
		'items',
		'changeBlock'
	],
	#category : #'Famix-Queries-Browser-Tools-Deprecated'
}

{ #category : #'api-shortcuts' }
FQDropListConfigurator class >> items: anItemsCollection [
	^ self new
		items: anItemsCollection;
		yourself
]

{ #category : #'api-shortcuts' }
FQDropListConfigurator class >> items: items changeBlock: aBlock [
	^ self new
		items: items;
		changeBlock: aBlock;
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

{ #category : #accessing }
FQDropListConfigurator >> changeBlock [
	^ changeBlock
]

{ #category : #accessing }
FQDropListConfigurator >> changeBlock: anObject [
	changeBlock := anObject
]

{ #category : #configuration }
FQDropListConfigurator >> configurePresenter: aDropList [
	"^ aDropList
		items: self items;
		whenSelectedItemChangedDo: [ :item | model queryAt: self parameterToChange put: item ];
		selectIndex: 1;
		yourself"

	^ aDropList
		items: self items;
		whenSelectedItemChangedDo: self changeBlock;
		selectIndex: 1;
		yourself
]

{ #category : #configuration }
FQDropListConfigurator >> configurePresenter: aDropList forQuery: aQuery withEntities: entities [
	"Pb: items, parameterToChange ?? availableProperties? Selectors ? ... "

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
