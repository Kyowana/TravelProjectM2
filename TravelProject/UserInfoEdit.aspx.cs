using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TravelProject.Managers;
using TravelProject.Models;

namespace TravelProject
{
    public partial class UserInfoEdit : System.Web.UI.Page
    {
        private ArticleManager _mgr = new ArticleManager();
        private AccountManager _AccMgr = new AccountManager();
        private UserActiveManager _uaMgr = new UserActiveManager();
        private static UserAccountModel _nowUser;
        private static UserAccountModel _pageOwner;
        private MemberPageBase _mpB = new MemberPageBase();

        protected void Page_Load(object sender, EventArgs e)
        {
            string ownerAccount = this.Request.QueryString["User"];
            if (!string.IsNullOrWhiteSpace(ownerAccount))
            {
                if (!IsPostBack)
                {
                    _pageOwner = _AccMgr.GetAccount(ownerAccount);
                    if (_pageOwner != null)
                    {
                        _nowUser = HttpContext.Current.Session["UserAccount"] as UserAccountModel;

                        if (_pageOwner.UserID != _nowUser.UserID)
                            Response.Redirect("index.aspx");
                        else
                            InitProfile();
                    }
                }
            }
            else
                Response.Redirect("index.aspx");

        }

        private void InitProfile()
        {
            this.txtAccount.Text = _pageOwner.Account;
            this.txtPWD.Text = "";
            this.txtChkPWD.Text = "";
            this.ltlEmail.Text = _pageOwner.Email;
            this.txtNickname.Text = _pageOwner.NickName;
            string content = "";
            if (!string.IsNullOrWhiteSpace(_pageOwner.ProfileContent))
                content = _pageOwner.ProfileContent.Replace("<br />", "\n");
            this.txtProfile.Text = content;
        }

        protected void btnDeact_Click(object sender, EventArgs e)
        {
            // 寫入Deact DB → 隱藏 Article / Comment 
            // AccountStates...? → Following/Fans List 隱藏
            Response.Write("test");

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string account = this.txtAccount.Text.Trim();
            string password = this.txtPWD.Text.Trim();
            string chkPassword = this.txtChkPWD.Text.Trim();
            string nickName = this.txtNickname.Text.Trim();
            string content = this.txtProfile.Text;

            if (!CheckAccount(account, out string errorAcc))
                this.lblAccMsg.Text = errorAcc;

            //else if (!CheckPWD(password, chkPassword, out string errorPWD))
            // this.lblPWDMsg.Text = errorPWD;

            else
            {
                string[] contentArr = content.Split('\n');
                string contentWithBr = string.Join("<br />", contentArr);
                UserAccountModel user = new UserAccountModel()
                {
                    UserID = _nowUser.UserID,
                    Account = account,
                    PWD = password,
                    NickName = nickName,
                    ProfileContent = contentWithBr
                };

                if (string.IsNullOrWhiteSpace(password))
                {
                    // 不更新密碼欄位
                    _AccMgr.UpdateAccountExcPWD(user);
                    InitProfile();
                }
                else
                {
                    // 更新全部欄位
                    if (!CheckPWD(password, chkPassword, out string errorPWD))
                        this.lblPWDMsg.Text = errorPWD;
                    else
                    {
                        _AccMgr.UpdateAccountInclPWD(user);
                        InitProfile();
                    }
                }
                Response.Redirect($"UserPage.aspx?User={_nowUser.Account}");
            }
        }

        private bool CheckAccount(string account, out string errorMsg)
        {
            if (string.IsNullOrWhiteSpace(account))
            {
                errorMsg = "帳號不可為空白";
                return false;
            }
            else if (_AccMgr.GetAccount(account) != null)
            {
                if (_nowUser.Account != account)
                {
                    errorMsg = "已存在相同帳號";
                    return false;
                }
            }
            Regex regex = new Regex(@"^(?!.*[^\x21-\x7e])(?=.*[a-z]).{5,15}$");
            if (!regex.IsMatch(account))
            {
                errorMsg = "帳號格式不正確";
                return false;
            }
            errorMsg = null;
            return true;
        }
        private bool CheckPWD(string password, string chkPassword, out string errorMsg)
        {
            //if (string.IsNullOrWhiteSpace(password))
            //{
            //    errorMsg = "";
            //    return true;
            //}
            Regex regex = new Regex(@"^(?!.*[^\x21-\x7e])(?=.*[a-z])(?=.*\d).{8,15}$");
            if (!regex.IsMatch(password))
            {
                errorMsg = "密碼格式不正確";
                return false;
            }
            else if (string.Compare(password, chkPassword, false) != 0)
            {
                errorMsg = "請輸入相同密碼";
                return false;
            }
            errorMsg = null;
            return true;
        }
    }
}