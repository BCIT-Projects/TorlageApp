<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectPerformers.aspx.cs" Inherits="TorlageProjectApp.SelectPerformers" %>

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

.PerformerList{
    height: 230px;
    width: 150px;
    border-style: solid;
    border-color:black;
}
.PerformerAvailableList{
    height: 230px;
    width: 170px;
    border-style: solid;
    border-color:black;
    padding:5px;
    background-color:#EEEEEE;
}
#GridViewAvailablePerform{
    padding:10px;
    margin:10px;
}
.CalandarBackGround td{
    text-align:center;
    vertical-align: top;
    
    padding:5px;
}
.SelectPerformers {
    text-align:center;
    vertical-align: top;
}

.SelectPerformers table{
    margin: 10px;
}
    </style>  

</head>
<body>
    
    <!---->
    <form id="form1" runat="server">
    <div id ="DirectorPages">
        <div id="navbar-director">
            <ul>
                <li><a runat="server" href="~/Director">Set Show Date</a></li>
                <li><a runat="server" href="~/SelectPerformers">Create A Show</a></li>
           <!-- <li><a runat="server" href="~/CreateShowList">Create Show List</a></li>
                <li><a runat="server" href="~/ReviewShowList">Review Show List</a></li>
            -->
            </ul>
        </div>
        <div class ="CalandarBackGround">
        <table>
            
            <tr>
                <td>
                <asp:Label ID="LabelDate" runat="server" Text="Date: "></asp:Label>
                <asp:TextBox ID="TextBoxShowDate" runat="server" Text ="2015-10-10"></asp:TextBox>
                <asp:Button ID="ButtonGetDate" runat="server" Text="Get Availability" OnClick="ButtonGetDate_Click" />
                </td>
                <td class ="PeopleLable">
                      <asp:Label ID="LabelNoPerformerList" runat="server" Text="NOT Available"></asp:Label>
                </td>
                
            </tr>
            <tr>
                <!--Calendar-->
                <td>
                    <asp:Calendar ID="CalendarShowDate" BackColor="White" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" Height="237px" Width="320px" OnDayRender="CalendarShowDate_DayRender"></asp:Calendar>
                </td>
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
                                        ControlID="TextboxShowDate" PropertyName="Text" />
                                </SelectParameters>
                           </asp:SqlDataSource>
                        </asp:PlaceHolder>
                        <asp:GridView ID="GridView2" runat="server"  DataKeyNames="PerformerName" DataSourceID="SqlDataSourceNotAvailable" >                    
                            <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <!--<%# Eval("PerformerName") %>-->        
                                </ItemTemplate>
                            </asp:TemplateField>         
                            </Columns>
                        </asp:GridView>
                        </div>
                    </td>
                    <!---end of display of performers NOT-->

            </tr>
        </table>
        </div>
        
        <div class ="SelectPerformers">
        <table >
            <tr>
                <td>
                    <asp:Label ID="LabelTitleName" runat="server" Text="Select Performers" Font-Bold="True" Font-Size="Large" Height="20px"></asp:Label>
                </td>

            </tr>
            <tr>
                <td class ="PeopleLable"><asp:Label ID="LabelSelectTable" runat="server" Text="Performers Available"></asp:Label></td>
                <td></td>
                <td>
                    <asp:Label ID="LabelDescriptionPerformersShedule" runat="server" Text="Performers Scheduled"></asp:Label>
                </td>
            </tr>
            <tr>        
                <!--List of performers available-->
                <td >
                    <div class ="PerformerAvailableList">
                       <asp:PlaceHolder ID="PlaceHolderAvaliablePerformers" runat="server">
                           <asp:SqlDataSource ID="SqlDataSourceAvailablePerformers" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT Performers.PerformerID, PerformerName   
                                            FROM [Performers] LEFT JOIN [PerformersAvailable]
                                            on Performers.PerformerID = PerformersAvailable.PerformerID
                                            where ( ScheduleDate = @PerformeanceDate) AND (Available = 1)">

                                    <SelectParameters>
                                    <asp:ControlParameter Name="PerformeanceDate" Type="String" 
                                        ControlID="TextboxShowDate" PropertyName="Text" />
                                </SelectParameters>
                           </asp:SqlDataSource>
                        </asp:PlaceHolder>
                        <asp:GridView ID="GridViewAvailablePerform" runat="server" autogeneratecolumns="false"  datakeynames="PerformerID,PerformerName" DataSourceID="SqlDataSourceAvailablePerformers" >                    
                            <Columns>
                                <asp:boundfield datafield="PerformerID" readonly="true" headertext="ID"/>
                                <asp:boundfield datafield="PerformerName" readonly="true" headertext="Performer Name"/>
                            <asp:TemplateField>
                            <ItemTemplate>
                                            <asp:CheckBox ID="CheckBoxSelectPerformer" runat="server" />            
                            </ItemTemplate>
                            </asp:TemplateField>         
                            </Columns>
                        </asp:GridView>
                        
                   </div>
                </td>
                <!--end or List of Performers available-->
                <!-- add lead singer -->
                <td>
                    <asp:Button ID="ButtonAddPerformers" runat="server" Text="Add Performers" OnClick="ButtonSelectPeople_Click" Height="30px" Width="131px" />
                </td>
                <td>       
                    
                    <div class ="PerformerAvailableList">
                        <asp:Label ID="LabelAddPerformers" runat="server" Text=""></asp:Label>
                    </div>
                </td>

           
            </tr>




            <tr>
                <td colspan="2"></td>
                <td>
                    <div class="BottomNavigation">
                     <asp:Button ID="ButtonBackPage" runat="server" Text="Back" OnClick="ButtonBackPage_Click" />
                     <asp:Button ID="ButtonNextPage" runat="server" Text="Next" OnClick="ButtonNextPage_Click" />
                    </div>
                </td>
            </tr>
        </table>
        </div>
        
        
    </div>
    

    </form>
</body>
</html>
