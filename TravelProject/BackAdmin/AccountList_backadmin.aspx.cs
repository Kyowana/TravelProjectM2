using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TravelProject.Managers;
using TravelProject.Models;

namespace TravelProject.BackAdmin
{
    public partial class AccountList_backadmin : System.Web.UI.Page
    {
        private AccountManager _mgr = new AccountManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                List<UserAccountModel> list = _mgr.GetAccountList();
                if (list.Count > 0)
                {
                    this.gvList.DataSource = list;
                    this.gvList.DataBind();
                    this.gvList.Visible = true;
                }
            }
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            List<Guid> idList = new List<Guid>();
            foreach (GridViewRow gRow in this.gvList.Rows)
            {
                CheckBox chkdel = gRow.FindControl("chkdel") as CheckBox;
                HiddenField hfID = gRow.FindControl("hfID") as HiddenField;

                if (chkdel != null && hfID != null)
                {
                    if (chkdel.Checked)
                    {
                        Guid UserID;
                        if (Guid.TryParse(hfID.Value, out UserID))
                            idList.Add(UserID);
                    }
                }
            }
            if (idList.Count > 0)
            {
                this._mgr.DeleteAccounts(idList);
                this.Response.Redirect(this.Request.RawUrl);
            }
        }
    }
}