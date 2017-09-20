#
# Module manifest for module 'Whiskey'
#
# Generated by: ajensen
#
# Generated on: 12/8/2016
# 

@{

    # Script module or binary module file associated with this manifest.
    RootModule = 'Whiskey.psm1'

    # Version number of this module.
    ModuleVersion = '0.17.0'

    # ID used to uniquely identify this module
    GUID = '93bd40f1-dee5-45f7-ba98-cb38b7f5b897'

    # Author of this module
    Author = 'WebMD Health Services'

    # Company or vendor of this module
    CompanyName = 'WebMD Health Services'

    # Copyright statement for this module
    Copyright = '(c) 2016 WebMD Health Services. All rights reserved.'

    # Description of the functionality provided by this module
    Description = 'Continuous Integration/Continuous Delivery module.'

    # Minimum version of the Windows PowerShell engine required by this module
    # PowerShellVersion = ''

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    RequiredAssemblies = @( 'bin\SemanticVersion.dll', 'bin\YamlDotNet.dll' )

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    #ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    NestedModules = @( 
                        'BitbucketServerAutomation',
                        'BuildMasterAutomation',
                        'ProGetAutomation',
                        'VSSetup'
                     )

    # Functions to export from this module
    FunctionsToExport = @( 
                            'Add-WhiskeyApiKey',
                            'Add-WhiskeyCredential',
                            'Add-WhiskeyVariable',
                            'ConvertFrom-WhiskeyYamlScalar',
                            'ConvertTo-WhiskeySemanticVersion',
                            'Get-WhiskeyApiKey',
                            'Get-WhiskeyTask',
                            'Get-WhiskeyCredential',
                            'Install-WhiskeyNodeJs',
                            'Install-WhiskeyTool',
                            'Invoke-WhiskeyNodeTask',
                            'Invoke-WhiskeyNUnit2Task',
                            'Invoke-WhiskeyPester3Task',
                            'Invoke-WhiskeyPester4Task',
                            'Invoke-WhiskeyPipeline',
                            'Invoke-WhiskeyBuild',
                            'Invoke-WhiskeyTask',
                            'New-WhiskeyContext',
                            'Publish-WhiskeyBuildMasterPackage',
                            'Publish-WhiskeyNuGetPackage',
                            'Publish-WhiskeyProGetUniversalPackage',
                            'Publish-WhiskeyBBServerTag',
                            'Register-WhiskeyEvent',
                            'Resolve-WhiskeyNuGetPackageVersion',
                            'Resolve-WhiskeyPowerShellModuleVersion',
                            'Resolve-WhiskeyTaskPath',
                            'Resolve-WhiskeyVariable',
                            'Set-WhiskeyBuildStatus',
                            'Stop-WhiskeyTask',
                            'Uninstall-WhiskeyTool',
                            'Unregister-WhiskeyEvent'
                         );

    # Cmdlets to export from this module
    CmdletsToExport = @( )

    # Variables to export from this module
    #VariablesToExport = '*'

    # Aliases to export from this module
    AliasesToExport = '*'

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = @( 'build', 'pipeline', 'devops', 'ci', 'cd', 'continuous-integration', 'continuous-delivery', 'continuous-deploy' )

            # A URL to the license for this module.
            LicenseUri = 'https://www.apache.org/licenses/LICENSE-2.0'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/webmd-health-services/Whiskey'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            ReleaseNotes = @'
* You can now specify a custom version of NUnit 2 that the `NUnit2` task should use by setting the `Version` property to the version you want to use.
* You can now specify a custom version of NUnit 3 that the `NUnit3` task should use by setting the `Version` property to the version you want to use.
* The `NUnit3` task upgraded to use NUnit 3.8.1 (from 3.7.0).

Added support for `PackageName` and `DeployTo` properties to `Publish-WhiskeyBuildMasterPackage` task function, e.g.

    PublishTasks:
    - PublishBuildMasterPackage:
        ApplicationName: TestApplication
        Uri: https://buildmaster.example.com
        ApiKeyID: buildmaster.example.com
		PackageName: TestPackage
        DeployTo:
        - BranchName:
          - develop
		  - feature*
	      ReleaseName: TestRelease
          StartAtStage: Test
        - BranchName: prod
          ReleaseName: ProdRelease
          SkipDeploy: true

`PackageName` (optional): defines the name of the package that will be created in BuildMaster. In this example, the `PackageName` will be `TestPackage` instead of the default convention of `MajorVersion.MinorVersion.PatchVersion`  

`DeployTo` (mandatory) defines a map of SCM branch to corresponding BuildMaster releases where packages should be created and deployed. `DeployTo` contains the following properties:
- `BranchName` (mandatory) defines the SCM branch to be mapped to the release. Wildcards are allowed.
- `ReleaseName` (mandatory) defines the release in BuildMaster where packages should be created and deployed.
- `StartAtStage` (optional) defines the stage of the release pipeline where the package should start its deployment. By default, the package will be released to the first stage of the pipeline.
- `SkipDeploy` (optional) defines that the release package should be created, but not automatically deployed. By default, the package deployment will be started.

When building on `develop`, `feature/NewFunction`, or `feature68` branches, a package will be created on the `TestRelease` release of the `TestApplication` application. The package will be deployed to the `Test` stage of the `TestRelease` release's pipeline.

When building on `prod` branch, a package will be created on the `ProdRelease` release of the `TestApplication` application. The package will be created, but will not be deployed.

When building on `unmapped` branch, the task will fail with an error stating that the current branch must be mapped to a `ReleaseName`. No package will be created or deployed.
'@
        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
}
