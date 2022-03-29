using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TravelProject.Models;
using TravelProject.Managers;

namespace TravelProject
{
    public partial class MyPage : System.Web.UI.Page
    {
        private ArticleManager _mgr = new ArticleManager();
        private AccountManager _AccMgr = new AccountManager();
        private UserActiveManager _uaMgr = new UserActiveManager(); 
        private MemberPageBase _mpB = new MemberPageBase();
        private static UserAccountModel _nowUser;
        private static UserAccountModel _pageOwner;
        protected void Page_Load(object sender, EventArgs e)
        {
            string ownerAccount = this.Request.QueryString["User"];
            if (!string.IsNullOrWhiteSpace(ownerAccount))
            {
                _pageOwner = _AccMgr.GetAccount(ownerAccount);
                if (_pageOwner != null)
                {
                    _nowUser = HttpContext.Current.Session["UserAccount"] as UserAccountModel;
                    this.ltlUserAcc.Text = ownerAccount;
                    this.ltlNickName.Text = _pageOwner.NickName;
                    this.ltlProfileContent.Text = _pageOwner.ProfileContent;
                    if (!IsPostBack)
                    {
                        InitArticle(_pageOwner.UserID);
                        InitFollower(_pageOwner.UserID);
                        if (_pageOwner.UserID == _nowUser.UserID)
                            InitMyPage();
                        else
                            InitGuestMode(_nowUser.UserID, _pageOwner.UserID);
                    }
                }
                else
                    Response.Redirect("index.aspx");
            }
            else
                Response.Redirect("index.aspx");

        }

        protected void btnFollow_Click(object sender, EventArgs e)
        {
            if (!_uaMgr.isFollowed(_nowUser.UserID, _pageOwner.UserID))
                _uaMgr.PressFollow(_nowUser.UserID, _pageOwner.UserID);
            else
                _uaMgr.UnFollow(_nowUser.UserID, _pageOwner.UserID);

            InitGuestMode(_nowUser.UserID, _pageOwner.UserID);
            InitFollower(_pageOwner.UserID);
        }
        private void InitFollower(Guid UserID)
        {
            List<UserAccountModel> followingList = _uaMgr.GetFollowingList(UserID);
            this.lkbFollowingCount.Text = followingList.Count.ToString();
            this.rptFollowing.DataSource = followingList;
            this.rptFollowing.DataBind();
            foreach (RepeaterItem item in this.rptFollowing.Items)
            {
                GetBtnList(item);
            }

            List<UserAccountModel> fansList = _uaMgr.GetFansList(UserID);
            this.lkbFansCount.Text = fansList.Count.ToString();
            this.rptFans.DataSource = fansList;
            this.rptFans.DataBind();
            foreach (RepeaterItem item in this.rptFans.Items)
            {
                GetBtnList(item);
            }
        }

        private void GetBtnList(RepeaterItem item)
        {
            HiddenField hfAcc = item.FindControl("hfFollowAcc") as HiddenField;
            Button btnFollow = item.FindControl("buttonFollow") as Button;
            Button btnUnFollow = item.FindControl("buttonUnFollow") as Button;
            if (hfAcc != null)
            {
                UserAccountModel listUser = _AccMgr.GetAccount(hfAcc.Value);
                if (listUser != null)
                {
                    if (_nowUser.UserID == listUser.UserID)
                    {
                        btnFollow.Visible = false;
                        btnUnFollow.Visible = false;
                    }
                    else if (_uaMgr.isFollowed(_nowUser.UserID, listUser.UserID))
                    {
                        btnFollow.Visible = false;
                        btnUnFollow.Visible = true;
                    }
                    else
                    {
                        btnFollow.Visible = true;
                        btnUnFollow.Visible = false;
                    }
                }
            }
        }

        private void InitArticle(Guid UserID)
        {
            List<ArticleModel> articleList = _mgr.GetArticleList(UserID);
            List<ArticleModel> canViewArticleList = new List<ArticleModel>();
            foreach (ArticleModel article in articleList)
            {
                ArticleViewLimitEnum limitEnum = _mpB.GetFollowerViewLimit(article.ArticleID);

                if (article.ViewLimit == ArticleViewLimitEnum.Public || limitEnum == article.ViewLimit || _nowUser.UserID == article.UserID)
                    canViewArticleList.Add(article);
            }

            this.rptUserPage.DataSource = canViewArticleList;
            this.rptUserPage.DataBind();
            this.ltlArticleCount.Text = canViewArticleList.Count.ToString();
        }
        private void InitMyPage()
        {
            this.plcPageOwner.Visible = true;
            this.plcGuest.Visible = false;
        }
        private void InitGuestMode(Guid nowUserID, Guid ownerUserID)
        {
            this.plcPageOwner.Visible = false;
            this.plcGuest.Visible = true;
            if (!_uaMgr.isFollowed(nowUserID, ownerUserID))
                this.btnFollow.Text = "追蹤";
            else
                this.btnFollow.Text = "取消追蹤";
        }

        protected void rptFollowing_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            ButtonFollowEvent(e);
        }
        protected void rptFans_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            ButtonFollowEvent(e);
        }

        private void ButtonFollowEvent(RepeaterCommandEventArgs e)
        {
            string userIDText;
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                if (e.CommandName == "buttonFollow")
                {
                    userIDText = e.CommandArgument as string;
                    if (Guid.TryParse(userIDText, out Guid userID))
                        _uaMgr.PressFollow(_nowUser.UserID, userID);
                }
                if (e.CommandName == "buttonUnFollow")
                {
                    userIDText = e.CommandArgument as string;
                    if (Guid.TryParse(userIDText, out Guid userID))
                        _uaMgr.UnFollow(_nowUser.UserID, userID);
                }
            }
            InitFollower(_pageOwner.UserID);
        }
        
        protected void lkbFollowingCount_Click(object sender, EventArgs e)
        {
            if (this.pnlFollowing.Visible)
                this.pnlFollowing.Visible = false;
            else
            {
                this.pnlFollowing.Visible = true;
                this.pnlFans.Visible = false;
            }
        }

        protected void lkbFansCount_Click(object sender, EventArgs e)
        {
            if (this.pnlFans.Visible)
                this.pnlFans.Visible = false;
            else
            {
                this.pnlFans.Visible = true;
                this.pnlFollowing.Visible = false;
            }
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            Response.Redirect($"UserInfoEdit.aspx?User={_nowUser.Account}");
        }
    }
}