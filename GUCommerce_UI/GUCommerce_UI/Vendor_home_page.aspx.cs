using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

public partial class Vendor_home_page : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("vendorviewProducts", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        string vendorname = (string)(Session["username"]);
        cmd.Parameters.Add(new SqlParameter("@vendorname", vendorname));


        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();


        //IF the output is a table, then we can read the records one at a time
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            string product_name = rdr.GetString(rdr.GetOrdinal("product_name"));
            string serial_no = rdr.GetString(rdr.GetOrdinal("serial_no"));
            string category = rdr.GetString(rdr.GetOrdinal("category"));
            string final_price = rdr.GetString(rdr.GetOrdinal("final_price"));
            string color = rdr.GetString(rdr.GetOrdinal("color"));
            string available = rdr.GetString(rdr.GetOrdinal("available"));
            string rate = rdr.GetString(rdr.GetOrdinal("rate"));
            string product_description = rdr.GetString(rdr.GetOrdinal("product_description"));


            //Create a new label and add it to the HTML form
            Label lbl_product_name = new Label();
            lbl_product_name.Text = product_name + "  with serial: ";
            form1.Controls.Add(lbl_product_name);

            Label lbl_serial_no = new Label();
            lbl_serial_no.Text = serial_no + "  , of Category: ";
            form1.Controls.Add(lbl_serial_no);

            Label lbl_category = new Label();
            lbl_category.Text = category + "  , of Price: ";
            form1.Controls.Add(lbl_category);

            Label lbl_price = new Label();
            lbl_price.Text = final_price + "  , of Color: ";
            form1.Controls.Add(lbl_price);

            Label lbl_color = new Label();
            lbl_color.Text = color + "  , with Rate: ";
            form1.Controls.Add(lbl_color);

            Label lbl_rate = new Label();
            lbl_rate.Text = rate + "  , with Description: ";
            form1.Controls.Add(lbl_rate);

            Label lbl_product_description = new Label();
            lbl_product_description.Text = product_description + "  , available: ";
            form1.Controls.Add(lbl_product_description);

            Label lbl_available = new Label();
            lbl_available.Text = available + "  <br /> <br />";
            form1.Controls.Add(lbl_available);
        }

    }

    protected void postProduct(object sender, EventArgs e)
    {
        try
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("postProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string vendorUsername = (string)(Session["username"]);
            string product_name = TextBox2.Text;
            string category = TextBox3.Text;
            string product_description = TextBox4.Text;
            decimal price = Convert.ToDecimal(TextBox5.Text);
            string color = TextBox6.Text;

            //pass parameters to the stored procedure
            if ((!String.IsNullOrEmpty(product_name)) && (!String.IsNullOrEmpty(category)) && (!String.IsNullOrEmpty(product_description)) && (price != 0) && (!String.IsNullOrEmpty(color)))
            {
                cmd.Parameters.Add(new SqlParameter("@vendorUsername", vendorUsername));
                cmd.Parameters.Add(new SqlParameter("@product_name", product_name));
                cmd.Parameters.Add(new SqlParameter("@category", category));
                cmd.Parameters.Add(new SqlParameter("@product_description", product_description));
                cmd.Parameters.Add(new SqlParameter("@price", price));
                cmd.Parameters.Add(new SqlParameter("@color", color));

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }

        }
        catch (SqlException)
        {
            Response.Write("Please insert correct inputs");
        }

    }

    protected void EditProduct(object sender, EventArgs e)
    {
        try
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("EditProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user

            string vendorname = (string)(Session["username"]);
            int serialnumber = int.Parse(TextBox9.Text);
            string product_name = TextBox10.Text;
            string category = TextBox11.Text;
            string product_description = TextBox12.Text;
            decimal price = Convert.ToDecimal(TextBox13.Text);
            string color = TextBox14.Text;


            if ((!String.IsNullOrEmpty(product_name)) && (!String.IsNullOrEmpty(category)) && (!String.IsNullOrEmpty(product_description)) && (price != 0) && (!String.IsNullOrEmpty(color)) && (serialnumber != 0))
            {

                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@vendorname", vendorname));
                cmd.Parameters.Add(new SqlParameter("@serialnumber", serialnumber));
                cmd.Parameters.Add(new SqlParameter("@product_name", product_name));
                cmd.Parameters.Add(new SqlParameter("@category", category));
                cmd.Parameters.Add(new SqlParameter("@product_description", product_description));
                cmd.Parameters.Add(new SqlParameter("@price", price));
                cmd.Parameters.Add(new SqlParameter("@color", color));


                //Save the output from the procedure
                SqlParameter found = cmd.Parameters.Add("@found", SqlDbType.Bit);
                found.Direction = ParameterDirection.Output;

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();


                if (found.Value.Equals(true))
                {
                    //To send response data to the client side (HTML)
                    Response.Write("Producy updated successfully");

                }
                else
                {
                    Response.Write("Product not found");
                }
            }
        }
        catch (SqlException)

        {
            Response.Write("Please insert correct inputs");
        }
    }

    protected void addOffer(object sender, EventArgs e)
    {
        try
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("addOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            int offeramount = int.Parse(TextBox15.Text);
            DateTime expiry_date = DateTime.Parse(TextBox16.Text);

            if ((offeramount != 0) && (expiry_date.Year > 2000) && (expiry_date.Month >= 1 && expiry_date.Month <= 12) && (expiry_date.Day >= 1 && expiry_date.Day <= 31))
            {
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@offeramount", offeramount));
                cmd.Parameters.Add(new SqlParameter("@expiry_date", expiry_date));
                //Save the output from the procedure

                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();


            }
        }
        catch (SqlException)

        {
            Response.Write("Please insert correct inputs");
        }
    }

    protected void applyOffer(object sender, EventArgs e)
    {
        try
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("applyOffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string vendorname = (string)(Session["username"]);
            int offerid = int.Parse(TextBox18.Text);
            int serial = int.Parse(TextBox19.Text);


            if ((offerid != 0) && (serial != 0))
            {
                //pass parameters to the stored procedure

                cmd.Parameters.Add(new SqlParameter("@vendorname", vendorname));
                cmd.Parameters.Add(new SqlParameter("@offerid", offerid));
                cmd.Parameters.Add(new SqlParameter("@serial", serial));




                //Executing the SQLCommand
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();


                Response.Write("Passed");

            }
        }
        catch (SqlException)

        {
            Response.Write("Please insert correct inputs");
        }
    }

    protected void checkandremoveExpiredoffer(object sender, EventArgs e)
    {
        try
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("checkandremoveExpiredoffer", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            int offerid = int.Parse(TextBox20.Text);

            if ((offerid != 0))
            {
                //pass parameters to the stored procedure
                cmd.Parameters.Add(new SqlParameter("@offerid", offerid));



                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();

                Response.Write("Passed");

            }
        }
        catch (SqlException)

        {
            Response.Write("Please insert correct input");
        }

    }

}
