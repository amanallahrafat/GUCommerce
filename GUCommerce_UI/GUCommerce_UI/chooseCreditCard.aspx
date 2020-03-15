<%@ Page Language="C#" AutoEventWireup="true" CodeFile="chooseCreditCard.aspx.cs" Inherits="chooseCreditCard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lbl_credit" runat="server" Text="Credit Card Number"></asp:Label>
            <asp:DropDownList ID="creditList" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            <br />
            <asp:Button ID="credit" runat="server" Text="OK" OnClick="payCredit" />
        </div>
    </form>
</body>
</html>
