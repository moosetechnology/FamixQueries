Class {
	#name : #FQRoassalQueryPresenterTest,
	#superclass : #SpTest,
	#instVars : [
		'helper'
	],
	#category : #'Famix-Queries-Browser-Tests-Presenters'
}

{ #category : #running }
FQRoassalQueryPresenterTest >> browserWithSimilarQueries [
	| browser query1 query2 query3 query4 |
	browser := FQQueriesBrowserPresenter on: helper classesAndMethods.
	query1 := (FQTypeQuery new type: FamixStClass)
		beChildOf: browser initialQuery.
	query2 := (FQTypeQuery new type: FamixStMethod)
		beChildOf: browser initialQuery.
	query3 := (FQBooleanQuery new property: #isAbstract)
		beChildOf: query1.
	query4 := (FQBooleanQuery new property: #isAbstract)
		beChildOf: query2.
	{query1.
	query2.
	query3.
	query4} do: [ :query | browser updateForQuery: query ].
	^ browser
]

{ #category : #running }
FQRoassalQueryPresenterTest >> classToTest [
	^ FQRoassalQueryPresenter
]

{ #category : #running }
FQRoassalQueryPresenterTest >> setUp [
	super setUp.
	helper := FQBrowserTestsHelper new
]

{ #category : #tests }
FQRoassalQueryPresenterTest >> testPointingOnlyToActualChildren [
	| browser |
	browser := self browserWithSimilarQueries.
	presenter := (self classToTest on: browser queries)
		adaptToBrowser: browser.
	self openInstance.
	presenter canvas nodes
		do: [ :box | self assert: box incomingEdges size < 2 ]
]
