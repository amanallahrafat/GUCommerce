<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CustomerRegister.aspx.cs" Inherits="CustomerRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="username_lbl" runat="server" Text="Username "></asp:Label>
            <asp:TextBox ID="username_txt" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="fname_lbl" runat="server" Text="First name "></asp:Label>
            <asp:TextBox ID="fname_txt" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="lname_lbl" runat="server" Text="Last name "></asp:Label>
            <asp:TextBox ID="lname_txt" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="pass_lbl" runat="server" Text="Password "></asp:Label>
            <asp:TextBox ID="pass_txt" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="email_lbl" runat="server" Text="Email "></asp:Label>
            <asp:TextBox ID="email_txt" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="submit_btn" runat="server" Text="Submit" OnClick="cutomer_reg" />
        </div>
    </form>
</body>
</html>
