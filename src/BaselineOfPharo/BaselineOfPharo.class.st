Class {
	#name : #BaselineOfPharo,
	#superclass : #BaselineOf,
	#category : #BaselineOfPharo
}

{ #category : #'repository urls' }
BaselineOfPharo class >> icebergRepository [

	^ 'github://pharo-vcs/iceberg:{1}' format: { self icebergVersion }
]

{ #category : #versions }
BaselineOfPharo class >> icebergVersion [

	^ 'dev-2.0'
]

{ #category : #versions }
BaselineOfPharo class >> newToolsReleaseCommit [
	"The commit corresponding to current release (to be used on bootstrap process)"

	"v0.6.6"
	^ '29cd87ed8567fb1bf71270f9420e2d5eecb5f9a8'
]

{ #category : #'repository urls' }
BaselineOfPharo class >> newToolsRepository [

	^ 'github://pharo-spec/NewTools:{1}/src' format: { self newToolsVersion }
]

{ #category : #versions }
BaselineOfPharo class >> newToolsVersion [

	^ 'Pharo9.0'
]

{ #category : #versions }
BaselineOfPharo class >> specReleaseCommit [
	"The commit corresponding to current release (to be used on bootstrap process)"

	"v0.8.13"
	^ '54c1a02e928aeaaaaa9314a4bc3f987cea5ed49a'
]

{ #category : #'repository urls' }
BaselineOfPharo class >> specRepository [

	^ 'github://pharo-spec/Spec:{1}/src' format: { self specVersion }
]

{ #category : #versions }
BaselineOfPharo class >> specVersion [

	^ 'Pharo9.0'
]

{ #category : #baseline }
BaselineOfPharo >> baseline: spec [
	<baseline>
	| repository |
	repository := self packageRepositoryURL.

	spec for: #common do: [
		spec postLoadDoIt: #'postload:package:'.
		spec baseline: 'BaseLibraries' with: [spec repository: repository].
		
		spec baseline: 'IDE' with: [spec repository: repository].
		spec baseline: 'Calypso' with: [ 
			spec repository: repository; loads: #('IcebergSupport'). ].

		spec package: 'Deprecated90'.
		
		spec package: 'FluidClassBuilder'.
		spec package: 'FluidClassBuilder-Tests' with: [ spec requires: 'FluidClassBuilder' ].
	]
]

{ #category : #baseline }
BaselineOfPharo >> postload: loader package: packageSpec [

	WelcomeHelp openForRelease
]
