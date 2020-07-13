local metadata =
{
	plugin =
	{
		format = 'sharedLibrary',
		sharedLibs = { 'micorazon.dylib', },
		frameworks = {},
		frameworksOptional = {},
		-- usesSwift = true,
                delegates = { "AppCoronaDelegate" }
	},
}

return metadata
