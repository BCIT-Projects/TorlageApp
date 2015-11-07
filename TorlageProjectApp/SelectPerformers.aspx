<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectPerformers.aspx.cs" Inherits="TorlageProjectApp.SelectPerformers" %>

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
                           <asp:SqlDataSource ID="SqlDataSourceAvailablePerformers" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT PerformerName
                                            FROM [PerformersAvailable] LEFT JOIN [Performers]
                                            on PerformersAvailable.PerformerID = Performers.PerformerID
                                            where ( ScheduleDate = @PerformeanceDate) AND (Available = 1)">

                                    <SelectParameters>
                                    <asp:ControlParameter Name="PerformeanceDate" Type="String" 
                                        ControlID="TextboxShowDate" PropertyName="Text" />
                                </SelectParameters>

                           </asp:SqlDataSource>


                        </asp:PlaceHolder>
                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumn="False" DataKeyNames="PerformerName" DataSourceID="SqlDataSourceAvailablePerformers" >                    
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
                        <asp:TextBox ID="TextBoxAddPerformers" runat="server" Height="253px"  Width="204px" Text="Add Performers" ReadOnly="True"></asp:TextBox>
                    </div>
                </td>

            </tr>
            

        </table>
    </div>
    </form>
</body>
</html>
