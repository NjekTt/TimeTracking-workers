Class teccod.irisbi.Workers Extends %Library.Persistent [ Not Abstract, DdlAllowed, Not LegacyInstanceContext, ProcedureBlock ]
{

Property name As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 2 ];

Property phone As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 3 ];

Property email As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 4 ];

Property position As %Library.String(MAXLEN = 250) [ SqlColumnNumber = 5 ];

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
					Set tMe.phone = tImporter.%GetData(2)
					Set tMe.email = tImporter.%GetData(3)
					Set tMe.position = tImporter.%GetData(4)
				}
				ElseIf pSelectMode = 1 {
					Set tMe.name = $Select('$System.CLS.IsMthd("nameOdbcToLogical"):tImporter.%GetData(1),1:tMe.nameOdbcToLogical(tImporter.%GetData(1)))
					Set tMe.phone = $Select('$System.CLS.IsMthd("phoneOdbcToLogical"):tImporter.%GetData(2),1:tMe.phoneOdbcToLogical(tImporter.%GetData(2)))
					Set tMe.email = $Select('$System.CLS.IsMthd("emailOdbcToLogical"):tImporter.%GetData(3),1:tMe.emailOdbcToLogical(tImporter.%GetData(3)))
					Set tMe.position = $Select('$System.CLS.IsMthd("positionOdbcToLogical"):tImporter.%GetData(4),1:tMe.positionOdbcToLogical(tImporter.%GetData(4)))
				}
				ElseIf pSelectMode = 2 {
					Set tMe.name = $Select('$System.CLS.IsMthd("nameDisplayToLogical"):tImporter.%GetData(1),1:tMe.nameDisplayToLogical(tImporter.%GetData(1)))
					Set tMe.phone = $Select('$System.CLS.IsMthd("phoneDisplayToLogical"):tImporter.%GetData(2),1:tMe.phoneDisplayToLogical(tImporter.%GetData(2)))
					Set tMe.email = $Select('$System.CLS.IsMthd("emailDisplayToLogical"):tImporter.%GetData(3),1:tMe.emailDisplayToLogical(tImporter.%GetData(3)))
					Set tMe.position = $Select('$System.CLS.IsMthd("positionDisplayToLogical"):tImporter.%GetData(4),1:tMe.positionDisplayToLogical(tImporter.%GetData(4)))
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

Parameter ROWTYPE = "name VARCHAR(250),phone INTEGER,email VARCHAR(250),position VARCHAR(250)";

Storage Default
{
<Data name="WorkersDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>phone</Value>
</Value>
<Value name="4">
<Value>email</Value>
</Value>
<Value name="5">
<Value>position</Value>
</Value>
</Data>
<DataLocation>^teccod.irisbi.WorkersD</DataLocation>
<DefaultData>WorkersDefaultData</DefaultData>
<IdLocation>^teccod.irisbi.WorkersD</IdLocation>
<IndexLocation>^teccod.irisbi.WorkersI</IndexLocation>
<StreamLocation>^teccod.irisbi.WorkersS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
