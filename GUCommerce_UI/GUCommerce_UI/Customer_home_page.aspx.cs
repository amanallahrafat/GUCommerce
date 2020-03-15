using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Customer_home_page : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("ShowProductsbyPrice", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        conn.Open();

        //IF the output is a table, then we can read the records one at a time
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        int i = 1;
        while (rdr.Read())
        {
            int serial_no = rdr.GetInt32(rdr.GetOrdinal("serial_no"));
            string product_name = rdr.GetString(rdr.GetOrdinal("product_name"));
            string category = rdr.GetString(rdr.GetOrdinal("category"));
            string product_description = rdr.GetString(rdr.GetOrdinal("product_description"));
            decimal final_price = rdr.GetDecimal(rdr.GetOrdinal("final_price"));
            string color = rdr.GetString(rdr.GetOrdinal("color"));
            bool available = rdr.GetBoolean(rdr.GetOrdinal("available"));
            int rate = rdr.GetInt32(rdr.GetOrdinal("rate"));

            Label lbl_number = new Label();
            lbl_number.Text = "Product number :" + i + " <br /> ";
            this.Controls.Add(lbl_number);

            //Create a new label and add it to the HTML form
            Label lbl_serial_no = new Label();
            lbl_serial_no.Text = "serial: " + serial_no + " <br /> ";
            this.Controls.Add(lbl_serial_no);

            Label lbl_product_name = new Label();
            lbl_product_name.Text = "name: " + product_name + "<br />";
            this.Controls.Add(lbl_product_name);

            Label lbl_category = new Label();
            lbl_category.Text = "category: " + category + "<br />";
            this.Controls.Add(lbl_category);

            Label lbl_product_description = new Label();
            lbl_product_description.Text = "Description : " + product_description + "<br />";
            this.Controls.Add(lbl_product_description);

            Label lbl_final_price = new Label();
            lbl_final_price.Text = "price: " + final_price + "<br />";
            this.Controls.Add(lbl_final_price);

            Label lbl_color = new Label();
            lbl_color.Text = "color: " + color + "<br />";
            this.Controls.Add(lbl_color);

            Label lbl_available = new Label();
            lbl_available.Text = "availability: " + available + "<br />";
            this.Controls.Add(lbl_available);

            Label lbl_rate = new Label();
            lbl_rate.Text = "rate: " + rate + "<br />" + "<br />";
            this.Controls.Add(lbl_rate);

            i++;
        }
    }


    protected void AddCC_Click(object sender, EventArgs e)
    {
        //To read the input from the user
        string number = CCnumber.Text;
        string e_years = expiry_date_years.Text;
        string e_months = expiry_date_months.Text;
        string cvv = CCCVV.Text;
        string username = (string)(Session["username"]);
        int years;
        int months;
        if (number.Length > 20 || !number.All(char.IsDigit))
        {
            Response.Write("The credit card number is invalid, The maximum length of the number is 20 digit");
        }
        else if (cvv.Length > 20 || !number.All(char.IsDigit))
        {
            Response.Write("The credit card cvv is invalid, The maximum length of the cvv code is 20 digit");
        }
        else if (!int.TryParse(e_years, out years) || years < 2020 || years > 9999)
        {
            Response.Write("The expiry date years is invalid, it should be anumber of 4 digits greater that 2020");
        }
        else if (!int.TryParse(e_months, out months) || months > 12 || months < 1)
        {
            Response.Write("The expiry date month is invalid, it should be between 1 and 12");
        }
        else
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("AddCreditCard", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string expiry_date = e_years + "-" + e_months + "-";
            if (months == 1 || months == 3 || months == 5 || months == 7 || months == 8 || months == 10 || months == 12)
            { expiry_date += "31"; }
            if (months == 4 || months == 6 || months == 9 || months == 11)
            { expiry_date += "30"; }
            if (months == 2)
            { expiry_date += "28"; }

            cmd.Parameters.Add(new SqlParameter("@creditcardnumber", number));
            cmd.Parameters.Add(new SqlParameter("@expirydate", expiry_date));
            cmd.Parameters.Add(new SqlParameter("@cvv", cvv));
            cmd.Parameters.Add(new SqlParameter("@customername", username));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Response.Write("The Credit Card is added successfully");

            }
            catch (SqlException)
            {
                Response.Write("The Credit Card is already added before ,please add a new one");

            }

        }
    }

    protected void WishList_Click(object sender, EventArgs e)
    {
        string name = WLname.Text;
        string username = (string)(Session["username"]);
        if (name.Length > 20)
        {
            Response.Write("The name is invalid, The maximum length of the name is 20");
        }
        else
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("createWishlist", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add(new SqlParameter("@customername", username));
            cmd.Parameters.Add(new SqlParameter("@name", name));

            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Response.Write("The wishList is created successfully");

            }
            catch (SqlException)
            {
                Response.Write("wishList is already exist, please enter another name");

            }

        }
    }
    protected void add_phone_Click(object sender, EventArgs e)
    {
        string username = (string)(Session["username"]);
        string mob = phone.Text;
        int phone1 = -1;
        if (!Int32.TryParse(mob, out phone1))
        {
            Response.Write("ivalid order number , Please Enter order with digits only");
            return;
        }
        else
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addMobile", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@mobile_number", mob));
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Response.Write("The Phone Number is added successfully");

            }
            catch (SqlException)
            {
                Response.Write("The Number is Already Added try another Phone Number");

            }
        }
    }
    protected void addCart_Click(object sender, EventArgs e)
    {
        string username = (string)(Session["username"]);
        int serial = -1;
        if (!Int32.TryParse(addToCart.Text, out serial))
        {
            Response.Write("ivalid serial number , Please Enter serial with digits only");
            return;
        }
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("addToCart", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@customername", username));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));
        SqlParameter added = cmd.Parameters.Add("@already_added", SqlDbType.Int);

        added.Direction = ParameterDirection.Output;

        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            if (added.Value.ToString().Equals("1"))
            {
                Response.Write("the product is already added before");
            }
            else
            {
                Response.Write("The the product  added successfully");
            }
        }
        catch (SqlException)
        {
            Response.Write("ivalid serial number, no such serial");
        }

    }

    protected void remove_cart_Click(object sender, EventArgs e)
    {
        string username = (string)(Session["username"]);
        int serial = -1;
        if (!Int32.TryParse(removefromCart.Text, out serial))
        {
            Response.Write("ivalid serial number , Please Enter serial with digits only");
            return;
        }

        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("removefromCart", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@customername", username));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));
        SqlParameter found = cmd.Parameters.Add("@found", SqlDbType.Int);

        found.Direction = ParameterDirection.Output;

        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            if (found.Value.ToString().Equals("1"))
            {
                Response.Write("The product  removed successfully");
            }
            else
            {
                Response.Write("ivalid serial number, no such serial in the cart");
            }
        }
        catch (SqlException)
        {
            Response.Write("ivalid serial number, no such serial in the cart");
        }

    }

    protected void addWishList_Click(object sender, EventArgs e)
    {
        string username = (string)(Session["username"]);
        string WLname = wishlist_name.Text;
        int serial = -1;
        if (!Int32.TryParse(removed_serial.Text, out serial))
        {
            Response.Write("ivalid serial number , Please Enter serial with digits only");
            return;
        }
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("AddtoWishlist", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@customername", username));
        cmd.Parameters.Add(new SqlParameter("@wishlistname", WLname));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));
        SqlParameter added = cmd.Parameters.Add("@already_added", SqlDbType.Int);

        added.Direction = ParameterDirection.Output;

        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if (added.Value.ToString().Equals("1"))
            {
                Response.Write("the product is already added before");
            }
            else
            {
                Response.Write("The the product  added successfully");
            }
        }
        catch (SqlException)
        {
            Response.Write("ivalid input please enter valid serial or a valid wishlist name");
        }

    }

    protected void removewishList_Click(object sender, EventArgs e)
    {
        string username = (string)(Session["username"]);
        string WLname = wishlist_name0.Text;
        int serial = -1;
        if (!Int32.TryParse(removed.Text, out serial))
        {
            Response.Write("ivalid serial number , Please Enter serial with digits only");
            return;
        }
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);

        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("removefromWishlist", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@customername", username));
        cmd.Parameters.Add(new SqlParameter("@wishlistname", WLname));
        cmd.Parameters.Add(new SqlParameter("@serial", serial));
        SqlParameter found = cmd.Parameters.Add("@found", SqlDbType.Int);

        found.Direction = ParameterDirection.Output;

        try
        {
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            if (found.Value.ToString().Equals("1"))
            {
                Response.Write("The product  removed successfully");
            }
            else
            {
                Response.Write("ivalid serial number, no such serial in the this wishlist");
            }

        }
        catch (SqlException)
        {
            Response.Write("ivalid input please enter valid serial or wishlist name");
        }

    }


protected void Cancel_order(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        //create a new connection
        SqlConnection conn = new SqlConnection(connStr);
        string id = (string)(Session["orderID"]);
        /*create a new SQL command which takes as parameters the name of the stored procedure and
         the SQLconnection name*/
        SqlCommand cmd = new SqlCommand("cancelOrder", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@orderid", id));
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

    }

}