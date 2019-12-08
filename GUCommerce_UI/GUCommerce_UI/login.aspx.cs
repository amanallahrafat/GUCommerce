using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GUCommerce_UI
{
    public partial class login : System.Web.UI.Page
    {
        private object txt_username;
        private object txt_password;

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void user_login(object sender, EventArgs e)
        {
            //Get the information of the connection to the database
            string connStr = ConfigurationManager.ConnectionStrings["MyDbConn"].ToString();

            //create a new connection
            SqlConnection conn = new SqlConnection(connStr);

            /*create a new SQL command which takes as parameters the name of the stored procedure and
             the SQLconnection name*/
            SqlCommand cmd = new SqlCommand("userLogin", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            //To read the input from the user
            string username = username_textbox.Text;
            string password = password_textbox.Text;

            //pass parameters to the stored procedure
            cmd.Parameters.Add(new SqlParameter("@username", username));
            cmd.Parameters.Add(new SqlParameter("@password", password));

            //Save the output from the procedure
            SqlParameter count = cmd.Parameters.Add("@success", SqlDbType.Bit);
            cmd.Parameters.Add("@type", SqlDbType.Int).Direction = ParameterDirection.Output;
            count.Direction = ParameterDirection.Output;

            //Executing the SQLCommand
            conn.Open();
            cmd.ExecuteNonQuery();
            conn.Close();

            if (count.Value.Equals(true))
            {
                //To send response data to the client side (HTML)
                Response.Write("Passed");

                /*ASP.NET session state enables you to store and retrieve values for a user
                as the user navigates ASP.NET pages in a Web application.
                This is how we store a value in the session*/
                //Session["field1"] = "HIIII";

                //To navigate to another webpage
                //Response.Redirect("Companies.aspx", true);

            }
            else
            {
                Response.Write("Failed");
            }


        }
    }
}