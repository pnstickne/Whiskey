
function New-WhiskeyVersionObject
{
    [CmdletBinding()]
    param(
        [SemVersion.SemanticVersion]
        $SemVer
    )

    $whiskeyVersion = [pscustomobject]@{
                                            SemVer2 = $null;
                                            SemVer2NoBuildMetadata = $null;
                                            Version = $null;
                                            SemVer1 = $null;
                                        }
    if( $SemVer )
    {
        $major = $SemVer.Major
        $minor = $SemVer.Minor
        $patch = $SemVer.Patch
        $prerelease = $SemVer.Prerelease
        $build = $SemVer.Build

        $version = New-Object -TypeName 'Version' -ArgumentList $major,$minor,$patch
        $semVersionNoBuild = New-Object -TypeName 'SemVersion.SemanticVersion' -ArgumentList $major,$minor,$patch
        $semVersionV1 = New-Object -TypeName 'SemVersion.SemanticVersion' -ArgumentList $major,$minor,$patch
        if( $prerelease )
        {
            $semVersionNoBuild = New-Object -TypeName 'SemVersion.SemanticVersion' -ArgumentList $major,$minor,$patch,$prerelease
            $semVersionV1Prerelease = $prerelease -replace '[^A-Za-z0-90]',''
            $semVersionV1 = New-Object -TypeName 'SemVersion.SemanticVersion' -ArgumentList $major,$minor,$patch,$semVersionV1Prerelease
        }

        $whiskeyVersion.Version = $version
        $whiskeyVersion.SemVer2 = $SemVer
        $whiskeyVersion.SemVer2NoBuildMetadata = $semVersionNoBuild
        $whiskeyVersion.SemVer1 = $semVersionV1
    }

    return $whiskeyVersion
}
