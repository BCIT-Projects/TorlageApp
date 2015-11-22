using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;

namespace TorlageProjectApp.Roles
{
    public partial class ManageRoles : System.Web.UI.Page
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
                                                "'AND (RoleId = 'admin' OR RoleId = 'director')", con);
             
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
                    cmd.CommandText = "SELECT * From Performers";
                    cmd.Connection = cnn;
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
                    
                    cnn.Close();
                













                    //int PerformerName = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    LabelAddUser.Text += performer + ", " + performerID.ToString() + "<br>";
                }
            }
        }
    }
}