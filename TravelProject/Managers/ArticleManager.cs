using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using TravelProject.Models;
using TravelProject.Helpers;
using System.Data.SqlClient;

namespace TravelProject.Managers
{
    public class ArticleManager
    {
        private static UserActiveManager _uaMgr = new UserActiveManager();
        public ArticleModel GetArticle(Guid articleID)
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                $@"  SELECT *
                     FROM [Articles]
                     WHERE ArticleID = @ArticleID ";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        command.Parameters.AddWithValue("@ArticleID", articleID);

                        conn.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        ArticleModel article = new ArticleModel();
                        if (reader.Read())
                        {
                            article = BuildArticle(reader);
                        }
                        return article;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("ArticleManager.GetArticle", ex);
                throw;
            }
        }
        public List<ArticleModel> GetArticleList(Guid UserID)
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                $@"  SELECT *
                     FROM [Articles]
                     WHERE UserID = @UserID 
                     ORDER BY CreateTime DESC";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        command.Parameters.AddWithValue("@UserID", UserID);

                        conn.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        List<ArticleModel> articleList = new List<ArticleModel>();
                        while (reader.Read())
                        {
                            ArticleModel article = BuildArticle(reader);
                            articleList.Add(article);
                        }
                        return articleList;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("ArticleManager.GetArticleList", ex);
                throw;
            }
        }
        private static ArticleModel BuildArticle(SqlDataReader reader)
        {
            return new ArticleModel()
            {
                ArticleID = (Guid)reader["ArticleID"],
                UserID = (Guid)reader["UserID"],
                District = reader["District"] as string,
                Longitude = reader["Longitude"] as string,
                Latitude = reader["Latitude"] as string,
                PlaceID = reader["PlaceID"] as string,
                ArticleContent = reader["ArticleContent"] as string,
                CreateTime = (DateTime)reader["CreateTime"],
                ViewLimit = (ArticleViewLimitEnum)(reader["ViewLimit"]),
                CommentLimit = (CommentLimitEnum)(reader["CommentLimit"])
            };
        }
        public void CreateArticle(ArticleModel articel)
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                @"  INSERT INTO [Articles] 
                        (ArticleID, UserID, District, Longitude, Latitude, PlaceID, ArticleContent, ViewLimit, CommentLimit)
                    VALUES  
                        (@ArticleID, @UserID, @District, @Longitude, @Latitude, @PlaceID, @ArticleContent, @ViewLimit, @CommentLimit) ";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        conn.Open();
                        command.Parameters.AddWithValue("@ArticleID", articel.ArticleID);
                        command.Parameters.AddWithValue("@UserID", articel.UserID);
                        command.Parameters.AddWithValue("@District", articel.District);
                        command.Parameters.AddWithValue("@Longitude", articel.Longitude);
                        command.Parameters.AddWithValue("@Latitude", articel.Latitude);
                        command.Parameters.AddWithValue("@PlaceID", articel.PlaceID);
                        command.Parameters.AddWithValue("@ArticleContent", articel.ArticleContent);
                        command.Parameters.AddWithValue("@ViewLimit", articel.ViewLimit);
                        command.Parameters.AddWithValue("@CommentLimit", articel.CommentLimit);
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("ArticleManager.CreateArticle", ex);
                throw;
            }
        }
        public void UpdateArticle(ArticleModel articel)
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                @"  UPDATE [Articles] 
                    SET District = @District, 
                        Longitude = @Longitude,
                        Latitude = @Latitude,
                        PlaceID = @PlaceID,
                        ArticleContent = @ArticleContent, 
                        ViewLimit = @ViewLimit, 
                        CommentLimit = @CommentLimit, 
                        UpdateTime = @UpdateTime 
                    WHERE ArticleID = @ArticleID";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        conn.Open();
                        command.Parameters.AddWithValue("@ArticleID", articel.ArticleID);
                        command.Parameters.AddWithValue("@District", articel.District);
                        command.Parameters.AddWithValue("@Longitude", articel.Longitude);
                        command.Parameters.AddWithValue("@Latitude", articel.Latitude);
                        command.Parameters.AddWithValue("@PlaceID", articel.PlaceID);
                        command.Parameters.AddWithValue("@ArticleContent", articel.ArticleContent);
                        command.Parameters.AddWithValue("@ViewLimit", articel.ViewLimit);
                        command.Parameters.AddWithValue("@CommentLimit", articel.CommentLimit);
                        command.Parameters.AddWithValue("@UpdateTime", DateTime.Now);
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("ArticleManager.UpdateArticle", ex);
                throw;
            }
        }
        public void DeleteArticle(Guid articleID)
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                @"  DELETE FROM [Articles] 
                    WHERE  
                        ArticleID = @ArticleID";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        DeleteNoticeOfArticle(articleID);
                        DeleteCommentOfArticle(articleID);
                        _uaMgr.DeleteCollectOfArticle(articleID);
                        _uaMgr.DeleteLikeOfArticle(articleID);
                        conn.Open();
                        command.Parameters.AddWithValue("@ArticleID", articleID);
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("ArticleManager.DeleteArticle", ex);
                throw;
            }
        }
        public void DeleteCommentOfArticle(Guid articleID)
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                @"  DELETE FROM [Comments] 
                    WHERE  
                        ArticleID = @ArticleID";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        conn.Open();
                        command.Parameters.AddWithValue("@ArticleID", articleID);
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("ArticleManager.DeleteCommentOfArticle", ex);
                throw;
            }
        }
        public void DeleteNoticeOfArticle(Guid articleID)
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                @"  DELETE FROM [Notices] 
                    WHERE  
                        ArticleID = @ArticleID";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        conn.Open();
                        command.Parameters.AddWithValue("@ArticleID", articleID);
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("ArticleManager.DeleteNoticeOfArticle", ex);
                throw;
            }
        }





        //關鍵字搜尋（內文）
        public List<ArticleModel> GetAdminArticleList(string keyword)
        {
            string whereCondition = string.Empty;
            if (!string.IsNullOrWhiteSpace(keyword))
                whereCondition = " WHERE ArticleContent LIKE '%'+@keyword+'%' ";

            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                $@" SELECT *
                    FROM Articles
                    {whereCondition}
                    ORDER BY CreateDate DESC ";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        if (!string.IsNullOrWhiteSpace(keyword))
                        {
                            command.Parameters.AddWithValue("@keyword", keyword);
                        }

                        conn.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        List<ArticleModel> retList = new List<ArticleModel>();    // 將資料庫內容轉為自定義型別清單
                        while (reader.Read())
                        {
                            ArticleModel info = BuildArticle(reader);
                            retList.Add(info);
                        }

                        return retList;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("MapContentManager.GetAdminMapList", ex);
                throw;
            }
        }

    }
}