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
    public partial class SelectPerformerTest : System.Web.UI.Page
    {
        public ArrayList row = new ArrayList();
        public ArrayList performers = new ArrayList();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                /*if (Application["AvailableID"] == null)
                {
                    Application.Add("AvailableID", 300);
                }
                */
            }
        }

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
            TextBoxSetShowDate.Text = CalendarShowDate.SelectedDate.ToString();
        }

        protected void ButtonSelectPeople_Click(object sender, EventArgs e)
        {
            TextBoxAddPerformers.Text = "";
            foreach (GridViewRow row in GridView1.Rows)
            {
                CheckBox checkbox = (CheckBox)row.FindControl("CheckBoxSelectPerformer");
                if (checkbox.Checked)
                {
                    // Retreive the Performer Name
                    string Performer = (String)GridView1.DataKeys[row.RowIndex].Value;
                    //int PerformerName = Convert.ToInt32(GridView1.DataKeys[row.RowIndex].Value);
                    TextBoxAddPerformers.Text += Performer + ", " + "\r\n";
                }
            }

        }

        protected void ButtonSetShow_Click(object sender, EventArgs e)
        {


            //---------------Pull out all the performer Names Note might need to change the Name to id
            ArrayList users = new ArrayList();
            ArrayList usersFilled = new ArrayList();
            SqlConnection connection = new SqlConnection();   //establish an connection to the SQL server 
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TConnectionString"].ConnectionString;
            string selectCommand = "SELECT * FROM PerformersAvailable Where ScheduleDate = '" + TextBoxSetShowDate.Text +"'";
            string selectCommandFilled = "SELECT * FROM PerformersAvailable Where ScheduleDate = '" + TextBoxSetShowDate.Text + "'";
            SqlCommand command = new SqlCommand(selectCommand, connection);
            SqlCommand commandFilled = new SqlCommand(selectCommandFilled, connection);
            connection.Open();
            SqlDataReader reader = null;
            try
            {
                reader = command.ExecuteReader();
                    while (reader.Read())
                    {
                        users.Add((String)reader["PerformerName"]);
                        //string value = (string)reader["PerformerName"];
                        //Label1.Text += value;
                    }
                    reader = commandFilled.ExecuteReader();
                    while (reader.Read())
                    {
                        usersFilled.Add((String)reader["PerformerName"]);
                    }
            }
            catch (Exception ex)
            {
                reader.Close();
                connection.Close();
                Label1.Text = "caught Exception";
            }
            
            foreach (string entry in users)
            {
                Label1.Text += entry + ", ";
            }


            //----------------end of how to pull out the performers' names (or id for future)

            //a way to add a row
            SqlConnection cnn = new SqlConnection();
            cnn.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["TConnectionString"].ConnectionString;
            cnn.Open();
            SqlCommand cmd = new SqlCommand();
            cmd.CommandText = "SELECT * From PerformersAvailable Where ScheduleDate = '" + TextBoxSetShowDate.Text + "'";
            cmd.Connection = cnn;
            SqlDataAdapter da = new SqlDataAdapter();
            da.SelectCommand = cmd;
            DataSet ds = new DataSet();
            da.Fill(ds, "PerformersAvailable");
            SqlCommandBuilder cb = new SqlCommandBuilder(da);

            foreach (string entry in users)
            {
                if (entry.CompareTo("NadiaNight") != 0)
                {
                    DataRow drow = ds.Tables["PerformersAvailable"].NewRow();
                    drow["ScheduleDate"] = TextBoxSetShowDate.Text;
                    drow["PerformerName"] = entry;
                    drow["Available"] = "1";
                    ds.Tables["PerformersAvailable"].Rows.Add(drow);
                    da.Update(ds, "PerformersAvailable");
                }
            }
            cnn.Close();
        }
    }
}