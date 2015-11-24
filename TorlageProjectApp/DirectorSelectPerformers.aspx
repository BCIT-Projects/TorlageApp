<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DirectorSelectPerformers.aspx.cs" Inherits="TorlageProjectApp.DirectorSelectPerformers" %>
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
#navbar-director{
    width:550px;
    height: 50px;
    margin: auto;
    margin-top:50px;
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
    padding:5px;
    
 
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


</style>




<div id="fill">
    
  <div id ="DirectorPages">
            <div id="picture">
                <img width="350" height="500" alt="bg image" longdesc="background image"src="Resources/TorlageFinal.jpg" />
            </div>

       
        <div class ="CalandarBackGround">
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
                <td>
                    
                    <asp:Button ID="ButtonNextPage" runat="server" Text="Create Set List" OnClick="ButtonNextPage_Click" Visible ="false" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="LabelTitleName" runat="server" Text="Select Performers" Font-Bold="True" Font-Size="Large" Height="20px"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                <asp:Label ID="LabelDate" runat="server" Text="Date: "></asp:Label>
                <asp:TextBox ID="TextBoxShowDate" runat="server" Text ="2015-10-10"></asp:TextBox>
                <asp:Button ID="ButtonGetDate" runat="server" Text="Get Availability" OnClick="ButtonGetDate_Click" />
                </td>
                <td class ="PeopleLable">
                      <asp:Label ID="LabelNoPerformerList" runat="server" Text=" "></asp:Label>
                </td>
                
                
            </tr>
            <tr>
                <!--Calendar-->
                <td>
                    <asp:Calendar ID="CalendarShowDate" BackColor="White" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" Height="237px" Width="320px" OnDayRender="CalendarShowDate_DayRender"></asp:Calendar>
                </td>
                
                <!---display of performers Scheduled-->
                <td>    
                       <div class ="PerformerList">
                
                       <asp:PlaceHolder ID="PlaceHolderNotAvailable" runat="server">
                           <asp:SqlDataSource ID="SqlDataSourceNotAvailable" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT PerformerName
                                            FROM [PerformersAvailable] LEFT JOIN [Performers]
                                            on PerformersAvailable.PerformerID = Performers.PerformerID
                                            where ( ScheduleDate = @PerformeanceDate) AND (PenciledToPerform = 1)">
                                <SelectParameters>
                                    <asp:ControlParameter Name="PerformeanceDate" Type="String" 
                                        ControlID="TextboxShowDate" PropertyName="Text" />
                                </SelectParameters>
                           </asp:SqlDataSource>
                        </asp:PlaceHolder>
                        <asp:GridView ID="GridViewPerforming" runat="server" autogeneratecolumns="false" DataKeyNames="PerformerName" DataSourceID="SqlDataSourceNotAvailable" >                    
                            <Columns>
                                <asp:boundfield datafield="PerformerName" readonly="true" headertext="Scheduled To Perform"/>
                            
                            </Columns>
                        </asp:GridView>
                        </div>
                    
                </td>
                <!---end of display of performers Scheduled-->
            </tr>
            <tr>
                
                <td class="ButtonAddPerformers">
                    <asp:Button ID="ButtonAddPerformers" runat="server" Text="Update Performers" OnClick="ButtonSelectPeople_Click" Height="30px" Width="131px" Visible ="false"/>
                     <asp:Label ID="LabelAddPerformers" runat="server" Text=""></asp:Label>
                </td>
               
            </tr>
            <tr>
                                
                <!--List of performers available-->
                <td >
                    <div class ="PerformerAvailableList">
                       <asp:PlaceHolder ID="PlaceHolderAvaliablePerformers" runat="server">
                           <asp:SqlDataSource ID="SqlDataSourceAvailablePerformers" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT Performers.PerformerID, PerformerName, Active  
                                            FROM [Performers] LEFT JOIN [PerformersAvailable]
                                            on Performers.PerformerID = PerformersAvailable.PerformerID
                                            where ( ScheduleDate = @PerformeanceDate) AND (Available = 1) AND Active = 1">
                                    <SelectParameters>
                                    <asp:ControlParameter Name="PerformeanceDate" Type="String" 
                                        ControlID="TextboxShowDate" PropertyName="Text" />
                                </SelectParameters>
                           </asp:SqlDataSource>
                        </asp:PlaceHolder>
                        <asp:GridView ID="GridViewAvailablePerform" runat="server" autogeneratecolumns="false"  datakeynames="PerformerID,PerformerName" DataSourceID="SqlDataSourceAvailablePerformers" >                    
                            <Columns>
                                <asp:boundfield datafield="PerformerName" readonly="true" headertext="Available Performers"/>
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
                

            </tr>
            
        </table>
        </div>
      
        
    </div>


</div>


</asp:Content>
