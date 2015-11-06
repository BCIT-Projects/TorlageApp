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
            TextBoxSetShowDate.Text = CalendarShowDate.SelectedDate.ToString();
        }


        /// <summary>
        /// A way to select performers and add them to the Add Performer List.
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
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


        /// <summary>
        /// 
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void ButtonSetShow_Click(object sender, EventArgs e)
        {


            //---------------Pull out all the performer Names Note might need to change the Name to id
            ArrayList users = new ArrayList();
            ArrayList usersFilled = new ArrayList();
            SqlConnection connection = new SqlConnection();   //establish an connection to the SQL server 
            connection.ConnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ToConnectionString"].ConnectionString;
            string selectCommand = "SELECT * FROM Performers WHERE Performers.Active = 1 AND NOT Exists(select PerformerID from PerformersAvailable where ScheduleDate ='" + TextBoxSetShowDate.Text + "')";
           
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
                reader.Close();
                connection.Close();
                Label1.Text = "caught Exception";
            }

            foreach (int entry in users)
            {
                Label1.Text += entry + ", ";
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




    }
}