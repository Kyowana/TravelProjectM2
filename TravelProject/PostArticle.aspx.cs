﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using TravelProject.Models;
using TravelProject.Managers;
using Google.Maps;
using Google.Maps.Places;

namespace TravelProject
{
    public partial class PostArticle : System.Web.UI.Page
    {
        private ArticleManager _mgr = new ArticleManager();
        private AccountManager _AccMgr = new AccountManager();
        private static UserAccountModel _account;
        private static Guid _articleID;
        private static bool _isCreateMode;
        protected void Page_Load(object sender, EventArgs e)
        {
            _account = HttpContext.Current.Session["UserAccount"] as UserAccountModel;
            string articleIDText = this.Request.QueryString["Post"];
            string UserIDText = this.Request.QueryString["Editor"];
            if (articleIDText == null && UserIDText == null)
            {
                _isCreateMode = true;
                InitCreateMode();
            }
            else if (!IsPostBack)
            {
                if (!Guid.TryParse(articleIDText, out _articleID))
                    Response.Redirect("index.aspx", true);
                //比對session和querySrting的UserID是否一致
                if (string.Compare(UserIDText, _account.UserID.ToString()) != 0)
                    Response.Redirect("index.aspx", true);

                ArticleModel articel = _mgr.GetArticle(_articleID);
                if (articel != null)
                {
                    //比對session和Article資料庫中的UserID是否一致
                    if (articel.UserID == _account.UserID)
                    {
                        _isCreateMode = false;
                        InitEditMode(articel);
                    }
                }
                else
                    Response.Redirect("index.aspx", true);
            }
        }
        private void InitEditMode(ArticleModel articel)
        {


            this.txtDistrict.Text = articel.District;
            this.txtContent.Text = articel.ArticleContent.Replace("<br/>", "\n");
            this.hfLat.Value = "";
            this.hfLng.Value = "";
            this.ddlViewLimit.SelectedValue = ((int)articel.ViewLimit).ToString();
            this.ddlCommemtLimit.SelectedValue = ((int)articel.CommentLimit).ToString();

            if (articel.Latitude != null || articel.Longitude != null)
            {
                this.hfLat.Value = articel.Latitude;
                this.hfLng.Value = articel.Longitude;
            }
            this.hfPlaceID.Value = articel.PlaceID;
        }
        private void InitCreateMode()
        {

        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            string[] arrContent = this.txtContent.Text.Trim().Split('\n');
            string contentWithBr = string.Join("<br/>", arrContent);
                ArticleModel articel = new ArticleModel()
                {
                    UserID = _account.UserID,
                    District = this.txtDistrict.Text.Trim(),
                    Latitude = this.hfLat.Value,
                    Longitude = this.hfLng.Value,
                    PlaceID = this.hfPlaceID.Value,
                    ArticleContent = contentWithBr,
                    ViewLimit = (ArticleViewLimitEnum)Convert.ToInt32(this.ddlViewLimit.SelectedValue),
                    CommentLimit = (CommentLimitEnum)Convert.ToInt32(this.ddlCommemtLimit.SelectedValue)
                };
            if (_isCreateMode)
            {
                articel.ArticleID = Guid.NewGuid();
                _mgr.CreateArticle(articel);
            }
            else
            {
                articel.ArticleID = _articleID;
                _mgr.UpdateArticle(articel);
            }
            Response.Redirect($"ViewArticle.aspx?Post={articel.ArticleID}");
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            if (!_isCreateMode)
                Response.Redirect($"ViewArticle.aspx?Post={ _articleID }");
            else
                Response.Redirect($"UserPage.aspx?User={_account.Account}");
        }

        protected void btnSearchDistrict_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrWhiteSpace(this.txtDistrict.Text))
            {
                GoogleSigned.AssignAllServices(new GoogleSigned("AIzaSyBA9A_Ry9G67EMNHQHYwh3aAE9ubAkaLdU"));
                var request = new TextSearchRequest()
                {
                    Language = "zh-tw",
                    Query = this.txtDistrict.Text.Trim()
                };
                List<DistrictModel> districtList = new List<DistrictModel>();
                var response = new PlacesService().GetResponse(request);
                foreach (var x in response.Results)
                {
                    DistrictModel district = new DistrictModel();
                    district.DistrictName = x.Name;
                    district.Latitude = x.Geometry.Location.Latitude.ToString();
                    district.Longitude = x.Geometry.Location.Longitude.ToString();
                    district.PlaceID = x.PlaceId;
                    district.PlaceValue = $"{district.Latitude},{district.Longitude},{district.PlaceID}";
                    districtList.Add(district);
                }
                this.plcSearch.Visible = true;
                this.ListBox1.DataSource = districtList;
                this.ListBox1.DataTextField = "DistrictName";
                this.ListBox1.DataValueField = "PlaceValue";
                this.ListBox1.DataBind();
            }
        }
        protected void btnDistrictClick_Click(object sender, EventArgs e)
        {
            if (this.ListBox1.SelectedIndex > -1)
            {
                string[] placeValue = this.ListBox1.SelectedValue.Split(',');
                this.hfLat.Value = placeValue[0];
                this.hfLng.Value = placeValue[1];
                this.hfPlaceID.Value = placeValue[2];
                this.txtDistrict.Text = this.ListBox1.SelectedItem.Text;
                this.plcSearch.Visible = false;
            }

        }

    }
}