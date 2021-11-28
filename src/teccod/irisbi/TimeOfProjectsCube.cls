/// 
Class teccod.irisbi.TimeOfProjectsCube Extends %DeepSee.CubeDefinition [ DependsOn = teccod.irisbi.TimeOfProjects, ProcedureBlock ]
{

/// Cube definition from Architect.
XData Cube [ XMLNamespace = "http://www.intersystems.com/deepsee" ]
{
<cube xmlns="http://www.intersystems.com/deepsee" name="TimeOfProjectsCube" displayName="TimeOfProjectsCube" disabled="false" abstract="false" sourceClass="teccod.irisbi.TimeOfProjects" namedFactNums="true" countMeasureName="%COUNT" bucketSize="8" bitmapChunkInMemory="false" precompute="0" disableListingGroups="false" enableSqlRestrict="false">
  <dimension name="Worker" disabled="false" hasAll="false" allCaption="All iduser" allDisplayName="iduser" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="email" disabled="false" sourceProperty="iduser.email" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="2">
      </level>
      <level name="name" disabled="false" sourceProperty="iduser.name" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="7">
      </level>
      <level name="phone" disabled="false" sourceProperty="iduser.phone" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="8">
      </level>
      <level name="position" disabled="false" sourceProperty="iduser.position" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="9">
      </level>
    </hierarchy>
  </dimension>
  <dimension name="Project" disabled="false" hasAll="false" allCaption="All idproject" allDisplayName="idproject" type="data" calendar="gregorian" iKnowType="entity" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Project" disabled="false" sourceProperty="idproject.%ID" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="3">
        <property name="name" disabled="false" sourceProperty="idproject.name" hidden="false" isName="true" isDescription="false" isReference="false" useDisplayValue="false">
        </property>
      </level>
    </hierarchy>
  </dimension>
  <dimension name="date" disabled="false" hasAll="false" allCaption="All date" allDisplayName="date" sourceProperty="date" type="time" calendar="gregorian" hidden="false" showHierarchies="default">
    <hierarchy name="H1" disabled="false" hidden="false">
      <level name="Year" disabled="false" timeFunction="Year" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="4">
      </level>
      <level name="MonthYear" disabled="false" timeFunction="MonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="5">
      </level>
      <level name="DayMonthYear" disabled="false" timeFunction="DayMonthYear" list="false" useDisplayValue="true" useAsFilter="true" hidden="false" factNumber="6">
      </level>
    </hierarchy>
  </dimension>
  <measure name="hours" disabled="false" sourceProperty="hours" aggregate="SUM" type="number" hidden="false" searchable="false" factNumber="1">
  </measure>
</cube>
}

Parameter DOMAIN;

}

