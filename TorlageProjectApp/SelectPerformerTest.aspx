<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectPerformerTest.aspx.cs" Inherits="TorlageProjectApp.SelectPerformerTest" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <!---->
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td><asp:Label ID="LabelDate" runat="server" Text="Date: "></asp:Label></td>
                <td><asp:TextBox ID="TextBoxShowDate" runat="server" Text ="2015-10-10"></asp:TextBox></td>
                <td>
                    <asp:Button ID="ButtonGetDate" runat="server" Text="Get Availability" OnClick="ButtonGetDate_Click" />
                </td>
            </tr>
            <tr>
                <!--Calendar-->
                <td>
                    <asp:Calendar ID="CalendarShowDate" runat="server" OnSelectionChanged="Calendar1_SelectionChanged"></asp:Calendar>
                </td>
                <!--List of performers available-->
                <td>
                    <div class ="Available Performers">
                       <asp:PlaceHolder ID="PlaceHolderAvaliablePerformers" runat="server">
                           <asp:SqlDataSource ID="SqlDataSourceAvailablePerformersTest" runat="server"
                               ConnectionString="<%$ ConnectionStrings:TConnectionString %>" 
                                SelectCommand="SELECT PerformerName FROM [PerformersAvailable] where ( ScheduleDate = @PerformeanceDate) AND (Available = 1)">
                                <SelectParameters>
                                    <asp:ControlParameter Name="PerformeanceDate" Type="String" 
                                        ControlID="TextboxShowDate" PropertyName="Text" />
                                </SelectParameters>
                           </asp:SqlDataSource>
                               
                        </asp:PlaceHolder>

                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumn="False" DataKeyNames="PerformerName" DataSourceID="SqlDataSourceAvailablePerformersTest" >                    
                            <Columns>
                            <asp:TemplateField>
                            <ItemTemplate>
                                
                                            <asp:CheckBox ID="CheckBoxSelectPerformer" runat="server" /><!--<%# Eval("PerformerName") %>-->
                                        
                            </ItemTemplate>
                            </asp:TemplateField>
                        
                                
                            </Columns>
                        </asp:GridView>
                        <asp:Button ID="ButtonSelectPeople" runat="server" Text="Add Performers" OnClick="ButtonSelectPeople_Click" />
                        
                   </div>
                </td>
                <!--end or List of Performers available-->
                <td>       
                    <div class ="AddPerformers">
                        <asp:TextBox ID="TextBoxAddPerformers" runat="server" Height="22px"  Width="237px" Text="Add Performers" ReadOnly="True"></asp:TextBox>
                    </div>
                </td>

            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server"  Text="Set Show Date For:" DataSourceID="SqlDataSourceSetShowDate"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:SqlDataSource ID="SqlDataSourceSetShowDate" runat="server"
                        ConnectionString="<%$ ConnectionStrings:TConnectionString %>" 
                                SelectCommand="SELECT * FROM [PerformersAvailable] where ( ScheduleDate = @PerformeanceDate) AND (Available = 1)">
                        <SelectParameters>
                            <asp:ControlParameter Name="PerformeanceDate" Type="String" 
                            ControlID="TextBoxSetShowDate" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:TextBox ID="TextBoxSetShowDate" runat="server" ></asp:TextBox>
                </td>
                
            </tr>
            <tr>
                <td>
                    <asp:Button ID="ButtonSetShow" runat="server" Text="Set Show Date" OnClick="ButtonSetShow_Click" />
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
