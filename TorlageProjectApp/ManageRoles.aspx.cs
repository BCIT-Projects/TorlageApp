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
    public partial class ManageRoles : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
                                            "'AND (RoleId = 'admin' OR RoleId = 'director')", con);

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

        protected void ButtonAddPerformer_Click(object sender, EventArgs e)
        {
            LabelAddUser.Text = "";
            foreach (GridViewRow row in GridViewAllUsers.Rows)
            {
                CheckBox checkbox = (CheckBox)row.FindControl("CheckBoxUser");
                if (checkbox.Checked)
                {
                    string performerID = (String)(GridViewAllUsers.DataKeys[row.RowIndex].Values["Id"]);
                    // Retreive the Performer Name
                    string performer = (String)(GridViewAllUsers.DataKeys[row.RowIndex].Values["UserName"]);
                    SqlConnection cnn = new SqlConnection();
                    cnn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                    cnn.Open();
                    SqlCommand cmd = new SqlCommand();
                    cmd.CommandText = "SELECT * From Performers ";
                    cmd.Connection = cnn;


                    SqlConnection cnnSearch = new SqlConnection();
                    cnnSearch.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                    cnnSearch.Open();
                    SqlCommand cmdSearch = new SqlCommand();
                    cmdSearch.CommandText = "SELECT * From Performers WHERE LogInUserID ='" + performerID + "'";
                    cmdSearch.Connection = cnnSearch;
                    try
                    {
                        SqlDataReader rd = cmdSearch.ExecuteReader();
                        if (rd.Read())
                        {
                            LabelAddUser.Text = "Performer Allready added";
                        }
                        else
                        {
                            //Ading to the AspNetUserRoles table
                            SqlConnection connectionRole = new SqlConnection();
                            connectionRole.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                            string insertCommand = "INSERT INTO AspNetUserRoles (UserId, RoleId) VALUES('" + performerID + "', 'performer')";
                            SqlCommand commandRole = new SqlCommand(insertCommand, connectionRole);
                            connectionRole.Open();
                            commandRole.ExecuteNonQuery();
                            connectionRole.Close();

                            //Adding to performer table
                            SqlDataAdapter da = new SqlDataAdapter();
                            da.SelectCommand = cmd;
                            DataSet ds = new DataSet();
                            da.Fill(ds, "Performers");
                            SqlCommandBuilder cb = new SqlCommandBuilder(da);
                            DataRow drow = ds.Tables["Performers"].NewRow();
                            drow["PerformerName"] = performer;
                            drow["Active"] = "1";
                            drow["LogInUserID"] = performerID;
                            ds.Tables["Performers"].Rows.Add(drow);
                            da.Update(ds, "Performers");
                            
                            LabelAddUser.Text = "Performer is Now Added";
                            
                        }
                    }
                    finally
                    {
                        cnn.Close();
                        
                    }
                }
            }
            Response.Redirect("~/ManageRoles");
        }





    }
}