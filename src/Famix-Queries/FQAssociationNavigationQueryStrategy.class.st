Class {
	#name : #FQAssociationNavigationQueryStrategy,
	#superclass : #FQAbstractAssociationNavigationQueryStrategy,
	#instVars : [
		'associations'
	],
	#category : #'Famix-Queries-Utils'
}

{ #category : #'instance creation' }
FQAssociationNavigationQueryStrategy class >> with: aFamixClass [
	^ self new
		associations: {aFamixClass};
		yourself
]

{ #category : #'instance creation' }
FQAssociationNavigationQueryStrategy class >> withAll: aCollection [
	^ self new
		associations: aCollection;
		yourself
]

{ #category : #accessing }
FQAssociationNavigationQueryStrategy >> associations [
	^ associations
]

{ #category : #accessing }
FQAssociationNavigationQueryStrategy >> associations: anObject [
	associations := anObject
]

{ #category : #printing }
FQAssociationNavigationQueryStrategy >> displayIncomingOn: aStream [
	"The condition is not really needed since the generated script of one branch will be valid all the time, but it is present to print a nicer script to the user."

	self associations size = 1
		ifTrue: [ aStream
				<< '(entity queryIncoming: ';
				print: self associations anyOne;
				<< ') opposites' ]
		ifFalse: [ aStream << '({ '.
			self associations do: [ :asso | aStream print: asso ] separatedBy: [ aStream << ' . ' ].
			aStream << ' } flatCollect: [ :association | (entity queryIncoming: association) opposites ])' ]
]

{ #category : #printing }
FQAssociationNavigationQueryStrategy >> displayLocalIncomingOn: aStream [
	"The condition is not really needed since the generated script of one branch will be valid all the time, but it is present to print a nicer script to the user."

	self associations size = 1
		ifTrue: [ aStream
				<< '(entity queryLocalIncoming: ';
				print: self associations anyOne;
				<< ') opposites' ]
		ifFalse: [ aStream << '({ '.
			self associations
				do: [ :asso | aStream print: asso ]
				separatedBy: [ aStream << ' . ' ].
			aStream
				<<
					' } flatCollect: [ :association | (entity queryLocalIncoming: association) opposites ])' ]
]

{ #category : #printing }
FQAssociationNavigationQueryStrategy >> displayLocalOutgoingOn: aStream [
	"The condition is not really needed since the generated script of one branch will be valid all the time, but it is present to print a nicer script to the user."

	self associations size = 1
		ifTrue: [ aStream
				<< 'entity queryLocalOutgoing: ';
				print: self associations anyOne;
				<< ') opposites' ]
		ifFalse: [ aStream << '({ '.
			self associations
				do: [ :asso | aStream print: asso ]
				separatedBy: [ aStream << ' . ' ].
			aStream
				<<
					' } flatCollect: [ :association | (entity queryLocalOutgoing: association) opposites ])' ]
]

{ #category : #printing }
FQAssociationNavigationQueryStrategy >> displayOutgoingOn: aStream [
	"The condition is not really needed since the generated script of one branch will be valid all the time, but it is present to print a nicer script to the user."

	self associations size = 1
		ifTrue: [ aStream
				<< 'entity queryOutgoing: ';
				print: self associations anyOne;
				<< ') opposites' ]
		ifFalse: [ aStream << '({ '.
			self associations do: [ :asso | aStream print: asso ] separatedBy: [ aStream << ' . ' ].
			aStream << ' } flatCollect: [ :association | (entity queryOutgoing: association) opposites ])' ]
]

{ #category : #action }
FQAssociationNavigationQueryStrategy >> queryIncomingWith: anEntity [
	^ self associations flatCollect: [ :each | (anEntity queryIncoming: each) opposites ]
]

{ #category : #action }
FQAssociationNavigationQueryStrategy >> queryLocalIncomingWith: anEntity [
	^ self associations flatCollect: [ :each | (anEntity queryLocalIncoming: each) opposites ]
]

{ #category : #action }
FQAssociationNavigationQueryStrategy >> queryLocalOutgoingWith: anEntity [
	^ self associations
		flatCollect: [ :each | (anEntity queryLocalOutgoing: each) opposites ]
]

{ #category : #action }
FQAssociationNavigationQueryStrategy >> queryOutgoingWith: anEntity [
	^ self associations flatCollect: [ :each | (anEntity queryOutgoing: each) opposites ]
]
