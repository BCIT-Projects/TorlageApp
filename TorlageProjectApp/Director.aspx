<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Director.aspx.cs" Inherits="TorlageProjectApp.Director" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">

body {
    margin: auto;
    width: 100%;
    background-color: #6f8ef5;
    margin: 0;
    font-family: Arial;

}  

#DirectorPages{
    width: 540px;
    height: 650px;
    margin: auto;
    border:3px solid black;
    padding-top: 20px;
    padding-bottom: 20px;
    padding-left: 50px;
    padding-right: 50px;
}
#navbar-director{
    width:550px;
    height: 50px;
    margin: auto;
}
#navbar-director ul {
    display: block;
    list-style-type: disc;
    -webkit-margin-before: 1em;
    -webkit-margin-after: 1em;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
     -webkit-padding-start: 0px;
}

#navbar-director ul li { display: inline; 

}

#navbar-director ul li a
{
text-decoration: none;
padding: .2em 1em;
color: #fff;
background-color: #036;
}

#navbar-director ul li a:hover
{
color: #fff;
background-color: #369;
}


.PeopleLable{
    
    width: 160px;
}
.PerformerList{
    height: 230px;
    width: 150px;
}
td{
    text-align:center;
    vertical-align: top;
    padding:2px;
    
}

#GridViewAvailable{
    background-color: #EEEEEE;
}
#GridViewNotAvailable{
    background-color: #EEEEEE;
}
.NextButton{
    text-align:right;
     vertical-align: bottom;
}


</style>  
</head>
<body>
    <form id="form1" runat="server">
    <div id="DirectorPages">
        <div id="navbar-director">
            <ul>
                <li><a runat="server" href="~/Director">Set Show Date</a></li>
                <li><a runat="server" href="~/SelectPerformers">Select Performers</a></li>
          <!--      <li><a runat="server" href="~/CreateShowList">Create Show List</a></li>
                <li><a runat="server" href="~/ReviewShowList">Review Show List</a></li>
            -->
            </ul>
        </div>
        <div>
            <table>
                <tr>
                    <td colspan ="2">
                        <asp:Label ID="LabelSetShowDate" runat="server" Text="Set Show Date"></asp:Label>

                    </td>
                    
                </tr>
                <tr>
                    <td colspan ="2">
                        <asp:SqlDataSource ID="SqlDataSourceSetShowDate" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT * FROM [PerformersAvailable] where ( ScheduleDate = @PerformeanceDate) AND (Available = 1)">
                        <SelectParameters>
                            <asp:ControlParameter Name="PerformeanceDate" Type="String" 
                            ControlID="TextBoxSetShowDate" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:TextBox ID="TextBoxSetShowDate" runat="server" OnTextChanged="TextBoxSetShowDate_TextChanged" ></asp:TextBox>
                        
                    </td>

                    
                </tr>
                <tr>
                    <!--Calendar-->
                    <td colspan ="2" rowspan="2">
                        <asp:Calendar ID="CalendarShowDate" BackColor="White" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" OnDayRender="CalendarShowDate_DayRender" Height="237px" Width="320px"></asp:Calendar>
                    </td>
                    <!-- start of setting show date-->
                    <td>
                        <asp:Button ID="ButtonSetShow" runat="server" Text="Add Show" OnClick="ButtonSetShow_Click" Visible="False" Width="120px" />
                        <asp:Button ID="ButtonRemoveSetShow" runat="server" Text="Remove Show" OnClick="ButtonRemoveSetShow_Click" Visible="False" Width="120px" />
                    </td>


                </tr>
                <tr>
                    <td>
                        <asp:Label ID="LabelShowOrNoShow" runat="server" Text=""></asp:Label>
                        <asp:Label ID="LabelError" runat="server" Text=""></asp:Label>
                    </td>

                </tr>
<!--                <tr>
                    <td class ="PeopleLable">
                        <asp:Label ID="LabelPerformersList" runat="server" Text="Available"></asp:Label>
                    </td>
                    <td class ="PeopleLable">
                       <asp:Label ID="LabelNoPerformerList" runat="server" Text="NOT Available"></asp:Label>
                    </td>
                    <td>

                    </td>
                </tr>
-->
                <tr>
                    <!---display of performers available-->
                    <td>
                       
                       <div class ="PerformerList">
                       <asp:PlaceHolder ID="PlaceHolderAvaliablePerformers" runat="server">
                           <asp:SqlDataSource ID="SqlDataSourceAvailablePerformers" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT PerformerName
                                            FROM [PerformersAvailable] LEFT JOIN [Performers]
                                            on PerformersAvailable.PerformerID = Performers.PerformerID
                                            where ( ScheduleDate = @PerformeanceDate) AND (Available = 1)">
                                <SelectParameters>
                                    <asp:ControlParameter Name="PerformeanceDate" Type="String" 
                                        ControlID="TextboxSetShowDate" PropertyName="Text" />
                                </SelectParameters>
                           </asp:SqlDataSource>
                        </asp:PlaceHolder>
                        <asp:GridView ID="GridViewAvailable" runat="server"  autogeneratecolumns="false" DataKeyNames="PerformerName" DataSourceID="SqlDataSourceAvailablePerformers" >                    
                            <Columns>
                                <asp:boundfield datafield="PerformerName" readonly="true" headertext="Available Performer"/>
        
                            </Columns>
                        </asp:GridView>
                        </div>
                    </td>
                    <!---end of display of performers Available-->
                    <!---display of performers Not available-->
                    <td>
                       
                       <div class ="PerformerList">
                       <asp:PlaceHolder ID="PlaceHolderNotAvailable" runat="server">
                           <asp:SqlDataSource ID="SqlDataSourceNotAvailable" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT PerformerName
                                            FROM [PerformersAvailable] LEFT JOIN [Performers]
                                            on PerformersAvailable.PerformerID = Performers.PerformerID
                                            where ( ScheduleDate = @PerformeanceDate) AND (Available = 0)">
                                <SelectParameters>
                                    <asp:ControlParameter Name="PerformeanceDate" Type="String" 
                                        ControlID="TextboxSetShowDate" PropertyName="Text" />
                                </SelectParameters>
                           </asp:SqlDataSource>
                        </asp:PlaceHolder>
                        <asp:GridView ID="GridViewNotAvailable" runat="server" autogeneratecolumns="false" DataKeyNames="PerformerName" DataSourceID="SqlDataSourceNotAvailable" >                    
                            <Columns>
                                <asp:boundfield datafield="PerformerName" readonly="true" headertext="Not Available Performer"/>        
                            </Columns>
                        </asp:GridView>
                        </div>
                    </td>
                    <!---end of display of performers NOT-->
                    <td class ="NextButton">
                        <asp:Button ID="ButtonNextPage" runat="server" Text="Next" Visible="false" OnClick="ButtonNextPage_Click" Height="30px" style="margin-left: 0px" Width="233px" />
                    </td>
                </tr>
                <!--<tr>
                    <td colspan ="2">

                    </td>
                    
                </tr>-->
            

            </table>
        </div>
    </div>
    </form>
</body>
</html>
