<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageRoles.aspx.cs" Inherits="TorlageProjectApp.Roles.ManageRoles" %>

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
                <!--List of performers available-->
                <td >
                    <div class ="PerformerAvailableList">
                       <asp:PlaceHolder ID="UsersAvaliable" runat="server">
                           <asp:SqlDataSource ID="AllUsersAvailable" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT Id, UserName   
                                            FROM [AspNetUsers] ">


                           </asp:SqlDataSource>
                        </asp:PlaceHolder>
                        <asp:GridView ID="GridViewAllUsers" runat="server" autogeneratecolumns="false"  datakeynames="Id,UserName" DataSourceID="AllUsersAvailable" >                    
                            <Columns>
                                <asp:boundfield datafield="Id" readonly="true" headertext="ID"/>
                                <asp:boundfield datafield="UserName" readonly="true" headertext="Performer Name"/>
                            <asp:TemplateField>
                            <ItemTemplate>
                                            <asp:CheckBox ID="CheckBoxUser" runat="server" />            
                            </ItemTemplate>
                            </asp:TemplateField>         
                            </Columns>
                        </asp:GridView>
                        
                   </div>
                </td>
                <!--end or List of Performers available-->
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="ButtonAddPerformer" runat="server" Text="ADD Performer" OnClick="ButtonAddPerformer_Click" />
                    </td>
                    <td>
                        <asp:Label ID="LabelAddUser" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>

         </table>
    </div>
    </form>
</body>
</html>
