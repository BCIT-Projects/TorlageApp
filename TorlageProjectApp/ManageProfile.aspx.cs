using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TorlageProjectApp
{
    public partial class ManageProfile : System.Web.UI.Page
    {
        bool available = false;
        string userCurrentlyLoggedIn;
        string userText = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            var loggedInUser = User.Identity.Name;
            ValidateUser(loggedInUser);
            if(!IsPostBack)
            {
                updateTextBox(userText);
            }

        }

        private void ValidateUser(string UserName)
        {

            var loggedInUser = User.Identity.Name;
            string constr = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select  AspNetUsers.Id, UserName, RoleId " +
                                            "From AspNetUsers Left Join AspNetUserRoles " +
                                            "on AspNetUsers.Id = AspNetUserRoles.UserId " +
                                            "Where UserName = '" + UserName +
                                            "'AND (RoleId = 'performer')", con);

            try
            {
                SqlDataReader rd = cmd.ExecuteReader();
                if (rd.Read())
                {
                    //int u = Convert.ToInt32(rd["Id"]);
                    //return u;
                    string u = (String)rd["Id"];
                    userText = u;

                }
                else
                {
                    Response.Redirect("~/");
                }
            }
            finally
            {
                con.Close();
            }
        }

        protected void updateTextBox(string username)
        {
            //establish an connection to the SQL server 
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            string selectCommand = "SELECT * " +
                "FROM Performers " +
                "WHERE Performers.LogInUserID = '" + username + "'";
            SqlCommand command = new SqlCommand(selectCommand, connection);
            connection.Open();
            SqlDataReader reader = null;
            try
            {
                reader = command.ExecuteReader();


                while (reader.Read())
                {
                    string value = (string)reader["PerformerName"];
                    userCurrentlyLoggedIn = value;
                    Name.Text = value;
                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Caught Exception " + ex.ToString());
            }
            finally
            {
                reader.Close();
                connection.Close();
            }
        }

        protected void ChangeName(object sender, EventArgs e)
        {
            var loggedInUser = User.Identity.Name;
            var loggedInUserID = "";
            string constr = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select  AspNetUsers.Id, UserName, RoleId " +
                                            "From AspNetUsers Left Join AspNetUserRoles " +
                                            "on AspNetUsers.Id = AspNetUserRoles.UserId " +
                                            "Where UserName = '" + loggedInUser +
                                            "'AND (RoleId = 'performer')", con);

            try
            {
                SqlDataReader rd = cmd.ExecuteReader();
                if (rd.Read())
                {
                    //int u = Convert.ToInt32(rd["Id"]);
                    //return u;
                    string u = (String)rd["Id"];
                    loggedInUserID = u;

                }
                else
                {
                    Response.Redirect("~/");
                }
            }
            finally
            {
                con.Close();
            }


            //establish an connection to the SQL server 
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            string selectCommand = "UPDATE Performers " +
                "SET PerformerName=" + "'" + Name.Text + "' " +
                "WHERE Performers.LogInUserID = '" + loggedInUserID + "'";
            SqlCommand command = new SqlCommand(selectCommand, connection);
            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();
        }
    }
}