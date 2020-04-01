Class {
	#name : #FQTextInputConfigurator,
	#superclass : #FQWidgetConfigurator,
	#instVars : [
		'defaultText'
	],
	#category : #'FQueryBrowser-Tools'
}

{ #category : #accessing }
FQTextInputConfigurator class >> defaultText: aString [
	^ self new
		defaultText: aString;
		yourself
]

{ #category : #accessing }
FQTextInputConfigurator class >> model: aModel defaultText: aString [
	^ (self model: aModel)
		defaultText: aString;
		yourself
]

{ #category : #accessing }
FQTextInputConfigurator class >> model: aModel parameterToChange: aParameter defaultText: aString [
	^ (self model: aModel parameterToChange: aParameter)
		defaultText: aString;
		yourself
]

{ #category : #configuration }
FQTextInputConfigurator >> configurePresenter: anInputText [
	^ anInputText
		placeholder: self defaultText;
		autoAccept: true;
		whenTextChangedDo: [ :item | model queryAt: self parameterToChange put: item ];
		yourself
]

{ #category : #accessing }
FQTextInputConfigurator >> defaultText [
	^ defaultText
]

{ #category : #accessing }
FQTextInputConfigurator >> defaultText: anObject [
	defaultText := anObject
]

{ #category : #accessing }
FQTextInputConfigurator >> presenterClass [
	^ SpTextInputFieldPresenter
]
