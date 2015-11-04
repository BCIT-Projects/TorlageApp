<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SelectPerformers.aspx.cs" Inherits="TorlageProjectApp.SelectPerformers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:TConnectionString %>" SelectCommand="SELECT * FROM [PerformersAvailable]"></asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
