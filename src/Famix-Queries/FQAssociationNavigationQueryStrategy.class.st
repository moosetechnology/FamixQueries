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
		associations: {aFamixClass} asOrderedCollection;
		yourself
]

{ #category : #'instance creation' }
FQAssociationNavigationQueryStrategy class >> withAll: aCollection [
	^ self new
		associations: aCollection asOrderedCollection;
		yourself
]

{ #category : #'adding - removing' }
FQAssociationNavigationQueryStrategy >> addAssociation: anAssociation [
	(self associations includes: anAssociation)
		ifTrue: [ ^ self ].
	self
		flag:
			'Removing this first conditional (if associations is a Set) changes checkboxes in the corresponding presenter. Should be revised when tests are ok.'.
	self associations add: anAssociation.
	(self associations includesAll: self class allPossibleAssociations)
		ifTrue: [ ^ FQAllAssociationsNavigationQueryStrategy ]
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

{ #category : #initialization }
FQAssociationNavigationQueryStrategy >> initialize [
	super initialize.
	associations := OrderedCollection new.
	self flag: 'This is not a Set only because of displayOn tests.'
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

{ #category : #removing }
FQAssociationNavigationQueryStrategy >> removeAssociation: anAssociation [
	self associations size == 1
		ifTrue: [ FQNavigationQueryMustHaveAtLeastOneAssociation
				signal:
					'Removing the last association of a ' , self className
						, ' is forbidden' ].
	self associations remove: anAssociation
]
