<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectPerformers.aspx.cs" Inherits="TorlageProjectApp.SelectPerformers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td><asp:Label ID="LabelDate" runat="server" Text="Date: "></asp:Label></td>
                <td><asp:TextBox ID="TextBox1" runat="server" Text ="2015-10-10"></asp:TextBox></td>
                <td>
                    <asp:Button ID="ButtonGetDate" runat="server" Text="Get Availability" OnClick="ButtonGetDate_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Calendar ID="Calendar1" runat="server" OnSelectionChanged="Calendar1_SelectionChanged"></asp:Calendar>
                </td>
                <td>       
                    <div class ="AddPerformers">
                        <asp:TextBox ID="TextBoxAddPerformers" runat="server" Height="253px"  Width="204px" Text="Add Performers" ReadOnly="True"></asp:TextBox>
                    </div>
                </td>
                <td>
                    <div class ="Available Performers">
                       <asp:PlaceHolder ID="PlaceHolderAvaliablePerformers" runat="server">
                           <asp:SqlDataSource ID="SqlDataSourceAvailablePerformers" runat="server"
                               ConnectionString="<%$ ConnectionStrings:TConnectionString %>" 
                                SelectCommand="SELECT * FROM [PerformersAvailable] where ( ScheduleDate = @PerformeanceDate) AND (Available = 1)">
                                <SelectParameters>
                                    <asp:ControlParameter Name="PerformeanceDate" Type="String" 
                                        ControlID="Textbox1" PropertyName="Text" />
                                </SelectParameters>
                           </asp:SqlDataSource>    
                        </asp:PlaceHolder>
                        <asp:ListView ID="ListView2" runat="server" DataSourceID="SqlDataSourceAvailablePerformers">                    
                            <ItemTemplate>
                                <table>
                                    <tr>
                                        <td><%# Eval("PerformerName") %></td>
                                   </tr>
                                </table>
                            </ItemTemplate>
                        </asp:ListView>
                   </div>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
