Class teccod.irisbi.TimeOfProjects Extends %Library.Persistent [ DependsOn = (teccod.irisbi.Projects, teccod.irisbi.Workers) ]
{

Property date As %Library.Date [ SqlColumnNumber = 2 ];

Property iduser As teccod.irisbi.Workers [ SqlColumnNumber = 3, SqlFieldName = id_user ];

Property idproject As teccod.irisbi.Projects [ SqlColumnNumber = 4, SqlFieldName = id_project ];

Property hours As %Library.Integer(MAXVAL = 2147483647, MINVAL = -2147483648) [ SqlColumnNumber = 5 ];

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
					Set tMe.date = tImporter.%GetData(1)
					Set tMe.iduser = tImporter.%GetData(2)
					Set tMe.idproject = tImporter.%GetData(3)
					Set tMe.hours = tImporter.%GetData(4)
				}
				ElseIf pSelectMode = 1 {
					Set tMe.date = $Select('$System.CLS.IsMthd("dateOdbcToLogical"):tImporter.%GetData(1),1:tMe.dateOdbcToLogical(tImporter.%GetData(1)))
					Set tMe.iduser = $Select('$System.CLS.IsMthd("iduserOdbcToLogical"):tImporter.%GetData(2),1:tMe.iduserOdbcToLogical(tImporter.%GetData(2)))
					Set tMe.idproject = $Select('$System.CLS.IsMthd("idprojectOdbcToLogical"):tImporter.%GetData(3),1:tMe.idprojectOdbcToLogical(tImporter.%GetData(3)))
					Set tMe.hours = $Select('$System.CLS.IsMthd("hoursOdbcToLogical"):tImporter.%GetData(4),1:tMe.hoursOdbcToLogical(tImporter.%GetData(4)))
				}
				ElseIf pSelectMode = 2 {
					Set tMe.date = $Select('$System.CLS.IsMthd("dateDisplayToLogical"):tImporter.%GetData(1),1:tMe.dateDisplayToLogical(tImporter.%GetData(1)))
					Set tMe.iduser = $Select('$System.CLS.IsMthd("iduserDisplayToLogical"):tImporter.%GetData(2),1:tMe.iduserDisplayToLogical(tImporter.%GetData(2)))
					Set tMe.idproject = $Select('$System.CLS.IsMthd("idprojectDisplayToLogical"):tImporter.%GetData(3),1:tMe.idprojectDisplayToLogical(tImporter.%GetData(3)))
					Set tMe.hours = $Select('$System.CLS.IsMthd("hoursDisplayToLogical"):tImporter.%GetData(4),1:tMe.hoursDisplayToLogical(tImporter.%GetData(4)))
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

Parameter ROWTYPE = "date DATE,id_user INTEGER,id_project INTEGER,hours INTEGER";

Storage Default
{
<Data name="TimeOfProjectsDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>date</Value>
</Value>
<Value name="3">
<Value>iduser</Value>
</Value>
<Value name="4">
<Value>idproject</Value>
</Value>
<Value name="5">
<Value>hours</Value>
</Value>
</Data>
<DataLocation>^teccod.irisbi.TimeOfProjectsD</DataLocation>
<DefaultData>TimeOfProjectsDefaultData</DefaultData>
<IdLocation>^teccod.irisbi.TimeOfProjectsD</IdLocation>
<IndexLocation>^teccod.irisbi.TimeOfProjectsI</IndexLocation>
<StreamLocation>^teccod.irisbi.TimeOfProjectsS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
