<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ManageProfile.aspx.cs" Inherits="TorlageProjectApp.ManageProfile" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <h2><%: Title %></h2>

        <div class="row">
            <div class="col-md-8">
                <section id="loginForm">
                    <div class="form-horizontal">
                        <h4>Use a name that you want displayed to others on the calendar view.</h4>
                        <hr />
                          <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                            <p class="text-danger">
                                <asp:Literal runat="server" ID="FailureText" />
                            </p>
                        </asp:PlaceHolder>
                        <div class="col-md-10">
                            <asp:Label runat="server" AssociatedControlID="Name" CssClass="col-md-2 control-label" ID="NameLabel" style="left: -1px; top: 0px">Name</asp:Label>
                            <asp:TextBox runat="server" ID="Name" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Name"
                                                    CssClass="text-danger" ErrorMessage="The name field is required." ID="RequiredFieldValidator1" />
                        <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" OnClick="ChangeName" Text="Change Name" CssClass="btn btn-default" ID="ChangeNameButton" />
                        </div>
                    </div>
                </section>
            </div>
        </div>

</asp:Content>
