Class teccod.irisbi.Projects Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property name As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 2 ];

ClassMethod Import(pSelectMode As %Library.Integer = {$ZUtil(115,5)}, pFileName As %Library.String(MAXLEN=""), pDelimiter As %String = ",", pQuote As %String = """", pHeaders As %Integer = 0, ByRef pRecordCount As %Integer) As %Library.Integer [ SqlProc ]
{
	Set tStatementId = $System.Util.CreateGUID(), tCounter = 0, pRecordCount = 0
	Set tPreparedStatement = ##class(%SQL.DynamicStatement).Prepare(tStatementId,..#ROWTYPE,pDelimiter,pQuote,,,0,"CSV")
	If $IsObject(tPreparedStatement) {
		Set tImporter = tPreparedStatement.%New(tPreparedStatement,,pFileName,pDelimiter,pQuote)
		If $IsObject(tImporter) {
			Do ..%DeleteExtent(,.tDeleted,.tInstances,1)
				// burn the column headers
			For tPtr = 1:1:pHeaders { Do tImporter.%Next() }
			While tImporter.%Next() {
				Set tMe = ..%New()
				If 'pSelectMode {
					Set tMe.name = tImporter.%GetData(1)
				}
				ElseIf pSelectMode = 1 {
					Set tMe.name = $Select('$System.CLS.IsMthd("nameOdbcToLogical"):tImporter.%GetData(1),1:tMe.nameOdbcToLogical(tImporter.%GetData(1)))
				}
				ElseIf pSelectMode = 2 {
					Set tMe.name = $Select('$System.CLS.IsMthd("nameDisplayToLogical"):tImporter.%GetData(1),1:tMe.nameDisplayToLogical(tImporter.%GetData(1)))
				}
				Set tStatus = tMe.%Save()
				If $$$ISOK(tStatus) { Set tCounter = tCounter + 1 }
			}
		}
	}
	Set %sqlcontext.%SQLCODE = 0
	Set %sqlcontext.%ROWCOUNT = tCounter
	Set pRecordCount = tCounter
	Quit tCounter
}

Parameter ROWTYPE = "name VARCHAR(250)";

Storage Default
{
<Data name="ProjectsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
</Data>
<DataLocation>^teccod.irisbi.ProjectsD</DataLocation>
<DefaultData>ProjectsDefaultData</DefaultData>
<IdLocation>^teccod.irisbi.ProjectsD</IdLocation>
<IndexLocation>^teccod.irisbi.ProjectsI</IndexLocation>
<StreamLocation>^teccod.irisbi.ProjectsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
