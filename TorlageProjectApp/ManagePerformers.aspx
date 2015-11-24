<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManagePerformers.aspx.cs" Inherits="TorlageProjectApp.ManagePerformers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
<style type="text/css">
body {
    
    margin: auto;
    width: 100%;    
    margin: 0;
    font-family: Arial;

}  

#picture{
   
    width:355px;
    margin-right:20px;
    float:left;
}
#DirectorPages{
    
    width: 100%;
    height: 850px;
    margin: auto;
    float:right;
    padding-top: 20px;
    padding-bottom: 20px;
    padding-left: 50px;
    padding-right: 50px;
}

</style>

    
    <div id="DirectorPages">
        <div id="picture">
                <img width="350" height="500" alt="bg image" longdesc="background image"src="Resources/TorlageFinal.jpg" />
        </div>

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

        </div>
</asp:Content>
