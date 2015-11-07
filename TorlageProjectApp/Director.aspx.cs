using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TorlageProjectApp
{
    public partial class Director : System.Web.UI.Page
    {

        protected void CalendarShowDate_DayRender(object sender, DayRenderEventArgs e)
        {
            // Display vacation dates in yellow boxes with purple borders.
            Style ShowDateStyle = new Style();
            ShowDateStyle.BackColor = System.Drawing.Color.Green;
            ShowDateStyle.BorderColor = System.Drawing.Color.White;
            ShowDateStyle.BorderWidth = 3;
            DateTime myDate = new DateTime(2015, 11, 10);
            if (e.Day.Date == new DateTime(myDate.Year, myDate.Month, myDate.Day))
            {
                e.Cell.ApplyStyle(ShowDateStyle);
            }

            /*
            ArrayList showDates = new ArrayList();
            DateTime myDate = new DateTime(2015,11,10);
            
            

            SqlConnection connection = new SqlConnection();   //establish an connection to the SQL server 
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            string selectCommand = "SELECT Distinct ScheduleDate FROM PerformersAvailable where TentativeShow = 1";

            SqlCommand command = new SqlCommand(selectCommand, connection);

            connection.Open();
            SqlDataReader reader = null;
            try
            {
                reader = command.ExecuteReader();
                while (reader.Read())
                {

//                    DateTime date1;
                    //myDate = reader.GetDateTime(1);
                    //DateTime.TryParse((string)reader["SheduleDate"], out myDate);
                   // myDate = (DateTime)reader["SheduleDate"];
//                    showDates.Add((DateTime)reader["SheduleDate"]);

                    if (e.Day.Date == new DateTime(myDate.Year, myDate.Month, myDate.Day))
                    {
                        e.Cell.ApplyStyle(vacationStyle);
                    }
                    reader.Close();
                    connection.Close();
                }

            }


            catch (Exception ex)
            {
                LabelShowOrNoShow.Text = "asdkfaldskflsdf";
                

            }

            
            foreach (DateTime entry in showDates)
            {
                
                    e.Cell.ApplyStyle(vacationStyle);
            }
            */


        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                //Session["ExistanceofShow"] = (byte)22;
               
                    ;
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
            LabelShowOrNoShow.Text = "No Show";
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
                        LabelShowOrNoShow.Text = "Is a Show";
                        showExists = 0; //reset to no show
                    }
                    else
                    {
                        LabelShowOrNoShow.Text = "No Show";
                    }
                    // Session["ExistanceofShow"] = (int)reader["TentativeShow"];
                    //showExists = (byte)Session["ExistanceofShow"];
                }

                reader.Close();
                connection.Close();

            }


            catch (Exception ex)
            {
                ;

            }

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ButtonSetShow_Click(object sender, EventArgs e)
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
            LabelShowOrNoShow.Text = "Is A Show";



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

               

            reader.Close();
            connection.Close();
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

        protected void ButtonRemoveSetShow_Click(object sender, EventArgs e)
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
            LabelShowOrNoShow.Text = "Not A Show";
        }


        protected void ButtonNextPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/SelectPerformers");
        }

    }
}