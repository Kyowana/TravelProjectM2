using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.UI;
using System.Web.UI.WebControls;
using TravelProject.Managers;
using TravelProject.Models;

namespace TravelProject.BackAdmin
{
    public partial class ArticleList_backadmin : System.Web.UI.Page
    {
        private ArticleManager _mgr = new ArticleManager();
        private static UserAccountModel _nowUser;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                string keyword = this.Request.QueryString["keyword"];
                this.txtkeyword.Text = keyword;

                List<ArticleModel> list = this._mgr.GetAdminArticleList(keyword);
                if (list.Count == 0)
                {
                    this.plcEmpty.Visible = true;
                    this.gvList.Visible = false;
                }
                else
                {
                    this.plcEmpty.Visible = false;
                    this.gvList.Visible = true;

                    this.gvList.DataSource = list;
                    this.gvList.DataBind();
                }
            }
        }
        public void btnDelete_Click(object sender, EventArgs e)
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
                        Guid ArticleID;
                        if (Guid.TryParse(hfID.Value, out ArticleID))
                            idList.Add(ArticleID);
                    }
                }
            }
            if (idList.Count > 0)
            {
                foreach (var articleID in idList)
                {
                    this._mgr.DeleteArticle(articleID);
                }
                this.Response.Redirect(this.Request.RawUrl);

            }

        }
        private void DeleteImage(string imagePath)
        {
            string filePath = HostingEnvironment.MapPath("~/" + imagePath);

            if (System.IO.File.Exists(filePath))
                System.IO.File.Delete(filePath);
        }
        public void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = this.txtkeyword.Text.Trim();

            if (string.IsNullOrWhiteSpace(this.txtkeyword.Text))
                this.Response.Redirect("ArticleList_backadmin.aspx");
            else
                Response.Redirect("ArticleList_backadmin.aspx?keyword=" + keyword);
        }
    }
}