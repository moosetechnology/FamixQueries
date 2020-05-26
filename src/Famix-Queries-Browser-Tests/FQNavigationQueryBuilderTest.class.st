"
This class contains tests
"
Class {
	#name : #FQNavigationQueryBuilderTest,
	#superclass : #FQAbstractQueryBuilderTest,
	#category : #'Famix-Queries-Browser-Tests-Builder'
}

{ #category : #running }
FQNavigationQueryBuilderTest >> queryBuilderClass [
	^ FQNavigationQueryBuilder
]

{ #category : #tests }
FQNavigationQueryBuilderTest >> testAddAssociationToQuery [
	queryBuilder addAssociationToQuery: FamixTInheritance.
	self
		assert: (queryBuilder currentQueryAssociations includes: FamixTInheritance)
]

{ #category : #tests }
FQNavigationQueryBuilderTest >> testChangeQueryNavigationDirection [
	queryBuilder
		changeQueryNavigationDirection: FQIncomingNavigation.
	self
		assert: queryBuilder query directionStrategy
		identicalTo: FQIncomingNavigation
]

{ #category : #tests }
FQNavigationQueryBuilderTest >> testRemoveAssociationFromQuery [
	queryBuilder removeAssociationFromQuery: FamixTInvocation.
	self
		deny: (queryBuilder currentQueryAssociations includes: FamixTInvocation)
]

{ #category : #tests }
FQNavigationQueryBuilderTest >> testUpdateQueryResult [
	| previousResult |
	
	previousResult := queryBuilder query result copy.
	queryBuilder changeQueryNavigationDirection: FQOutgoingNavigation.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult.
	
	previousResult := queryBuilder query result copy.
	queryBuilder removeAssociationFromQuery: FamixTInvocation.
	self
		denyCollection: queryBuilder query result
		hasSameElements: previousResult
]

{ #category : #tests }
FQNavigationQueryBuilderTest >> testinitializeQuery [
	super testInitializeQuery.
	self
		assert:
			(queryBuilder query directionStrategy
				inheritsFrom: FQAbstractNavigationDirection).
	self
		assert:
			(queryBuilder query associationStrategy
				isKindOf: FQAbstractNavigationAssociations).
	self
		assert:
			(queryBuilder availableAssociations
				includesAll: queryBuilder currentQueryAssociations)
]
