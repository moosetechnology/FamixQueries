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
	spec for: #common do: [ "Packages"
		spec
			package: 'Famix-Queries';
			package: 'Famix-Queries-Tests'
			with: [ spec requires: #( 'Famix-Queries' ) ].

		"If Famix is not already present"
		spec for: #NeedsFamix do: [ 
			self famix: spec.
			spec package: 'Famix-Queries' with: [ spec requires: #( 'Famix' ) ] ].

		"Groups"
		spec
			group: 'Model' with: #( 'Famix-Queries' );
			group: 'Tests' with: #( 'Famix-Queries-Tests' ) ]
]

{ #category : #accessing }
BaselineOfFamixQueries >> customProjectAttributes [

	^ RPackageOrganizer default packages
		  detect: [ :package | package name = 'Moose-Core' ]
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
