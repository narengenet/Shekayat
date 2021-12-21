using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Shekayat
{
    public partial class discontentresult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["recorded"] = -1;
            lblToken.Text = Session["threadfixedtoken"].ToString().ToUpper();
        }
    }
}