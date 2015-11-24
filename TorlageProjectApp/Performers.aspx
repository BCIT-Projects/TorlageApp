<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Performers.aspx.cs" Inherits="TorlageProjectApp.Performers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div id="wrapper">
    
        <div class="colorBehindLabel">
            <div id="top">
                <div class="spacer"></div>
                <div class="spacer"></div>
            </div>


            <div id="instructions">
                <asp:Label ID="LabelInstructions" runat="server" Text="Pick a date on the calender. Click 'Available' or 'Not Available' button below to say if available on that date."></asp:Label>
            </div>

            <div id="calendar">
                <asp:TextBox ID="TextBoxChangeAvailability" runat="server" Width="371px"></asp:TextBox>

                <asp:Calendar ID="CalendarChangeAvailability" runat="server" OnSelectionChanged="CalendarChangeAvailability_SelectionChanged" 
                    Style="min-height:400px; Width:371px;" BackColor="White" OnDayRender="CalendarChanageAvailability_DayRender"></asp:Calendar>
            </div>
            <asp:SqlDataSource ID="SqlTorlageDatabase" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" SelectCommand="SELECT * FROM [Performers]">
            </asp:SqlDataSource>
            <div class="spacer"></div>
            <div>
            <asp:Label ID="LabelChooseAvailable" runat="server"></asp:Label>
            <asp:Button ID="ButtonYes" runat="server" Text="Available" OnClick="ButtonYes_Click" />
            <asp:Button ID="ButtonNo" runat="server" Text="Not Available" OnClick="ButtonNo_Click" />
            <div class="spacer"></div>
            <asp:Label ID="LabelUserAlreadyClickedAvailability" runat="server" DataSourceID="SqlTorlageDatabase"></asp:Label>
                
                    <!---display of performers available-->
                    <td>
                       
                       <div class ="PerformerList">
                       <asp:PlaceHolder ID="PlaceHolderAvaliablePerformers" runat="server">
                           <asp:SqlDataSource ID="SqlDataSourceAvailablePerformers" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT PerformerName, Active
                                            FROM [PerformersAvailable] LEFT JOIN [Performers]
                                            on PerformersAvailable.PerformerID = Performers.PerformerID
                                            where ( ScheduleDate = @PerformanceDate) AND (Available = 1) AND (Active = 1)">
                                <SelectParameters>
                                    <asp:ControlParameter Name="PerformanceDate" Type="String" 
                                        ControlID="TextBoxChangeAvailability" PropertyName="Text" />
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
                       <asp:PlaceHolder ID="PlaceHolderNotAvailablePerformers" runat="server">
                           <asp:SqlDataSource ID="SqlDataSourceNotAvailablePerformers" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT PerformerName
                                            FROM [PerformersAvailable] LEFT JOIN [Performers]
                                            on PerformersAvailable.PerformerID = Performers.PerformerID
                                            where ( ScheduleDate = @PerformanceDate) AND (Available = 0)">
                                <SelectParameters>
                                    <asp:ControlParameter Name="PerformanceDate" Type="String" 
                                        ControlID="TextBoxChangeAvailability" PropertyName="Text" />
                                </SelectParameters>
                           </asp:SqlDataSource>
                        </asp:PlaceHolder>
                        <asp:GridView ID="GridViewNotAvailable" runat="server" autogeneratecolumns="false" DataKeyNames="PerformerName" DataSourceID="SqlDataSourceNotAvailablePerformers" >                    
                            <Columns>
                                <asp:boundfield datafield="PerformerName" readonly="true" headertext="Not Available Performer"/>        
                            </Columns>
                        </asp:GridView>
                        </div>
                    </td>
                    <!---end of display of performers NOT-->
            </div>
        </div>
    
        <br />
   
        </div>

</asp:Content>
