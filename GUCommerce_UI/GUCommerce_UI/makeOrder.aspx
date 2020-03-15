<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MakeOrder.aspx.cs" Inherits="MakeOrder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <br />
            <br />
            <asp:RadioButtonList ID="paymentType" runat="server" AutoPostBack="True">
                <asp:ListItem>Cash</asp:ListItem>
                <asp:ListItem>Credit</asp:ListItem>
            </asp:RadioButtonList>
            <asp:TextBox ID="amount" runat="server"></asp:TextBox>
            <br />
            <asp:Button ID="btn_pay" runat="server" Text="OK" OnClick="payment_amount" />
            <br />
            <br />
            <br />

        </div>
    </form>
</body>
</html>
