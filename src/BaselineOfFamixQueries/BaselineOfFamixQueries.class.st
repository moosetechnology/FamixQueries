"
BaselineOfMooseSpec
"
Class {
	#name : #BaselineOfFamixQueries,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixQueries
}

{ #category : #baseline }
BaselineOfFamixQueries >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		"Dependencies"
		self famix: spec.

		"Packages"
		spec
			package: 'Famix-Queries' with: [ spec requires: #( 'Famix' ) ];
			package: 'Famix-Queries-Tests'
			with: [ spec requires: #( 'Famix-Queries' ) ].

		"Groups"
		spec
			group: 'Model' with: #( 'Famix-Queries' );
			group: 'Tests' with: #( 'Famix-Queries-Tests' ) ]
]

{ #category : #accessing }
BaselineOfFamixQueries >> customProjectAttributes [

	^ RPackageOrganizer default packages
		  detect: [ :package | package name = 'BaselineOfFamix' ]
		  ifFound: [ #(  ) ]
		  ifNone: [ #( #NeedsFamix ) ]
]

{ #category : #dependencies }
BaselineOfFamixQueries >> famix: spec [

	spec
		baseline: 'Famix'
		with: [ 
		spec repository: 'github://moosetechnology/Famix:development/src' ]
]
