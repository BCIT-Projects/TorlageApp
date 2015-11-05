using System;
using System.Collections.Generic;
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

        protected void ListView2_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            
            
        }

        protected void CheckBoxPerformerSelected_CheckedChanged(object sender, EventArgs e)
        {
            ViewState["CheckBox"] = true;
            if (ViewState["CheckBox"] == null)
            {
                ;
            }
            else
            {
                TextBoxAddPerformers.Text = "Changed Text";
            }
        }
    }
}