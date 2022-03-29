using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TravelProject.Managers;
using TravelProject.Models;

namespace TravelProject
{
    public partial class FrountMain : System.Web.UI.MasterPage
    {
        private NotifyManager _nfMgr = new NotifyManager();
        private static UserAccountModel _user;
        protected void Page_Init(object sender, EventArgs e)
        {
            if (!new AccountManager().IsLogin())
                Response.Redirect("Login.aspx", true);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            _user = HttpContext.Current.Session["UserAccount"] as UserAccountModel;
            this.userPage.HRef = "UserPage.aspx?User=" + _user.Account;
            this.collectionPage.HRef = "Collection.aspx";
            InitNotifyBox();
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            new AccountManager().Logout();
            Response.Redirect("login.aspx");
        }

        protected void btnNotify_Click(object sender, EventArgs e)
        {
            if (pnlNotify.Visible)
                this.pnlNotify.Visible = false;
            else
            {
                this.pnlNotify.Visible = true;
                _nfMgr.ViewedNotify(_user.UserID);
            }
        }
        private void InitNotifyBox()
        {
            List<NoticeModel> notifyList = _nfMgr.GetNotifyList(_user.UserID);
            if (notifyList.Count > 0)
            {
                this.ltlNoNotify.Visible = false;
                this.rptNotify.DataSource = notifyList;
                this.rptNotify.DataBind();
                int notifyCount = 0;
                foreach (NoticeModel notify in notifyList)
                {
                    if (!notify.IsViewed)
                        notifyCount++;
                }
                this.btnNotify.Text = $"通知({notifyCount})";
            }
            else
                this.ltlNoNotify.Visible = true;

        }
    }
}