using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ConnectionString;
        using (SqlConnection con = new SqlConnection(connStr)) 
        {
            SqlCommand cmd = new SqlCommand("reviewOrders",con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            con.Open();
            using (SqlDataReader reader = cmd.ExecuteReader())
            {
                GridView1.DataSource = reader;
                GridView1.DataBind();
               
            }
            con.Close();
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

    protected void activae_vendor_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("activateVendors", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        string admin = (string)(Session["username"]);
        string vendor = vendor_name.Text;
        cmd.Parameters.Add(new SqlParameter("@admin_username", admin));
        cmd.Parameters.Add(new SqlParameter("@vendor_username", vendor));

        SqlParameter count = cmd.Parameters.Add("@res", SqlDbType.Int);
        count.Direction = ParameterDirection.Output;

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        if (count.Value.ToString().Equals("1"))
        {
            //To send response data to the client side (HTML)
            Response.Write("Activated Seccussfully");
        }
        else
        {
            Response.Write("The Vendor is Alraedy Activated");
        }

    }

    protected void update_status_Click(object sender, EventArgs e)
    {
        int order = -1;
        if (!Int32.TryParse(order_no.Text, out order))
        {
            Response.Write("ivalid order number , Please Enter order with digits only");
            return;
        }
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("updateOrderStatusInProcess", conn);
        cmd.CommandType = CommandType.StoredProcedure;

        cmd.Parameters.Add(new SqlParameter("@order_no", order));

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        Response.Write("Now, the order is updated");

    }

    protected void createTodaysDeals_Click(object sender, EventArgs e)
    {
        string e_years = year.Text;
        string e_months = month.Text;
        string admin = (string)(Session["username"]);
        int years;
        int months;
        int deal = -1;
        if (!Int32.TryParse(deal_amoount.Text, out deal))
        {
            Response.Write("ivalid order number , Please Enter order with digits only");
            return;
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
            SqlCommand cmd = new SqlCommand("createTodaysDeal", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            string expiry_date = e_years + "-" + e_months + "-";
            if (months == 1 || months == 3 || months == 5 || months == 7 || months == 8 || months == 10 || months == 12)
            { expiry_date += "31"; }
            if (months == 4 || months == 6 || months == 9 || months == 11)
            { expiry_date += "30"; }
            if (months == 2)
            { expiry_date += "28"; }

            cmd.Parameters.Add(new SqlParameter("@admin_username", admin));
            cmd.Parameters.Add(new SqlParameter("@expirydate", expiry_date));
            cmd.Parameters.Add(new SqlParameter("@deal_amount", deal));
            Response.Write("The Deal is added Successfully");
        }

    }

    protected void add_deals_Click(object sender, EventArgs e)
    {
        int deal = -1; int product = -1;
        if ((!Int32.TryParse(dealID.Text, out deal)) || (!Int32.TryParse(p_serial.Text, out product)))
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
            SqlCommand cmd = new SqlCommand("checkTodaysDealOnProduct", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@serial_no", product));

            SqlParameter res = cmd.Parameters.Add("@activeDeal", SqlDbType.Bit);
            res.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();


            if (res.Value.Equals(true))
            {
                Response.Write("the product is already having a deal , try to add the deal to another product");
            }
            else
            {
                SqlCommand cmd1 = new SqlCommand("addTodaysDealOnProduct", conn);
                cmd1.CommandType = CommandType.StoredProcedure;
                cmd1.Parameters.Add(new SqlParameter("@serial_no", product));
                cmd1.Parameters.Add(new SqlParameter("@deal_id", deal));

                SqlParameter res1 = cmd.Parameters.Add("@res", SqlDbType.Bit);
                res1.Direction = ParameterDirection.Output;

                conn.Open();
                cmd1.ExecuteNonQuery();
                conn.Close();

                if (res1.Value.Equals(true))
                {
                    Response.Write("The Deal is added successfully on the assigned product");
                }
                else
                {
                    Response.Write("The product is not exists try add the deal on valid one");
                }
            }

        }

    }

    protected void remove_expired_Click(object sender, EventArgs e)
    {
        int deal = -1;
        if (!Int32.TryParse(expired_deal.Text, out deal))
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
            SqlCommand cmd = new SqlCommand("removeExpiredDeal", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@deal_iD", deal));


            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
                Response.Write("The Deal is removed successfully");

            }
            catch (SqlException)
            {
                Response.Write("The Deal is already removed before ,enter valid deal number");

            }

        }

    }

}

