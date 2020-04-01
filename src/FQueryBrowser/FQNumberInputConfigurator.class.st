Class {
	#name : #FQNumberInputConfigurator,
	#superclass : #FQWidgetConfigurator,
	#instVars : [
		'defaultText'
	],
	#category : #'FQueryBrowser-Tools'
}

{ #category : #accessing }
FQNumberInputConfigurator class >> defaultText: aString [
	^ self new
		defaultText: aString;
		yourself
]

{ #category : #accessing }
FQNumberInputConfigurator class >> model: aModel defaultText: aString [
	^ (self model: aModel)
		defaultText: aString;
		yourself
]

{ #category : #accessing }
FQNumberInputConfigurator class >> model: aModel parameterToChange: aParameter defaultText: aString [
	^ (self model: aModel parameterToChange: aParameter)
		defaultText: aString;
		yourself
]

{ #category : #'error handling' }
FQNumberInputConfigurator >> configurePresenter: aNumberInputField [
	^ aNumberInputField
		placeholder: self defaultText;
		climbRate: 1;
		minimum: 0;
		autoAccept: true;
		whenTextChangedDo: [ :item | 
			[ model queryAt: self parameterToChange put: item asNumber ]
				on: Error
				do: [ self signalError: item
					"aNumberInputField number: (model queryAt: self parameterToChange) "	"Does not work. Probably overriden after" ] ];
		yourself
]

{ #category : #accessing }
FQNumberInputConfigurator >> defaultText [
	^ defaultText
]

{ #category : #accessing }
FQNumberInputConfigurator >> defaultText: anObject [
	defaultText := anObject
]

{ #category : #accessing }
FQNumberInputConfigurator >> presenterClass [
	^ SpNumberInputFieldPresenter
]

{ #category : #'error handling' }
FQNumberInputConfigurator >> signalError [
	UIManager default alert: 'Please enter a number' title: 'Wrong entry'
]

{ #category : #'error handling' }
FQNumberInputConfigurator >> signalError: aString [
	UIManager default
		alert: 'Your entry, ''' , aString , ''' is not a number'
		title: 'Please enter a number'
]
