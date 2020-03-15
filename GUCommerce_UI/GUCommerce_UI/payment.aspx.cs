using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class payment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void pay(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("SpecifyAmount", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        string customer_username = (string)(Session["username "]);
        cmd.Parameters.Add(new SqlParameter("@customername", customer_username));
        int id = (int)(Session["orderID"]);
        cmd.Parameters.Add(new SqlParameter("@orderID", id));
        cmd.Parameters.Add(new SqlParameter("@cash", txt_cash.Text));
        cmd.Parameters.Add(new SqlParameter("@credit", txt_credit.Text));

        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();
        int credit = Int32.Parse(txt_credit.Text);
        if(credit > 0)
        {
            Response.Redirect("", true);
        }
        else
        {
            Response.Redirect("", true);
        }
    }
}