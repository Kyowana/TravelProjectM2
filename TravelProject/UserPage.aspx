<%@ Page Title="" Language="C#" MasterPageFile="~/FrountMain.Master" AutoEventWireup="true" CodeBehind="UserPage.aspx.cs" Inherits="TravelProject.MyPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .follow {
            position: fixed;
            right: 30px;
            top: 30px;
            width: 250px;
            height: 300px;
            border: 1px solid #000000;
        }

        table {
            width: 100%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>個人頁面</h2>
    <div>
        <asp:Literal ID="ltlUserAcc" runat="server"></asp:Literal>|
            文章:           
                <asp:Literal ID="ltlArticleCount" runat="server"></asp:Literal>|
            追蹤中:           
        <asp:LinkButton ID="lkbFollowingCount" runat="server" OnClick="lkbFollowingCount_Click"></asp:LinkButton>|
            粉絲:           
        <asp:LinkButton ID="lkbFansCount" runat="server" OnClick="lkbFansCount_Click"></asp:LinkButton><br />
        <asp:Literal ID="ltlNickName" runat="server"></asp:Literal><br />
        <asp:Literal ID="ltlProfileContent" runat="server"></asp:Literal>
    </div>
    <asp:PlaceHolder ID="plcPageOwner" runat="server" Visible="false">
        <asp:Button ID="btnChange" runat="server" Text="修改個人資料" OnClick="btnChange_Click" />
    </asp:PlaceHolder>
    <asp:PlaceHolder ID="plcGuest" runat="server" Visible="true">
        <asp:Button ID="btnFollow" runat="server" Text="追蹤" OnClick="btnFollow_Click" />
    </asp:PlaceHolder>
    <asp:Repeater ID="rptUserPage" runat="server">
        <ItemTemplate>
            <p>
                <a href="ViewArticle.aspx?Post=<%# Eval("ArticleID")  %>">
                    <%# Eval("District")  %>
                </a>
            </p>
        </ItemTemplate>
    </asp:Repeater>
    <asp:Panel ID="pnlFollowing" runat="server" CssClass="follow" ScrollBars="Vertical" Visible="false">
        <table>
            <tr>
                <th colspan="2">追蹤中</th>
            </tr>
            <asp:Repeater ID="rptFollowing" runat="server" OnItemCommand="rptFollowing_ItemCommand">
                <ItemTemplate>
                    <tr>
                        <td>
                            <a href="UserPage.aspx?User=<%#Eval("Account") %>">
                                <%#Eval("Account") %>
                            </a>
                        </td>
                        <td width="50px">
                            <asp:HiddenField ID="hfFollowAcc" runat="server" Value='<%#Eval("Account") %>' />
                            <asp:Button runat="server" Text="追蹤" CommandArgument='<%#Eval("UserID") %>' CommandName="buttonFollow" ID="buttonFollow" />
                            <asp:Button runat="server" Text="取消追蹤" CommandArgument='<%#Eval("UserID") %>' CommandName="buttonUnFollow" ID="buttonUnFollow" />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </asp:Panel>
    <asp:Panel ID="pnlFans" runat="server" CssClass="follow" ScrollBars="Vertical" Visible="false">
        <table>
            <tr>
                <th colspan="2">粉絲</th>
            </tr>
            <asp:Repeater ID="rptFans" runat="server" OnItemCommand="rptFans_ItemCommand">
                <ItemTemplate>
                    <tr>
                        <td>
                            <a href="UserPage.aspx?User=<%#Eval("Account") %>">
                                <%#Eval("Account") %>
                            </a>
                        </td>
                        <td width="50px">
                            <asp:HiddenField ID="hfFollowAcc" runat="server" Value='<%#Eval("Account") %>' />
                            <asp:Button runat="server" Text="追蹤" CommandArgument='<%#Eval("UserID") %>' CommandName="buttonFollow" ID="buttonFollow" />
                            <asp:Button runat="server" Text="取消追蹤" CommandArgument='<%#Eval("UserID") %>' CommandName="buttonUnFollow" ID="buttonUnFollow" />
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </asp:Panel>
</asp:Content>
