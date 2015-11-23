<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PerformersNumbers.aspx.cs" Inherits="TorlageProjectApp.PerformersNumbers1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
     <div id="wrapper" style="width: 1005px; margin: 0 auto;" >
        <div id="leftcolumn" style="border: 1px solid white; float: left; min-height: 450px; color: black;">
            <asp:Label ID="LabelMyNumbers" runat="server" Text="My numbers:"></asp:Label>
            <asp:ListBox ID="ListBoxNumbersKnown" runat="server" Height="397px" Width="275px"></asp:ListBox>
        </div>
        <div id="rightcolumn" style="border: 1px solid white; float: right; min-height: 450px; color: black; width: 635px; background-color: #d0d0d0;">
            <asp:Label ID="LabelAddANumber" runat="server" Text="Add a new number:"></asp:Label>
            <asp:DropDownList ID="DropDownList1" runat="server">
            </asp:DropDownList>
        </div>
    
    </div>
</asp:Content>
