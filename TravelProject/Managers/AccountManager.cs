using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using TravelProject.Helpers;
using TravelProject.Models;

namespace TravelProject.Managers
{
    public class AccountManager
    {
        public bool TryLogin(string account, string password)
        {
            bool isAccRight = false;
            bool isPwdRight = false;

            UserAccountModel User = this.GetAccount(account);
            int PWDkey = Convert.ToInt32(User.PWDkey);
            string EncodePWD = EncodePassword(password, PWDkey);
            if (User == null)
                return false;
            if (string.Compare(User.Account, account) == 0)
                isAccRight = true;
            if (string.Compare(User.PWD, EncodePWD) == 0)
                isPwdRight = true;

            bool result = (isAccRight && isPwdRight);

            if (result)
            {
                User.PWD = null;
                HttpContext.Current.Session["UserAccount"] = User;
            }
            return result;
        }
        public bool IsLogin()
        {
            UserAccountModel account = GetCurrentUser();
            return (account != null);
        }
        public void Logout()
        {
            HttpContext.Current.Session.Remove("UserAccount");
        }
        public UserAccountModel GetCurrentUser()
        {
            UserAccountModel account = HttpContext.Current.Session["UserAccount"] as UserAccountModel;
            return account;
        }
        public UserAccountModel GetAccount(string account)
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                @"  SELECT *
                    FROM [UserAccounts]
                    WHERE Account = @account ";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        command.Parameters.AddWithValue("@account", account);
                        conn.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            UserAccountModel User = BuildUserAccount(reader);
                            return User;
                        }

                        return null;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("AccountManager.GetAccount", ex);
                throw;
            }
        }
        public string GetAccount(Guid UserID)
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                @"  SELECT *
                    FROM [UserAccounts]
                    WHERE UserID = @UserID ";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        command.Parameters.AddWithValue("@UserID", UserID);
                        conn.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            UserAccountModel User = BuildUserAccount(reader);
                            return User.Account;
                        }

                        return null;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("AccountManager.GetAccount", ex);
                throw;
            }
        }
        public void CreateAccount(UserAccountModel User)
        {
            if (GetAccount(User.Account) != null)
                throw new Exception("已存在相同帳號");

            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                @"  INSERT INTO [UserAccounts] (UserID, Account, PWD, PWDkey, CreateDate,AccountStates, Email)
                    VALUES (@UserID, @Account, @PWD, @PWDkey, @CreateDate, @AccountStates, @Email) ";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        command.Parameters.AddWithValue("@UserID", Guid.NewGuid());
                        command.Parameters.AddWithValue("@Account", User.Account);
                        command.Parameters.AddWithValue("@PWD", User.PWD);
                        command.Parameters.AddWithValue("@PWDkey", User.PWDkey);
                        command.Parameters.AddWithValue("@Email", User.Email);
                        command.Parameters.AddWithValue("@CreateDate", DateTime.Now);
                        command.Parameters.AddWithValue("@AccountStates", true);

                        conn.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("AccountManager.CreateAccount", ex);
                throw;
            }
        }
        public void UpdateAccountExcPWD(UserAccountModel user)
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                @"  UPDATE [UserAccounts]
                    SET
                        Account = @Account,
                        ProfileContent = @ProfileContent,
                        NickName = @NickName
                    WHERE
                        UserID = @UserID ";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        command.Parameters.AddWithValue("@UserID", user.UserID);
                        command.Parameters.AddWithValue("@Account", user.Account);
                        command.Parameters.AddWithValue("@ProfileContent", user.ProfileContent);
                        command.Parameters.AddWithValue("@NickName", user.NickName);

                        conn.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("AccountManager.UpdateAccountExcPWD", ex);
                throw;
            }
        }
        public void UpdateAccountInclPWD(UserAccountModel user)
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText =
                @"  UPDATE [UserAccounts]
                    SET
                        Account = @Account,
                        PWD = @PWD,
                        ProfileContent = @ProfileContent,
                        NickName = @NickName
                    WHERE
                        UserID = @UserID ";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        command.Parameters.AddWithValue("@UserID", user.UserID);
                        command.Parameters.AddWithValue("@Account", user.Account);
                        command.Parameters.AddWithValue("@PWD", user.PWD);
                        command.Parameters.AddWithValue("@ProfileContent", user.ProfileContent);
                        command.Parameters.AddWithValue("@NickName", user.NickName);

                        conn.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("AccountManager.UpdateAccountInclPWD", ex);
                throw;
            }
        }
        private static UserAccountModel BuildUserAccount(SqlDataReader reader)
        {
            return new UserAccountModel()
            {
                UserID = (Guid)reader["UserID"],
                Account = reader["Account"] as string,
                PWD = reader["PWD"] as string,
                PWDkey = reader["PWDkey"] as string,
                CreateDate = (DateTime)reader["CreateDate"],
                AccountStates = (bool)reader["AccountStates"],
                ProfileContent = reader["ProfileContent"] as string,
                Email = reader["Email"] as string,
                NickName = reader["NickName"] as string                
            };
        }
        public string EncodePassword(string pwd, out int key)
        {
            Random rnd = new Random();
            key = rnd.Next(10000, 99999);
            var encoding = new System.Text.UTF8Encoding();
            byte[] keyByte = encoding.GetBytes(key.ToString());
            byte[] messageBytes = encoding.GetBytes(pwd);
            using (var hmacSHA256 = new HMACSHA256(keyByte))
            {
                byte[] hashMessage = hmacSHA256.ComputeHash(messageBytes);
                return BitConverter.ToString(hashMessage).Replace("-", "").ToLower();
            }
        }
        public string EncodePassword(string pwd, int key)
        {
            var encoding = new System.Text.UTF8Encoding();
            byte[] keyByte = encoding.GetBytes(key.ToString());
            byte[] messageBytes = encoding.GetBytes(pwd);
            using (var hmacSHA256 = new HMACSHA256(keyByte))
            {
                byte[] hashMessage = hmacSHA256.ComputeHash(messageBytes);
                return BitConverter.ToString(hashMessage).Replace("-", "").ToLower();
            }
        }



        #region 後臺功能


        //取得帳號列表
        public List<UserAccountModel> GetAccountList()
        {
            string connStr = ConfigHelper.GetConnectionString();
            string commandText = @"SELECT *
                                   FROM [UserAccounts]
                                   ORDER BY Account";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {

                        conn.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        List<UserAccountModel> list = new List<UserAccountModel>();
                        while (reader.Read())
                        {
                            UserAccountModel model = new UserAccountModel();
                            model.UserID = (Guid)reader["UserID"];
                            model.Account = reader["Account"] as string;
                            model.PWD = reader["PWD"] as string;
                            model.Email = reader["Email"] as string;
                            list.Add(model);
                        }
                        return list;
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("AccountManager.GetAccountList", ex);
                throw;
            }
        }


        //刪除（待修正）
        public void DeleteAccounts(List<Guid> ids)
        {
            if (ids == null || ids.Count == 0)
                throw new Exception("帳號不存在");

            List<string> param = new List<string>();
            for (var i = 0; i < ids.Count; i++)
            {
                param.Add("@UserID" + i);
            }
            string insql = string.Join(",", param);

            string connStr = ConfigHelper.GetConnectionString();
            string commandText = $@"DELETE UserAccounts
                                   WHERE ID IN ({insql})";
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand command = new SqlCommand(commandText, conn))
                    {
                        for (var i = 0; i < ids.Count; i++)
                        {
                            command.Parameters.AddWithValue("@UserID" + i, ids[i]);
                        }
                        conn.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                Logger.WriteLog("AccountManager.DeleteAccounts", ex);
                throw;
            }
        }

        #endregion


    }
}