<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Customer_home_page.aspx.cs" Inherits="Customer_home_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
        </div>
            <asp:Label ID="Label7" runat="server" Text="Add Phone Number"></asp:Label>
            <br />
            <asp:TextBox ID="phone" runat="server">Enter Phone Number</asp:TextBox>
&nbsp;&nbsp;&nbsp;
            <asp:Button ID="add_phone" runat="server" Text="Add" Width="89px" OnClick="add_phone_Click" />
            <br />
            <br />
        <asp:Label ID="AddCClbl" runat="server" Text="Credit Card number"></asp:Label>
        <br />
        <asp:TextBox ID="CCnumber" runat="server" Width="241px"></asp:TextBox>
        <br />
        <asp:Label ID="expiry_date" runat="server" Text="Expiry Date"></asp:Label>
        &nbsp;<asp:Label ID="Label1" runat="server" Text="in format yyyy-mm"></asp:Label>
        <br />
        <asp:TextBox ID="expiry_date_years" runat="server" Width="54px">yyyy</asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="expiry_date_months" runat="server" Width="56px">mm</asp:TextBox>
        &nbsp;&nbsp;<br />
        <asp:Label ID="cvv" runat="server" Text="CVV"></asp:Label>
        <br />
        <asp:TextBox ID="CCCVV" runat="server" Width="74px">CVV</asp:TextBox>
        <br />
        <br />
        <asp:Button ID="AddCC" runat="server" Text="Add Credit Card" Width="183px" OnClick="AddCC_Click" />
        <br />
        <br />
        <asp:Label ID="CreateWL" runat="server" Text="Create new Wishlist"></asp:Label>
        <br />
        <asp:TextBox ID="WLname" runat="server" Width="241px"></asp:TextBox>
        <br />
        <asp:Button ID="WishList" runat="server" Text="Create new Wishlist" Width="183px" OnClick="WishList_Click" />
        <asp:Button ID="cancel_order" runat="server" Text="Cancel Order" OnClick="cancel_order" />
        <br />
        <br />
        <asp:Label ID="lbl_addCart" runat="server" Text="ADD to Cart"></asp:Label>
        <br />
        <asp:TextBox ID="addToCart" runat="server" Width="224px">Product serial number</asp:TextBox>
        <asp:Button ID="addCart" runat="server" Text="ADD" Width="75px" OnClick="addCart_Click" />
        <br />
        <asp:Label ID="lbl_removeCart" runat="server" Text="remove From Cart"></asp:Label>
        <br />
        <asp:TextBox ID="removefromCart" runat="server" Width="220px">product serial number</asp:TextBox>
        <asp:Button ID="remove_cart" runat="server" Text="remove" OnClick="remove_cart_Click" />
        <br />
        <br />
        <asp:Label ID="lbl_addwishlist" runat="server" Text="ADD to wishlist"></asp:Label>
        <br />
        <asp:TextBox ID="wishlist_name" runat="server" Width="224px">Enter wishList name</asp:TextBox>
        <asp:TextBox ID="removed_serial" runat="server" Width="200px">enter Product serial no</asp:TextBox>
        <asp:Button ID="addWishList" runat="server" Text="ADD" Width="75px" OnClick="addWishList_Click" />
        <br />
        <asp:Label ID="lbl_removewishlist" runat="server" Text="remove to wishlist"></asp:Label>
        <br />
        <asp:TextBox ID="wishlist_name0" runat="server" Width="224px">Enter wishList name</asp:TextBox>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="removed" runat="server" Width="200px">enter Product serial no</asp:TextBox>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Button ID="removewishList" runat="server" Text="remove" Width="75px" OnClick="removewishList_Click" />
        <br />
        <br />
        <asp:Label ID="prodcuts_lbl" runat="server" Text="Prodcuts" Font-Bold="True" Font-Size="Larger"></asp:Label>
        <br />
        <br />
        
        <br />
        
    </form>
</body>
</html>
