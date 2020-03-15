<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="GUCommerce_UI.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
             <asp:Label ID="username_label" runat="server" Text="Username"></asp:Label>
        <asp:TextBox ID="username_textbox" runat="server"></asp:TextBox>
        <br /> 
         <asp:Label ID="password_label" runat="server" Text="Password"></asp:Label>
          <asp:TextBox ID="password_textbox" runat="server"></asp:TextBox>
          <br /> 
          <asp:Button ID="login_Button" runat="server" Text="Login" OnClick="user_login" />
            <br />
             <asp:HyperLink ID="registerV" runat="server" NavigateUrl="~/VendorRegister.aspx">Register as a vendor</asp:HyperLink>
            <br />
               <asp:HyperLink ID="registerC" runat="server" NavigateUrl="~/CustomerRegister.aspx">Register as a customer</asp:HyperLink>
            <br />

        </div>
    </form>
</body>
</html>
