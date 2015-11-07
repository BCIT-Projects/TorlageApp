<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectPerformers.aspx.cs" Inherits="TorlageProjectApp.SelectPerformers" %>

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
.links{
    background-color: #BBBBBB;
}
.DirectorTableFields{
    background-color: #EEEEEE;
}
.CalandarBackGround{
    background-color: #6f8ef5;
    float: left;

}
.DirectorPages{
    width: 1005px;

}
    </style>  

</head>
<body>
    <div class ="links">
            <ul>
                <li><a runat="server" href="~/Director">Set Show Date</a></li>
                <li><a runat="server" href="~/SelectPerformers">Select Performers</a></li>
                <li><a runat="server" href="~/CreateShowList">Create Show List</a></li>
                <li><a runat="server" href="~/ReviewShowList">Review Show List</a></li>
            </ul>
        </div>
    <!---->
    <form id="form1" runat="server">
    <div class ="DirectorPages">
        <div class ="CalandarBackGround">
        <table>
            <tr>
                <td><asp:Label ID="LabelDate" runat="server" Text="Date: "></asp:Label>
                <asp:TextBox ID="TextBoxShowDate" runat="server" Text ="2015-10-10"></asp:TextBox>
                <asp:Button ID="ButtonGetDate" runat="server" Text="Get Availability" OnClick="ButtonGetDate_Click" />
                </td>
                
            </tr>
            <tr>
                
                <!--Calendar-->
                <td>
                    <asp:Calendar ID="CalendarShowDate" BackColor="White" runat="server" OnSelectionChanged="Calendar1_SelectionChanged" Height="205px" Width="331px"></asp:Calendar>
                </td>
            </tr>
        </table>
        </div>
        <div class ="DirectorTableFields">
        <table >
            <tr>
                <td><asp:Label ID="LabelSelectTable" runat="server" Text="Performers Available"></asp:Label></td>
            </tr>
            <tr></tr>
            <tr></tr>
            <tr>        
                <!--List of performers available-->
                <td>
                    <div>
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
                        
                   </div>
                </td>
                
                <!--end or List of Performers available-->
            <td>
                <asp:Button ID="ButtonSelectPeople" runat="server" Text="Add Performers" OnClick="ButtonSelectPeople_Click" Height="24px" Width="131px" />
            </td>
                <td>       
                    <asp:Label ID="LabelDescriptionPerformersShedule" runat="server" Text="Performers Scheduled"></asp:Label>
                    <div class ="AddPerformers">
                        <asp:TextBox ID="TextBoxAddPerformers" runat="server" Height="99px"  Width="153px" Text="" ReadOnly="True"></asp:TextBox>
                    </div>
                </td>

            </tr>

        </table>
        </div>
    </div>
    <div class="BottomNavigation">
        <asp:Button ID="ButtonBackPage" runat="server" Text="Back" OnClick="ButtonBackPage_Click" />
        <asp:Button ID="ButtonNextPage" runat="server" Text="Next" OnClick="ButtonNextPage_Click" />
    </div>

    </form>
</body>
</html>
