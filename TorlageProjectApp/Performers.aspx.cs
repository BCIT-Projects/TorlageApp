using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TorlageProjectApp
{
    public partial class Performers : System.Web.UI.Page
    {
        bool available = false;
        int userCurrentlyLoggedIn;

        protected void Page_Load(object sender, EventArgs e)
        {
            var loggedInUser = User.Identity.Name;
            ValidateUser(loggedInUser);


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
                    updateTextBox(u);

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
                    int value = (int)reader["PerformerID"];
                    userCurrentlyLoggedIn = value;
                }

            }
            catch (Exception ex)
            {
                LabelUserAlreadyClickedAvailability.Text = "Caught Exception " + ex.ToString();
            }
            finally
            {
                reader.Close();
                connection.Close();
            }
        }

        protected void CalendarChangeAvailability_SelectionChanged(object sender, EventArgs e)
        {

            TextBoxChangeAvailability.Text = CalendarChanageAvailability.SelectedDate.ToShortDateString();
            LabelUserAlreadyClickedAvailability.Text = "";
            //establish an connection to the SQL server 
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            string selectCommand = "SELECT PerformersAvailable.AvailableID, Performers.PerformerName, PerformersAvailable.ScheduleDate, " +
                "PerformersAvailable.Available " +
                "FROM PerformersAvailable " +
                "INNER JOIN Performers " +
                "ON PerformersAvailable.PerformerID = Performers.PerformerID " +
                "WHERE PerformersAvailable.ScheduleDate = '" + TextBoxChangeAvailability.Text + "' And Performers.PerformerID = '"
                + userCurrentlyLoggedIn + "'";
            SqlCommand command = new SqlCommand(selectCommand, connection);
            connection.Open();
            SqlDataReader reader = null;
            try
            {
                reader = command.ExecuteReader();


                while (reader.Read())
                {
                    byte value = (byte)reader["Available"];
                    if (value == 1)
                    {
                        //LabelUserAlreadyClickedAvailability.Text = "You already entered that you were available. Are you available?";
                    }
                    else
                    {
                        //LabelUserAlreadyClickedAvailability.Text = "You already entered that you were not available. Are you available?";
                    }
                }

            }
            catch (Exception ex)
            {
                LabelUserAlreadyClickedAvailability.Text = "Caught Exception " + ex.ToString();
            }
            finally
            {
                reader.Close();
                connection.Close();
            }
        }

        protected void ButtonYes_Click(object sender, EventArgs e)
        {
            bool foundRecordOnDate = false;
            TextBoxChangeAvailability.Text = CalendarChanageAvailability.SelectedDate.ToString();

            // need to find if record exists
            //establish an connection to the SQL server 
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            string selectCommand = "SELECT PerformersAvailable.AvailableID, Performers.PerformerName, PerformersAvailable.ScheduleDate, " +
                "PerformersAvailable.Available " +
                "FROM PerformersAvailable " +
                "INNER JOIN Performers " +
                "ON PerformersAvailable.PerformerID = Performers.PerformerID " +
                "WHERE PerformersAvailable.ScheduleDate = '" + TextBoxChangeAvailability.Text + "' And Performers.PerformerID = '"
                + userCurrentlyLoggedIn + "'";
            SqlCommand command = new SqlCommand(selectCommand, connection);
            connection.Open();
            SqlDataReader reader = null;
            try
            {
                reader = command.ExecuteReader();


                while (reader.Read())
                {
                    foundRecordOnDate = true;
                    byte value = (byte)reader["Available"];
                    if (value == 1)
                    {
                        available = true;
                    }
                    else
                    {
                        available = false;
                    }
                }

            }
            catch (Exception ex)
            {
                LabelUserAlreadyClickedAvailability.Text = "Caught Exception " + ex.ToString();
            }
            finally
            {
                reader.Close();
                connection.Close();
            }

            if (foundRecordOnDate && !available)
            {
                // do update of record

                //establish an connection to the SQL server 
                SqlConnection connection2 = new SqlConnection();
                connection2.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                string updateCommand = "UPDATE PerformersAvailable " +
                    "SET PerformersAvailable.Available = 1 " +
                    "FROM PerformersAvailable " +
                    "INNER JOIN Performers " +
                    "ON PerformersAvailable.PerformerID = Performers.PerformerID " +
                    "WHERE ScheduleDate = '" + TextBoxChangeAvailability.Text + "' AND Performers.PerformerID = '"
                    + userCurrentlyLoggedIn + "'";
                SqlCommand command2 = new SqlCommand(updateCommand, connection2);
                connection2.Open();
                command2.ExecuteNonQuery();
                connection2.Close();

            }
            else if (!foundRecordOnDate)
            {
                // do insert of the record

                //establish an connection to the SQL server 
                SqlConnection connection4 = new SqlConnection();
                connection4.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                string selectQueryForUserName = "(SELECT PerformerID FROM Performers WHERE PerformerID = '" + userCurrentlyLoggedIn + "'  AND Performers.Active = 1)";
                string insertCommand = "INSERT INTO PerformersAvailable (ScheduleDate, PerformerID, Available, TentativeShow) VALUES('" + TextBoxChangeAvailability.Text + "', "
                    + selectQueryForUserName + ", 1, 0)";
                SqlCommand command4 = new SqlCommand(insertCommand, connection4);
                connection4.Open();
                command4.ExecuteNonQuery();
                connection4.Close();
            }

            //LabelUserAlreadyClickedAvailability.Text = "You entered that you were available. Are you available?";
        }

        protected void ButtonNo_Click(object sender, EventArgs e)
        {
            bool foundRecordOnDate = false;
            TextBoxChangeAvailability.Text = CalendarChanageAvailability.SelectedDate.ToString();

            // need to find if record exists
            //establish an connection to the SQL server 
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            string selectCommand = "SELECT PerformersAvailable.AvailableID, Performers.PerformerName, PerformersAvailable.ScheduleDate, " +
                "PerformersAvailable.Available " +
                "FROM PerformersAvailable " +
                "INNER JOIN Performers " +
                "ON PerformersAvailable.PerformerID = Performers.PerformerID " +
                "WHERE PerformersAvailable.ScheduleDate = '" + TextBoxChangeAvailability.Text + "' And Performers.PerformerID = '"
                + userCurrentlyLoggedIn + "'";
            SqlCommand command = new SqlCommand(selectCommand, connection);
            connection.Open();
            SqlDataReader reader = null;
            try
            {
                reader = command.ExecuteReader();


                while (reader.Read())
                {
                    foundRecordOnDate = true;
                    byte value = (byte)reader["Available"];
                    if (value == 1)
                    {
                        available = true;
                    }
                    else
                    {
                        available = false;
                    }
                }

            }
            catch (Exception ex)
            {
                LabelUserAlreadyClickedAvailability.Text = "Caught Exception " + ex.ToString();
            }

            finally
            {
                reader.Close();
                connection.Close();
            }

            if (foundRecordOnDate && available)
            {
                // do update of record

                //establish an connection to the SQL server 
                SqlConnection connection2 = new SqlConnection();
                connection2.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                string updateCommand = "UPDATE PerformersAvailable " +
                    "SET PerformersAvailable.Available = 0 " +
                    "FROM PerformersAvailable " +
                    "INNER JOIN Performers " +
                    "ON PerformersAvailable.PerformerID = Performers.PerformerID " +
                    "WHERE ScheduleDate = '" + TextBoxChangeAvailability.Text + "' AND Performers.PerformerID = '"
                    + userCurrentlyLoggedIn + "'";
                SqlCommand command2 = new SqlCommand(updateCommand, connection2);
                connection2.Open();
                command2.ExecuteNonQuery();
                connection2.Close();

            }
            else if (!foundRecordOnDate)
            {
                // do insert of the record

                //establish an connection to the SQL server 
                SqlConnection connection4 = new SqlConnection();
                connection4.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                string selectQueryForUserName = "(SELECT PerformerID FROM Performers WHERE PerformerID = '" + userCurrentlyLoggedIn + "' AND Performers.Active = 1)";
                string insertCommand = "INSERT INTO PerformersAvailable (ScheduleDate, PerformerID, Available, TentativeShow) VALUES('" + TextBoxChangeAvailability.Text + "', "
                    + selectQueryForUserName + ", 0, 0)";
                SqlCommand command4 = new SqlCommand(insertCommand, connection4);
                connection4.Open();
                command4.ExecuteNonQuery();
                connection4.Close();
            }

            //LabelUserAlreadyClickedAvailability.Text = "You entered that you were not available. Are you available?";

        }

        protected void CalendarChanageAvailability_DayRender(object sender, DayRenderEventArgs e)
        {
            bool availability = false;
            bool tentativeshowDate = false;

            // Display not available in red
            Style notavailableStyle = new Style();
            notavailableStyle.BackColor = System.Drawing.Color.Red;

            // Display available days in green
            Style availableStyle = new Style();
            availableStyle.BackColor = System.Drawing.Color.Green;

            // Display a blue border for the tentativeshowdate
            Style showdateStyle = new Style();
            showdateStyle.BorderColor = System.Drawing.Color.Blue;
            showdateStyle.BorderWidth = 6;


            //establish an connection to the SQL server 
            SqlConnection connection = new SqlConnection();
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            string selectCommand = "SELECT PerformersAvailable.AvailableID, Performers.PerformerName, PerformersAvailable.ScheduleDate, " +
                "PerformersAvailable.Available, PerformersAvailable.TentativeShow " +
                "FROM PerformersAvailable " +
                "INNER JOIN Performers " +
                "ON PerformersAvailable.PerformerID = Performers.PerformerID " +
                "WHERE Performers.PerformerID = '"
                + userCurrentlyLoggedIn + "'";
            SqlCommand command = new SqlCommand(selectCommand, connection);
            connection.Open();
            SqlDataReader reader = null;
            try
            {
                reader = command.ExecuteReader();


                while (reader.Read())
                {
                    DateTime dateTime = (DateTime)reader["ScheduleDate"];
                    byte value = (byte)reader["Available"];
                    byte value2 = (byte)reader["TentativeShow"];
                    if (value == 1)
                    {
                        availability = true;
                    }
                    else
                    {
                        availability = false;
                    }

                    if (value2 == 1)
                    {
                        tentativeshowDate = true;
                    }
                    else
                    {
                        tentativeshowDate = false;
                    }

                    // do this somehow
                    if ((e.Day.Date >= new DateTime(dateTime.Year, dateTime.Month, dateTime.Day)) &&
                        (e.Day.Date <= new DateTime(dateTime.Year, dateTime.Month, dateTime.Day)))
                    {
                        if (availability)
                        {
                            e.Cell.ApplyStyle(availableStyle);
                        }
                        else if (!availability)
                        {
                            e.Cell.ApplyStyle(notavailableStyle);
                        }
                        if (tentativeshowDate)
                        {
                            e.Cell.ApplyStyle(showdateStyle);
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                LabelUserAlreadyClickedAvailability.Text = "Caught Exception " + ex.ToString();
            }
            finally
            {
                reader.Close();
                connection.Close();
            }
        }
    }

}