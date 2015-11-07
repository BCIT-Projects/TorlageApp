<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateShowList.aspx.cs" Inherits="TorlageProjectApp.CreateShowList" %>

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
        .auto-style1 {
            height: 99px;
            width: 279px;
        }
        .auto-style2 {
            width: 279px;
        }
        .auto-style3 {
            width: 232px;
        }
    </style>
</head>
<body>
    <div>
            <ul>
                <li><a runat="server" href="~/Director">Set Show Date</a></li>
                <li><a runat="server" href="~/SelectPerformers">Select Performers</a></li>
                <li><a runat="server" href="~/CreateShowList">Create Show List</a></li>
                <li><a runat="server" href="~/ReviewShowList">Review Show List</a></li>
            </ul>
        </div>
    <form id="form1" runat="server">
    <div>

        
    
        <table>
           <tr>
               <td class="auto-style2">
                   <asp:Label ID="LabelDate" runat="server" Text="Date: October-10-2015"></asp:Label>
               </td>
           </tr>
            <tr>
                <td class="auto-style2">
                    <asp:Label ID="LabelSet" runat="server" Text="Set:"></asp:Label>

                    <asp:RadioButton ID="RadioButton1" Text= "1" runat="server" />
                
                    <asp:RadioButton ID="RadioButton2" Text= "2" runat="server" />
               
                    <asp:RadioButton ID="RadioButton3" Text= "3" runat="server" />
                </td>
                <td>
                    <asp:Button ID="ButtonNewNumber" runat="server" Text="Add New Number" />

                </td>
            </tr>
            <tr>
                
                <td class="auto-style2">
                    <asp:Button ID="ButtonSinger" runat="server" Text="Singer" />

                    <asp:Button ID="ButtonDancer" runat="server" Text="Dancer" />
                </td>
                <td class="auto-style3">

                </td>
            </tr>
            <tr>


                
                <td class="auto-style1">
                    <asp:PlaceHolder ID="PlaceHolderNumbers" runat="server"></asp:PlaceHolder>
                    <asp:Label ID="LabelNumbersDescription" runat="server" Text="Numbers to Select"></asp:Label>
                </td>

                <td class="auto-style3">
                    <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                     <asp:Label ID="LabelSelectedNumDescription" runat="server" Text="Numbers Selected"></asp:Label>
                </td>
                
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button ID="ButtonBackPage" runat="server" Text="Back" OnClick="ButtonBackPage_Click" />
                    <asp:Button ID="ButtonNextPage" runat="server" Text="Next" OnClick="ButtonNextPage_Click" />

            </tr>
            </table>
    </div>

    </form>
</body>
</html>
