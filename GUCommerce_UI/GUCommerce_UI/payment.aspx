<%@ Page Language="C#" AutoEventWireup="true" CodeFile="payment.aspx.cs" Inherits="payment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lbl_cash" runat="server" Text="Cash amount: "></asp:Label>
            &nbsp;<asp:TextBox ID="txt_cash" runat="server"></asp:TextBox>
            <br />
            <asp:Label ID="lbl_credit" runat="server" Text="Credit amount: "></asp:Label>
            <asp:TextBox ID="txt_credit" runat="server"></asp:TextBox>
            <br />
        </div>
        <p>
            <asp:Button ID="btn_pay" runat="server" Text="Pay" OnClick="pay" />
        </p>
    </form>
</body>
</html>
