<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DirectorShow.aspx.cs" Inherits="TorlageProjectApp.DirectorShow" %>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<style type="text/css">

body {
    
    margin: auto;
    width: 100%;    
    margin: 0;
    font-family: Arial;

}  

#picture{
   
    width:355px;
    margin-right:20px;
    float:left;
}
#DirectorPages{
    
    width: 100%;
    height: 850px;
    margin: auto;
    float:right;
    padding-top: 20px;
    padding-bottom: 20px;
    padding-left: 50px;
    padding-right: 50px;
}

.DirectorLink ul{
display: block;
list-style-type: disc;
}
.DirectorLink ul li{
    display: inline;
}
.DirectorLink ul li a{
    text-decoration: none;
    color: #fff;
    background-color: #036;
}

.DirectorLink ul li a:hover
{
color: #fff;
background-color: #369;
}

#CalandarBackGround{
    width:550px;
    height: 50px;
    margin: auto;
}
footer{
    clear:both;
}

td {
    text-align:center;
    vertical-align: top;
    padding:2px;
    
 
}

.ButtonAddPerformers td {
    text-align:right;
    vertical-align: top;
    padding:5px;
}
#GridViewAvailable td{
    background-color: #EEEEEE;
    width:auto;
}
#GridViewPerforming td{
    background-color: #EEEEEE;
    width:auto;
}
.NextButton{
    text-align:right;
     vertical-align: bottom;
}
.PerformerList{
  
}

</style>
    
    <div id="DirectorPages">
        <div id="picture">
            <img width="350" height="500" alt="bg image" longdesc="background image"src="Resources/TorlageFinal.jpg" />
        </div>

        
        <div>
            <table>
                <tr>
                   
                <td>
                    <div class="DirectorLink">
                        <ul >
                             <li><a runat="server" href="~/DirectorShow">Set Show Date</a></li>
                             <li><a runat="server" href="~/DirectorSelectPerformers">Select Performers</a></li>
           
                         </ul>
                  </div>

                </td>
            
                </tr>
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
                                SelectCommand="SELECT PerformerName, Active
                                            FROM [PerformersAvailable] LEFT JOIN [Performers]
                                            on PerformersAvailable.PerformerID = Performers.PerformerID
                                            where ( ScheduleDate = @PerformeanceDate) AND (Available = 1) AND Active = 1">
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


</asp:Content>
