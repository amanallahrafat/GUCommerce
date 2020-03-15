using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class chooseCreditCard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string customer_username = (string)(Session["username"]);
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        SqlCommand cmd = new SqlCommand("usersCreditCards", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@customername", customer_username));
        conn.Open();
        SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
        creditList.DataSource = rdr;
        int id = (int)(Session["orderID"]);

    }

    protected void payCredit(object sender, EventArgs e)
    {
        string customer_username = (string)(Session["username"]);
        string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        int id = (int)(Session["orderID"]);
        SqlCommand cmd = new SqlCommand("ChooseCreditCard", conn);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.Add(new SqlParameter("@customername", customer_username));
        cmd.Parameters.Add(new SqlParameter("@orderid", id));
        conn.Open();
        cmd.ExecuteNonQuery();
        conn.Close();

    }
}