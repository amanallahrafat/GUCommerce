using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MakeOrder : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }



    protected void Order(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        string customer_username = (string)(Session["username"]);

        SqlCommand cmd2 = new SqlCommand("viewMyCart", conn);
        cmd2.CommandType = CommandType.StoredProcedure;
        cmd2.Parameters.Add(new SqlParameter("@customer", customer_username));

        conn.Open();
        SqlDataReader rdr = cmd2.ExecuteReader(CommandBehavior.CloseConnection);
        while (rdr.Read())
        {
            string serial = rdr.GetString(rdr.GetOrdinal("serial_no"));
            string product_name = rdr.GetString(rdr.GetOrdinal("product_name"));
            string price = rdr.GetString(rdr.GetOrdinal("price"));
            string final_price = rdr.GetString(rdr.GetOrdinal("final_price"));
            Label product = new Label();
            product.Text = "Serial Number: " + serial + "  name: " + product_name + "  price: " + price + "  final_price: " + final_price + "<br/><br/>";
            Controls.Add(product);
        }

        SqlCommand cmd = new SqlCommand("makeOrder", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@customername", customer_username));

        SqlParameter id = cmd.Parameters.Add("@id", SqlDbType.Int);
        id.Direction = ParameterDirection.Output;
        SqlParameter total_amount = cmd.Parameters.Add("@total_amount", SqlDbType.Int);
        total_amount.Direction = ParameterDirection.Output;




        Session["orderID"] = id;
        //conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

        Label lbl_id = new Label();
        lbl_id.Text = "Order ID: " + id + "<br/>";
        Label lbl_amount = new Label();
        lbl_amount.Text = "Total amount: " + total_amount + "<br/>";
        Controls.Add(lbl_id);
        Controls.Add(lbl_amount);















    }

    protected void payment_amount(object sender, EventArgs e)
    {
        if(paymentType.SelectedValue == "Cash")
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string customer_username = (string)(Session["username"]);
            cmd.Parameters.Add(new SqlParameter("@customername", customer_username));
            int id = (int)(Session["orderID"]);
            cmd.Parameters.Add(new SqlParameter("@orderID", id));
            cmd.Parameters.Add(new SqlParameter("@cash", amount.Text));
            cmd.Parameters.Add(new SqlParameter("@credit",null));
            SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;

            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            this.ckeckSuccess(success);
        }
        else if(paymentType.SelectedValue == "Credit")
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            string customer_username = (string)(Session["username"]);
            cmd.Parameters.Add(new SqlParameter("@customername", customer_username));
            int id = (int)(Session["orderID"]);
            cmd.Parameters.Add(new SqlParameter("@orderID", id));
            cmd.Parameters.Add(new SqlParameter("@cash",null));
            cmd.Parameters.Add(new SqlParameter("@credit", amount.Text));
            SqlParameter success = cmd.Parameters.Add("@success", SqlDbType.Bit);
            success.Direction = ParameterDirection.Output;
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();
            this.ckeckSuccess(success);
            this.chooseCreditCard(success);
        }
        else
        {
            Response.Write("Please, choose the payment type");
        }
    }
    protected void ckeckSuccess(SqlParameter success)
    {
        if (success.Value.Equals(false))
        {
            Response.Write("Your points in not enough");
        }
    }
    protected void chooseCreditCard(SqlParameter success)
    {
        if (success.Value.Equals(true))
        {
            Response.Redirect("chooseCreditCard.aspx", true);
        }

    }
}