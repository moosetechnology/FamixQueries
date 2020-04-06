Class {
	#name : #FQWidgetConfigurator,
	#superclass : #Object,
	#instVars : [
		'model',
		'parameterToChange'
	],
	#category : #'Famix-Queries-Browser-Tools-Unused'
}

{ #category : #accessing }
FQWidgetConfigurator class >> model: aModel [
	^ self new
		model: aModel;
		yourself
]

{ #category : #accessing }
FQWidgetConfigurator class >> model: aModel parameterToChange: aParameter [
	^ self new
		model: aModel;
		parameterToChange: aParameter;
		yourself
]

{ #category : #configuration }
FQWidgetConfigurator >> configurePresenter: aPresenter [
	^ self subclassResponsibility
]

{ #category : #configuration }
FQWidgetConfigurator >> layoutConstraints [
	^ [ :c | c height: 29 ]
]

{ #category : #accessing }
FQWidgetConfigurator >> model [
	^ model
]

{ #category : #accessing }
FQWidgetConfigurator >> model: anObject [
	model := anObject
]

{ #category : #accessing }
FQWidgetConfigurator >> parameterToChange [
	^ parameterToChange
]

{ #category : #accessing }
FQWidgetConfigurator >> parameterToChange: anObject [
	parameterToChange := anObject
]

{ #category : #accessing }
FQWidgetConfigurator >> presenterClass [
	^ self subclassResponsibility
]
