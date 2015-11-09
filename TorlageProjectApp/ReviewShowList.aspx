<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReviewShowList.aspx.cs" Inherits="TorlageProjectApp.ReviewShowList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
body {
    margin: auto;
    width: 100%;
    background-color: #6f8ef5;
    margin: 0;
    font-family: Arial;

}  

#DirectorPages{
    width: 540px;
    height: 650px;
    margin: auto;
    border:3px solid black;
    padding-top: 20px;
    padding-bottom: 20px;
    padding-left: 50px;
    padding-right: 50px;
}
#navbar-director{
    width:550px;
    height: 50px;
    margin: auto;
}
#navbar-director ul {
    display: block;
    list-style-type: disc;
    -webkit-margin-before: 1em;
    -webkit-margin-after: 1em;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
     -webkit-padding-start: 0px;
}

#navbar-director ul li { display: inline; 

}

#navbar-director ul li a
{
text-decoration: none;
padding: .2em 1em;
color: #fff;
background-color: #036;
}

#navbar-director ul li a:hover
{
color: #fff;
background-color: #369;
}

.ShowDisplay{
    height: 230px;
    width: 170px;
    border-style: solid;
    border-color:black;
    padding:5px;
    background-color:#EEEEEE;

}
        </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id ="DirectorPages">
        <div id="navbar-director">
            <ul>
             <!--   <li><a runat="server" href="~/Director">Set Show Date</a></li>
                -->
                <li><a runat="server" href="~/SelectPerformers">Select Performers</a></li>
                <li><a runat="server" href="~/CreateShowList">Create Show List</a></li>
                <li><a runat="server" href="~/ReviewShowList">Review Show List</a></li>
            </ul>
        </div>
        <div class="ReviewSetList">
         <table>
             <tr>
                 <td>
                     <asp:Label ID="LabelDate" runat="server" Text="Date: 10-10-2015"></asp:Label>
                 </td>
             </tr>
             <tr>
                 <td>
                 <asp:Label ID="LabelPerformers" runat="server" Text="Performers:<br>Billy<br>Jill<br>Ingrid"></asp:Label>

                 </td>
                 <td>
                     <div class="ShowDisplay">
                         <asp:TextBox ID="TextBoxShow" runat="server" Text="Set1....." Height="215px" TextMode="MultiLine" Width="157px"></asp:TextBox>
                     </div>
                 </td>
             </tr>


         </table>

     </div>
    </div>

     

    </form>
</body>
</html>
