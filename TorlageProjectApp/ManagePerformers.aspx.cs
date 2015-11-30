using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TorlageProjectApp
{
    public partial class ManagePerformers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LabelAddUser.Text = "";
            var loggedInUser = User.Identity.Name;
            ValidateUser(loggedInUser);
        }


        /// <summary>
        /// See if the logged in user is the correct role
        /// </summary>
        /// <param name="UserName"></param>
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
                                            "'AND (RoleId = 'director')", con);

            try
            {
                SqlDataReader rd = cmd.ExecuteReader();
                if (rd.Read())
                {
                    //int u = Convert.ToInt32(rd["Id"]);
                    //return u;
                    string u = (String)rd["Id"];

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
        ///end Validate User

        protected void ButtonActivePerformer_Click(object sender, EventArgs e)
        {
            LabelAddUser.Text = "";
            foreach (GridViewRow row in GridViewAllUsers.Rows)
            {
                CheckBox checkbox = (CheckBox)row.FindControl("CheckBoxUser");
                if (checkbox.Checked)
                {
                    int performerID = Convert.ToInt32((GridViewAllUsers.DataKeys[row.RowIndex].Values["PerformerID"]));
                    // Retreive the Performer Name
                    string performer = (String)(GridViewAllUsers.DataKeys[row.RowIndex].Values["PerformerName"]);



                    SqlConnection connection2 = new SqlConnection();
                    connection2.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                    string updateCommand = "Update Performers SET Active = 1 WHERE PerformerID ='" + performerID + "'";
                    SqlCommand command2 = new SqlCommand(updateCommand, connection2);
                    connection2.Open();
                    command2.ExecuteNonQuery();
                    connection2.Close();

   
                }
            }
            Response.Redirect("~/ManagePerformers");
        }
        ///end button Active Performer Click



        protected void ButtonNotActivePerformer_Click(object sender, EventArgs e)
        {
            LabelAddUser.Text = "";
            foreach (GridViewRow row in GridViewAllUsers.Rows)
            {
                CheckBox checkbox = (CheckBox)row.FindControl("CheckBoxUser");
                if (checkbox.Checked)
                {
                    int performerID = Convert.ToInt32((GridViewAllUsers.DataKeys[row.RowIndex].Values["PerformerID"]));
                    // Retreive the Performer Name
                    string performer = (String)(GridViewAllUsers.DataKeys[row.RowIndex].Values["PerformerName"]);



                    SqlConnection connection2 = new SqlConnection();
                    connection2.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                    string updateCommand = "Update Performers SET Active = 0 WHERE PerformerID ='" + performerID + "'";
                    SqlCommand command2 = new SqlCommand(updateCommand, connection2);
                    connection2.Open();
                    command2.ExecuteNonQuery();
                    connection2.Close();




                    
                }
            }
            Response.Redirect("~/ManagePerformers");
        }
        ///end button Not Active Performer Click

    }
}