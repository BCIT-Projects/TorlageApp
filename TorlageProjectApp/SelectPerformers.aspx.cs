using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

//
namespace TorlageProjectApp
{
    public partial class SelectPerformers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ;
            }
            // Looping through all the rows in the GridView
           
        }

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
            ShowExists.BorderColor = System.Drawing.Color.White;
            ShowExists.BorderWidth = 3;

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
            foreach (GridViewRow row in GridViewAvailablePerform.Rows)
            {
                CheckBox checkbox = (CheckBox)row.FindControl("CheckBoxSelectPerformer");
                if (checkbox.Checked)
                {
                    int performerID = Convert.ToInt32(GridViewAvailablePerform.DataKeys[row.RowIndex].Values["PerformerID"]);
                    // Retreive the Performer Name
                    string Performer = (String)(GridViewAvailablePerform.DataKeys[row.RowIndex].Values["PerformerName"]);
                    // Retreive the Employee ID
                    
                    //int PerformerName = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    LabelAddPerformers.Text += Performer + ", "+performerID.ToString() + "<br>";
                }
            }

        }

        protected void ButtonNextPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/CreateShowList");
        }

        protected void ButtonBackPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Director");
        }


        



    }
}