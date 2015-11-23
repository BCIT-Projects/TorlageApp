<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageDirectorRole.aspx.cs" Inherits="TorlageProjectApp.ManageDirectorRole" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <table>
                <tr>
                <!--List of performers available-->
                <td >
                    <div class ="PerformerAvailableList">
                       <asp:PlaceHolder ID="UsersAvaliable" runat="server">
                           <asp:SqlDataSource ID="AllUsersAvailable" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT Id, UserName, RoleId
                                            FROM [AspNetUsers] Left Join AspNetUserRoles
                                            ON  AspNetUsers.Id = AspNetUserRoles.UserId 
                                            ">


                           </asp:SqlDataSource>
                        </asp:PlaceHolder>
                        <asp:GridView ID="GridViewAllUsers" runat="server" autogeneratecolumns="false"  datakeynames="Id,UserName,RoleId" DataSourceID="AllUsersAvailable" >                    
                            <Columns>
                                <asp:boundfield datafield="Id" readonly="true" headertext="ID"/>
                                <asp:boundfield datafield="UserName" readonly="true" headertext="Performer Name"/>
                                <asp:boundfield datafield="RoleId" readonly="true" headertext="Role"/>
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
                        <asp:Button ID="ButtonAddDirector" runat="server" Text="ADD Director" OnClick="ButtonAddDirector_Click" />
                    </td>
                    <td>
                        <asp:Button ID="ButtonRemoveDirector" runat="server" Text="Remove Director" OnClick="ButtonRemoveDirector_Click" />
                        <asp:Label ID="LabelAddUser" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>

         </table>

</asp:Content>
