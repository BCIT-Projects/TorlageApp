<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Director.aspx.cs" Inherits="TorlageProjectApp.Director" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">

body {
    background-color: #6f8ef5;
    margin: 0;
    font-family: Arial;

}  
    </style>  
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div>
            <ul>
                <li><a runat="server" href="~/Director">Set Show Date</a></li>
                <li><a runat="server" href="~/SelectPerformers">Select Performers</a></li>
                <li><a runat="server" href="~/CreateShowList">Create Show List</a></li>
                <li><a runat="server" href="~/ReviewShowList">Review Show List</a></li>
            </ul>
        </div>
        <div>
            <table>
                <tr>
                    <td>
                        <asp:Label ID="LabelSetShowDate" runat="server" Text="Set Show Date"></asp:Label></td>
                    
                </tr>
                <tr>
                    <td>
                        <asp:SqlDataSource ID="SqlDataSourceSetShowDate" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT * FROM [PerformersAvailable] where ( ScheduleDate = @PerformeanceDate) AND (Available = 1)">
                        <SelectParameters>
                            <asp:ControlParameter Name="PerformeanceDate" Type="String" 
                            ControlID="TextBoxSetShowDate" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:TextBox ID="TextBoxSetShowDate" runat="server" ></asp:TextBox>
                        <asp:Label ID="LabelShowOrNoShow" runat="server" Text=""></asp:Label>
                    </td>
                    <td>
                        <asp:Label ID="LabelPerformersList" runat="server" Text="List of Performers"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <!--Calendar-->
                    <td>
                        <asp:Calendar ID="CalendarShowDate" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" OnDayRender="CalendarShowDate_DayRender"></asp:Calendar>
                    </td>
                    <!---display of performers-->
                    <td>
                       <div class ="Available Performers">
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

                        <asp:GridView ID="GridView1" runat="server"  DataKeyNames="PerformerName" DataSourceID="SqlDataSourceAvailablePerformers" >                    
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
                    <!---end of display of performers-->
                </tr>
             <!-- start of setting show date-->
            <tr>
                <td>
                    
                </td>
                
            </tr>
            <tr>
                <td>
                    <asp:Button ID="ButtonSetShow" runat="server" Text="Set Show Date" OnClick="ButtonSetShow_Click" />
                    <asp:Button ID="ButtonRemoveSetShow" runat="server" Text="Remove Show Date" OnClick="ButtonRemoveSetShow_Click" />
                </td>
                <td>
                    
                </td>
            </tr>

                  <tr><td></td>
                <td></td>
                <td>
                    <asp:Button ID="ButtonNextPage" runat="server" Text="Next" OnClick="ButtonNextPage_Click" />
                </td>

            </tr>

            </table>
        </div>
    </div>
    </form>
</body>
</html>
