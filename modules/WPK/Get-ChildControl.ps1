function Get-ChildControl
{
    <#
    .Synopsis
        Gets a Child UIElement anywhere in a visual tree
    .Description
        Gets a Child UIElement anywhere in a visual tree
    .Example
        $window | Get-ChildControl FooBar
    .Parameter name
        The name of the control to look for
    .Parameter tree
        The root of the visual tree to look in    
    #>        
    param(
    [Parameter(ValueFromPipeline=$true)]$tree,
    [Parameter(Position=0)][string]$name = "*"
    )
    process {    
        $tree | Where-Object { $_ -and $_.Name -like $name }
        if ($tree.Children)
        {
           @($tree.Children) | Get-ChildControl | Where-Object { $_ -and $_.Name -like $name }
        } elseif ($tree.Child)
        {
            @($tree.Child) | Get-ChildControl | Where-Object { $_ -and $_.Name -like $name }
        } elseif ($tree.Content)
        {
            @($tree.Content) | Get-ChildControl | Where-Object { $_ -and $_.Name -like $name }
        } elseif ($tree.Items)
        {
            @($tree.Items) | Get-ChildControl | Where-Object { $_ -and $_.Name -like $name }
        } elseif ($tree.Inlines) {
            @($tree.Inlines) | Get-ChildControl | Where-Object { $_ -and $_.Name -like $name }
        }  elseif ($tree.Blocks) {
            @($tree.Blocks) | Get-ChildControl | Where-Object { $_ -and $_.Name -like $name }
        }        
        trap {
            continue
        }    
    }
}