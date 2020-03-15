<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="Admin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
       <div>
            <asp:Label ID="Label7" runat="server" Text="Add Phone Number"></asp:Label>
            <br />
            <asp:TextBox ID="phone" runat="server">Enter Phone Number</asp:TextBox>
&nbsp;&nbsp;&nbsp;
            <asp:Button ID="add_phone" runat="server" Text="Add" Width="89px" OnClick="add_phone_Click" />
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="Activate Vendors"></asp:Label>
        </div>
        <asp:TextBox ID="vendor_name" runat="server">Enter Vendor Name</asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="activae_vendor" runat="server" Text="Activate" OnClick="activae_vendor_Click" />
        <br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="Update The Order Status"></asp:Label>
        <br />
        <asp:TextBox ID="order_no" runat="server">Enter order number</asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Button ID="update_status" runat="server" Text="Update" Width="101px" OnClick="update_status_Click" />
        <br />
        <br />
        <asp:Label ID="Label3" runat="server" Text="Create Today's Deals"></asp:Label>
        <br />
        <asp:TextBox ID="deal_amoount" runat="server">Enter Deal Amount</asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label8" runat="server" Text="Expiry Date (yyyy-mm)"></asp:Label>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="year" runat="server">Enter year</asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="month" runat="server">Enter month</asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="createTodaysDeals" runat="server" Text="Create" Width="95px" OnClick="createTodaysDeals_Click" />
        <br />
        <br />
        <asp:Label ID="Label4" runat="server" Text="Add Deals to Products"></asp:Label>
        <br />
        <asp:TextBox ID="dealID" runat="server">Enter Deal ID</asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="p_serial" runat="server">Enter Product serial</asp:TextBox>
&nbsp;&nbsp;&nbsp;
        <asp:Button ID="add_deals" runat="server" Text="Add" Width="92px" OnClick="add_deals_Click" />
        <br />
        <br />
        <asp:Label ID="Label5" runat="server" Text="Remove Expired Deals"></asp:Label>
        <br />
        <asp:TextBox ID="expired_deal" runat="server">Enter Deal ID</asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="remove_expired" runat="server" Text="Remove" Width="102px" OnClick="remove_expired_Click" />
        <br />
        <br />
        <asp:Label ID="Label6" runat="server" Text="Orders"></asp:Label>
        <br />
        <asp:GridView ID="GridView1" runat="server">
        </asp:GridView>
     </form>
</body>
</html>
