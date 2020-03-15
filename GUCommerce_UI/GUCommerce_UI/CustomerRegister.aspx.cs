using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CustomerRegister : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void cutomer_reg(object sender, EventArgs e)
    {
        try
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("customerRegister", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = username_txt.Text;
            string password = pass_txt.Text;
            string fname = fname_txt.Text;
            string lname = lname_txt.Text;
            string email = email_txt.Text;
            if (String.IsNullOrEmpty(username) || String.IsNullOrEmpty(password) || String.IsNullOrEmpty(fname) || String.IsNullOrEmpty(lname) || String.IsNullOrEmpty(email))
            {
                Response.Write("Please, enter all the fields");
            }
            else
            {
                cmd.Parameters.Add(new SqlParameter("@username", username));
                cmd.Parameters.Add(new SqlParameter("@password", password));
                cmd.Parameters.Add(new SqlParameter("@first_name", fname));
                cmd.Parameters.Add(new SqlParameter("@last_name", lname));
                cmd.Parameters.Add(new SqlParameter("@email", email));
                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
        catch (ArgumentNullException ex)
        {

        }
    }
}