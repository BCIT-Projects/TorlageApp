<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageRoles.aspx.cs" Inherits="TorlageProjectApp.ManageRoles" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <table>
                <tr>
                <!--List of performers available-->
                <td >
                    <div class ="PerformerAvailableList">
                       <asp:PlaceHolder ID="UsersAvaliable" runat="server">
                           <asp:SqlDataSource ID="AllUsersAvailable" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT Id, UserName   
                                            FROM [AspNetUsers] Where Not Exists 
                                            (select LogInUserID from Performers
                                               WHERE AspNetUsers.Id = Performers.LogInUserID) ">


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
</asp:Content>
