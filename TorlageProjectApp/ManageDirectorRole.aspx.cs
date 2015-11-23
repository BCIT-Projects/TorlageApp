using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TorlageProjectApp
{
    public partial class ManageDirectorRole : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var loggedInUser = User.Identity.Name;
            ValidateUser(loggedInUser);
        }


        private void ValidateUser(string UserName)
        {

            var loggedInUser = User.Identity.Name;
            string constr = ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            con.Open();
            SqlCommand cmd = new SqlCommand("Select  AspNetUsers.Id, UserName, RoleId " +
                                            "From AspNetUsers Left Join AspNetUserRoles " +
                                            "on AspNetUsers.Id = AspNetUserRoles.UserId " +
                                            "Where UserName = '" + UserName +
                                            "'AND (RoleId = 'admin')", con);

            try
            {
                SqlDataReader rd = cmd.ExecuteReader();
                if (rd.Read())
                {
                    //int u = Convert.ToInt32(rd["Id"]);
                    //return u;
                    string u = (String)rd["Id"];

                    LabelAddUser.Text = "";
                    LabelAddUser.Text = u;

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



        protected void ButtonAddDirector_Click(object sender, EventArgs e)
        {
            LabelAddUser.Text = "";
            foreach (GridViewRow row in GridViewAllUsers.Rows)
            {
                CheckBox checkbox = (CheckBox)row.FindControl("CheckBoxUser");
                if (checkbox.Checked)
                {
                    string directorID = (String)(GridViewAllUsers.DataKeys[row.RowIndex].Values["Id"]);
                    // Retreive the Performer Name
                    string director = (String)(GridViewAllUsers.DataKeys[row.RowIndex].Values["UserName"]);



                    SqlConnection cnnSearch = new SqlConnection();
                    cnnSearch.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                    cnnSearch.Open();
                    SqlCommand cmdSearch = new SqlCommand();
                    cmdSearch.CommandText = "SELECT * From AspNetUserRoles WHERE UserId ='" + directorID + "'";
                    cmdSearch.Connection = cnnSearch;
                    try
                    {
                        SqlDataReader rd = cmdSearch.ExecuteReader();
                        if (rd.Read())
                        {
                            LabelAddUser.Text = "Director Allready added";
                        }
                        else
                        {
                            //Ading to the AspNetUserRoles table
                            SqlConnection connectionRole = new SqlConnection();
                            connectionRole.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                            string insertCommand = "INSERT INTO AspNetUserRoles (UserId, RoleId) VALUES('" + directorID + "', 'director')";
                            SqlCommand commandRole = new SqlCommand(insertCommand, connectionRole);
                            connectionRole.Open();
                            commandRole.ExecuteNonQuery();
                            connectionRole.Close();


                           // LabelAddUser.Text = "Director is Now Added";

                        }
                    }
                    finally
                    {
                        cnnSearch.Close();

                    }
                }
            }
            Response.Redirect("~/ManageDirectorRole");
        }


        protected void ButtonRemoveDirector_Click(object sender, EventArgs e)
        {
            LabelAddUser.Text = "";
            foreach (GridViewRow row in GridViewAllUsers.Rows)
            {
                CheckBox checkbox = (CheckBox)row.FindControl("CheckBoxUser");
                if (checkbox.Checked)
                {
                    string directorID = (String)(GridViewAllUsers.DataKeys[row.RowIndex].Values["Id"]);
                    // Retreive the Performer Name
                    string director = (String)(GridViewAllUsers.DataKeys[row.RowIndex].Values["UserName"]);



                    SqlConnection cnnSearch = new SqlConnection();
                    cnnSearch.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                    cnnSearch.Open();
                    SqlCommand cmdSearch = new SqlCommand();
                    cmdSearch.CommandText = "DELETE From AspNetUserRoles WHERE UserId ='" + directorID + "' AND RoleId = 'director'";
                    cmdSearch.Connection = cnnSearch;
                    try
                    {
                        SqlDataReader rd = cmdSearch.ExecuteReader();
                        if (rd.Read())
                        {
                            
                        }
                        else
                        {
                            ;

                            // LabelAddUser.Text = "Director is Now Added";

                        }
                    }
                    finally
                    {
                        cnnSearch.Close();

                    }
                }
            }
            Response.Redirect("~/ManageDirectorRole");
        }


    }
}