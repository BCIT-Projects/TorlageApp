using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace TorlageProjectApp
{
    public partial class CreateShowList : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ButtonNextPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ReviewShowList");
        }

        protected void ButtonBackPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/SelectPerformers");
        }
    }
}