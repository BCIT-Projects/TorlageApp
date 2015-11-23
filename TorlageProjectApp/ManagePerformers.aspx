﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManagePerformers.aspx.cs" Inherits="TorlageProjectApp.ManagePerformers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <table>
                <tr>
                <!--List of performers available-->
                <td >
                    <div class ="PerformerAvailableList">
                       <asp:PlaceHolder ID="UsersAvaliable" runat="server">
                           <asp:SqlDataSource ID="AllUsersAvailable" runat="server"
                               ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" 
                                SelectCommand="SELECT * FROM [Performers] ">
                           </asp:SqlDataSource>
                        </asp:PlaceHolder>
                        <asp:GridView ID="GridViewAllUsers" runat="server" autogeneratecolumns="false"  datakeynames="PerformerID,PerformerName,Active,LogInUserID" DataSourceID="AllUsersAvailable" >                    
                            <Columns>
                                <asp:boundfield datafield="PerformerID" readonly="true" headertext="ID"/>
                                <asp:boundfield datafield="PerformerName" readonly="true" headertext="Performer Name"/>
                                <asp:boundfield datafield="Active" readonly="true" headertext="Active"/>
                                
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
                        <asp:Label ID="LabelAddUser" runat="server" Text="Label"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="ButtonActivePerformer" runat="server" Text="Performer Active" OnClick="ButtonActivePerformer_Click" />
                        <asp:Button ID="ButtonNotActivePerformer" runat="server" Text="Performer Not Active" OnClick="ButtonNotActivePerformer_Click" />
                    </td>
                    
                </tr>

         </table>


</asp:Content>
