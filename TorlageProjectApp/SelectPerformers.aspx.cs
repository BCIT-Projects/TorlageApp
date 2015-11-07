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