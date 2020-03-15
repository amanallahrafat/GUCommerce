<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vendor_home_page.aspx.cs" Inherits="Vendor_home_page" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Product Name"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox2" runat="server" MaxLength="20"></asp:TextBox>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Category"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox3" runat="server" MaxLength="20"></asp:TextBox>
            <br />
            <asp:Label ID="Label4" runat="server" Text="Product Description"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox4" runat="server" Height="103px" Width="236px"></asp:TextBox>
            <br />
            <asp:Label ID="Label5" runat="server" Text="Price"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox5" runat="server" MaxLength="11"></asp:TextBox>
            <br />
            <asp:Label ID="Label6" runat="server" Text="Color"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox6" runat="server" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button1" runat="server" Text="Post Products" OnClick="postProduct" />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <asp:Label ID="Label9" runat="server" Text="Serial Number"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label10" runat="server" Text="Product Name"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox10" runat="server" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label11" runat="server" Text="Category"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox11" runat="server" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label12" runat="server" Text="Product Description"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox12" runat="server" Height="97px" Width="226px"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label13" runat="server" Text="Price"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox13" runat="server" MaxLength="11"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label14" runat="server" Text="Color"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox14" runat="server" MaxLength="20"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button3" runat="server" Text="Edit Product" OnClick="EditProduct" />
            <br />
            <br />
            <br />
            <br />
            <asp:Label ID="Label15" runat="server" Text="Offer Amount"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox15" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label16" runat="server" Text="Expiry Date"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox16" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button4" runat="server" Text="Create Offer" OnClick="addOffer" />
            <br />
            <br />
            <br />
            <br />
            <asp:Label ID="Label18" runat="server" Text="Offer ID"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox18" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Label ID="Label19" runat="server" Text="Serial"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox19" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button5" runat="server" Text="Apply Offer" OnClick="applyOffer" />
            <br />
            <br />
            <br />
            <br />
            <asp:Label ID="Label20" runat="server" Text="Offer ID"></asp:Label>
            <br />
            <asp:TextBox ID="TextBox20" runat="server"></asp:TextBox>
            <br />
            <br />
            <asp:Button ID="Button6" runat="server" Text="Remove Expired Offer" OnClick="checkandremoveExpiredoffer" />
            <br />
        </div>
    </form>
</body>
</html>
