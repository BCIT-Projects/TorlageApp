using System;
using System.Collections;
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
    public partial class DirectorShow : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //Session["ExistanceofShow"] = (byte)22;

                ;
            }
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




        /// <summary>
        /// Displaying set shows in green
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
            //ShowExists.BorderWidth = 3;

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
                LabelError.Text = "Caught Exception " + ex.ToString();
            }
            finally
            {
                reader.Close();
                connection.Close();
            }





        }




        /// <summary>
        /// selecting the date of the show on the CalandarShowDate and seeing all
        /// the available performers.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {

            TextBoxSetShowDate.Text = CalendarShowDate.SelectedDate.ToString();
            ButtonSetShow.Visible = true;
            ButtonRemoveSetShow.Visible = true;
            LabelShowOrNoShow.Text = "No Show";
            LabelError.Text = "";
            byte showExists = 0;

            SqlConnection connection = new SqlConnection();   //establish an connection to the SQL server 
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            string selectCommand = "SELECT Distinct TentativeShow FROM PerformersAvailable where ScheduleDate ='" + TextBoxSetShowDate.Text + "'";

            SqlCommand command = new SqlCommand(selectCommand, connection);

            connection.Open();
            SqlDataReader reader = null;
            try
            {
                reader = command.ExecuteReader();
                while (reader.Read())
                {

                    showExists = (byte)reader["TentativeShow"];

                    if (showExists == 1)
                    {
                        LabelShowOrNoShow.Text = "Show is Set";
                        showExists = 0; //reset to no show
                    }
                    else
                    {
                        LabelShowOrNoShow.Text = "No Show";
                    }
                    // Session["ExistanceofShow"] = (int)reader["TentativeShow"];
                    //showExists = (byte)Session["ExistanceofShow"];
                }



            }


            catch (Exception ex)
            {
                ;

            }
            finally
            {
                reader.Close();
                connection.Close();
            }

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ButtonSetShow_Click(object sender, EventArgs e)
        {
            if (TextBoxSetShowDate.Text.ToString() != "")
            {
                SqlConnection connection2 = new SqlConnection();
                connection2.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                string updateCommand = "UPDATE PerformersAvailable " +
                    "SET TentativeShow = 1 " +
                    "FROM PerformersAvailable " +
                    "WHERE ScheduleDate = '" + TextBoxSetShowDate.Text + "'";
                SqlCommand command2 = new SqlCommand(updateCommand, connection2);
                connection2.Open();
                command2.ExecuteNonQuery();
                connection2.Close();
                LabelShowOrNoShow.Text = "Show is Set";



                //---------------Pull out all the performer Names Note might need to change the Name to id
                ArrayList users = new ArrayList();
                ArrayList usersFilled = new ArrayList();
                SqlConnection connection = new SqlConnection();   //establish an connection to the SQL server 
                connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                string selectCommand = "SELECT * FROM Performers WHERE Performers.Active = 1 AND PerformerID NOT IN (select PerformerID from PerformersAvailable where ScheduleDate ='" + TextBoxSetShowDate.Text + "')";
                SqlCommand command = new SqlCommand(selectCommand, connection);

                connection.Open();
                SqlDataReader reader = null;
                try
                {
                    reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        users.Add((int)reader["PerformerId"]);
                        //string value = (string)reader["PerformerName"];
                        //Label1.Text += value;
                    }

                }
                catch (Exception ex)
                {
                    Console.WriteLine("Button Set Show Click Failed");
                }


                finally
                {
                    reader.Close();
                    connection.Close();
                }
                //----------------end of how to pull out the performers' names (or id for future)

                //a way to add a row

                SqlConnection cnn = new SqlConnection();
                cnn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                cnn.Open();
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = "SELECT * From PerformersAvailable Where ScheduleDate = '" + TextBoxSetShowDate.Text + "'";
                cmd.Connection = cnn;
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();
                da.Fill(ds, "PerformersAvailable");
                SqlCommandBuilder cb = new SqlCommandBuilder(da);

                foreach (int entry in users)
                {

                    DataRow drow = ds.Tables["PerformersAvailable"].NewRow();

                    drow["ScheduleDate"] = TextBoxSetShowDate.Text;
                    drow["PerformerID"] = entry;
                    drow["Available"] = "1";
                    drow["TentativeShow"] = "1";
                    ds.Tables["PerformersAvailable"].Rows.Add(drow);
                    da.Update(ds, "PerformersAvailable");


                }
                cnn.Close();

            }
            else
            {
                LabelShowOrNoShow.Text = "Must enter a Date";
                LabelError.Text = "select another date on the calendar \n re-select desired date";
            }
        }

        protected void ButtonRemoveSetShow_Click(object sender, EventArgs e)
        {
            if (TextBoxSetShowDate.Text.ToString() != "")
            {
                SqlConnection connection2 = new SqlConnection();
                connection2.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
                string updateCommand = "UPDATE PerformersAvailable " +
                    "SET TentativeShow = 0 " +
                    "FROM PerformersAvailable " +
                    "WHERE ScheduleDate = '" + TextBoxSetShowDate.Text + "'";
                SqlCommand command2 = new SqlCommand(updateCommand, connection2);
                connection2.Open();
                command2.ExecuteNonQuery();
                connection2.Close();
                LabelShowOrNoShow.Text = "No Show";
            }
            else
            {
                LabelShowOrNoShow.Text = "Must enter a Date";
                LabelError.Text = "Select another date on the calendar \n re-select desired date";
            }
        }


        protected void ButtonNextPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/DirectorSelectPerformers");
        }

        protected void TextBoxSetShowDate_TextChanged(object sender, EventArgs e)
        {
            string test = TextBoxSetShowDate.Text;
            //MessageBox.Show("Hi");

            if (TextBoxSetShowDate.Text == "null")
            {
                ButtonRemoveSetShow.Visible = false;
                ButtonSetShow.Visible = true;
                LabelShowOrNoShow.Text = "";
            }
        }



    }
}