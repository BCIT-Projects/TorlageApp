<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TorlageProjectApp._Default" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    

  

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ToConnectionString %>" SelectCommand="SELECT * FROM [Performers]"></asp:SqlDataSource>

    

  
    <div id="spacertopbar"></div>
    <img id="default" alt="bg image" longdesc="background image"src="Resources/TorlageFinal.jpg" />
    <!--img alt="bg image" longdesc="background image" src="Resources/Torlage1.jpg" style="width: 1166px; height: 619px"/-->
    

  

</asp:Content>
