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
    public partial class DirectorSelectPerformers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var loggedInUser = User.Identity.Name;
            ValidateUser(loggedInUser);

        }

        /// <summary>
        /// Allow permission for the logged in user
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

                    // LabelAddUser.Text = "";
                    // LabelAddUser.Text = u;

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

        ///end UserVerification

        /// <summary>
        /// Displaying set shows in Green.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void CalendarShowDate_DayRender(object sender, DayRenderEventArgs e)
        {

            bool tentativeshowDate = false;

            // Display Show Scheduled.
            Style ShowExists = new Style();
            ShowExists.BackColor = System.Drawing.Color.Green;
            //ShowExists.BorderColor = System.Drawing.Color.White;
           // ShowExists.BorderWidth = 3;

            //establish an connection to the SQL server 
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            string selectCommand = "SELECT Distinct ScheduleDate, TentativeShow " +
                                    "FROM PerformersAvailable " +
                                    "WHERE PerformersAvailable. TentativeShow = 1";
            SqlCommand command = new SqlCommand(selectCommand, connection);
            connection.Open();
            SqlDataReader reader = null;
            try
            {
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    DateTime dateTime = (DateTime)reader["ScheduleDate"];
                    byte value2 = (byte)reader["TentativeShow"];

                    if (value2 == 1)
                    {
                        tentativeshowDate = true;
                    }


                    // do this somehow
                    if ((e.Day.Date >= new DateTime(dateTime.Year, dateTime.Month, dateTime.Day)) &&
                        (e.Day.Date <= new DateTime(dateTime.Year, dateTime.Month, dateTime.Day)))
                    {
                        if (tentativeshowDate)
                        {
                            e.Cell.ApplyStyle(ShowExists);
                        }


                    }
                }
            }
            catch (Exception ex)
            {
                //LabelError.Text = "Caught Exception " + ex.ToString();
            }
            finally
            {
                reader.Close();
                connection.Close();
            }
        }




        /// <summary>
        /// displaying the available people for the show
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ButtonGetDate_Click(object sender, EventArgs e)
        {
            TextBoxShowDate.Text = TextBoxShowDate.Text;

        }

        /// <summary>
        /// selecting the date of the show on the CalandarShowDate and seeing all
        /// the available performers.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            TextBoxShowDate.Text = CalendarShowDate.SelectedDate.ToString();

        }


        /// <summary>
        /// A way to select performers and add them to the Add Performer List.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ButtonSelectPeople_Click(object sender, EventArgs e)
        {
            LabelAddPerformers.Text = "";
            //Ading to the AspNetUserRoles table
            SqlConnection connectionRemovePerformer = new SqlConnection();
            connectionRemovePerformer.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            string removeCommand = "Delete Shows Where Date = '" + TextBoxShowDate.Text + "'";
            SqlCommand commandRemove = new SqlCommand(removeCommand, connectionRemovePerformer);
            connectionRemovePerformer.Open();
            commandRemove.ExecuteNonQuery();
            connectionRemovePerformer.Close();

            foreach (GridViewRow row in GridViewAvailablePerform.Rows)
            {
                CheckBox checkbox = (CheckBox)row.FindControl("CheckBoxSelectPerformer");
                if (checkbox.Checked)
                {
                    int performerID = Convert.ToInt32(GridViewAvailablePerform.DataKeys[row.RowIndex].Values["PerformerID"]);
                    // Retreive the Performer Name
                    string Performer = (String)(GridViewAvailablePerform.DataKeys[row.RowIndex].Values["PerformerName"]);
                    // Retreive the Employee ID

                    //Ading to the AspNetUserRoles table
                    SqlConnection connectionAddPerformer = new SqlConnection();
                    connectionAddPerformer.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                    string insertCommand = "INSERT INTO Shows (Date, PerformerID) VALUES('" + TextBoxShowDate.Text + "', '" + performerID + "')";
                    SqlCommand commandAdd = new SqlCommand(insertCommand, connectionAddPerformer);
                    connectionAddPerformer.Open();
                    commandAdd.ExecuteNonQuery();
                    connectionAddPerformer.Close();


                    //int PerformerName = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    LabelAddPerformers.Text += Performer + ", " + performerID.ToString() + "<br>";
                }
            }

        }

        protected void ButtonNextPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/CreateShowList");
        }

        protected void ButtonBackPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/DirectorShow");
        }


        




    }
}