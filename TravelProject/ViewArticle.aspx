<%@ Page Title="" Language="C#" MasterPageFile="~/FrountMain.Master" AutoEventWireup="true" CodeBehind="ViewArticle.aspx.cs" Inherits="TravelProject.ViewArticle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2>文章頁面</h2>
    <asp:PlaceHolder ID="plcEdit" runat="server" Visible="false">
        <asp:Button ID="btnEdit" runat="server" Text="編輯" OnClick="btnEdit_Click" />
        <asp:Button ID="btnDelArticle" runat="server" Text="刪除文章" OnClick="btnDelArticle_Click" CssClass="btnDel" />
    </asp:PlaceHolder>
    <div>
        發布者:
       
        <asp:Literal ID="ltlUser" runat="server"></asp:Literal>
    </div>
    <div>
        照片:
       
        <asp:Literal ID="ltlPhoto" runat="server"></asp:Literal>
    </div>
    <div>
        地點:
       
        <asp:Literal ID="ltlDistrict" runat="server"></asp:Literal>
    </div>
    <div>
        內文:
       
        <asp:Literal ID="ltlArtContent" runat="server"></asp:Literal>
    </div>
    <div>
        發布日期:
       
        <asp:Literal ID="ltlCreateDate" runat="server"></asp:Literal>
    </div>
    <div>
        <asp:Button ID="btnLike" runat="server" Text="讚" OnClick="btnLike_Click" />
        <asp:Label ID="lblLikeCount" runat="server" Text="Label"></asp:Label>|
       
        <asp:Button ID="btnCollect" runat="server" Text="收藏" OnClick="btnCollect_Click" />

        <asp:HiddenField ID="hfID2" runat="server" Value="" />
        <button runat="server" id="btnReportA" type="button" data-bs-toggle="modal" data-bs-target="#ReportArticleModal">檢舉</button>
        <%--<asp:Button ID="btnReportArticle" runat="server" Text="檢舉" data-bs-toggle="modal" data-bs-target="#ReportArticleModal" />--%>
        <div>
            <asp:PlaceHolder ID="plcCanComment" runat="server">
                <asp:TextBox ID="txtComment" runat="server"></asp:TextBox>
                <asp:Button ID="btnComment" runat="server" Text="留言" OnClick="btnComment_Click" /><br />
            </asp:PlaceHolder>
            <asp:Literal ID="ltlCommentMsg" runat="server" Visible="false">您沒有權限回覆本貼文。</asp:Literal>

            <asp:Literal ID="ltlCommentCount" runat="server"></asp:Literal><br />
            <asp:Repeater ID="rptComment" runat="server" OnItemCommand="rptComment_ItemCommand">
                <ItemTemplate>
                    <div>
                        <a href="UserPage.aspx?User=<%# Eval("Account") %>"><%# Eval("Account") %></a> : <%# Eval("CommentContent") %> 發布時間<%# Eval("CreateTime") %>
                        <asp:Button runat="server" Text="回覆" CommandArgument='<%# Eval("CommentID") %>' CommandName="ReButton" />
                        <asp:Button runat="server" Text="刪除" Visible="false" CommandArgument='<%# Eval("CommentID") %>' CommandName="DeleteButton" CssClass="btnDel" ID="rptCmtDel" />
                        <input type="hidden" id="hfID" value='<%# Eval("CommentID") %>' />
                        <button runat="server" id="btnReportComment" type="button" data-bs-toggle="modal" data-bs-target="#ReportCommentModal">檢舉</button>
                    </div>
                </ItemTemplate>
                <SeparatorTemplate>
                    <hr />
                </SeparatorTemplate>
            </asp:Repeater>
        </div>
    </div>
    <div class="modal" id="ReportArticleModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <asp:Literal ID="Literal1" runat="server">檢舉</asp:Literal></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>
                        <asp:Literal ID="Literal2" runat="server">您確定要檢舉嗎？<br />若不想檢舉，請點擊關閉。</asp:Literal>
                    </p>

                    <div class="mb-3">

                        <label for="exampleFormControlInput1" class="form-label">檢舉理由</label>

                        <select id="SelectReasonA" name="SelectReasonA" cssclass="form-control">
                            <option value="1" selected="selected">請選擇</option>
                            <option value="2">我認為這冒犯了我</option>
                            <option value="3">我的著作權被侵犯了</option>
                            <option value="4">這個內容有違法行為</option>
                            <option value="5">其他</option>
                        </select>

                    </div>
                    <div class="mb-3">
                        <label for="ReportArticleModalTextarea" class="form-label">附加說明</label>
                        <textarea class="form-control" name="txtContent" id="ReportArticleModalTextarea" rows="3" placeholder="請詳細說明檢舉理由"></textarea>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">關閉</button>
                    <button type="button" id="btnSendReportofA" class="btn btn-primary">送出</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal" id="ReportCommentModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <asp:Literal ID="ltlModalTitle" runat="server">檢舉</asp:Literal></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>
                        <asp:Literal ID="ltlModalContent" runat="server">您確定要檢舉嗎？<br />若不想檢舉，請點擊關閉。</asp:Literal>
                    </p>

                    <div class="mb-3">
                        <input type="hidden" name="noID" />

                        <label for="exampleFormControlInput1" class="form-label">檢舉理由</label>

                        <select id="SelectReason" name="SelectReason" cssclass="form-control">
                            <option value="1" selected="selected">請選擇</option>
                            <option value="2">我認為這冒犯了我</option>
                            <option value="3">我的著作權被侵犯了</option>
                            <option value="4">這個內容有違法行為</option>
                            <option value="5">其他</option>
                        </select>

                    </div>
                    <div class="mb-3">
                        <label for="exampleFormControlTextarea1" class="form-label">附加說明</label>
                        <textarea class="form-control" name="txtContent" id="exampleFormControlTextarea1" rows="3" placeholder="請詳細說明檢舉理由"></textarea>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">關閉</button>
                    <button type="button" id="btnSendReport" class="btn btn-primary">送出</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            $("#btnSendReportofA").click(function () {
                var container = $("#ReportArticleModal");

                if ($('#SelectReasonA option:selected').val() == "1") {
                    alert('請選擇檢舉理由');
                    return;
                }

                var reportReason = {
                    "ID": $("#<%= this.hfID2.ClientID %>").val(),
                    "ReportType": "Article",
                    "Reason": $('#SelectReasonA option:selected').val(),
                    "Content": $("textarea[name=txtContent]", container).val()
                };

                $.ajax({
                    url: "/API/ReportCommentHandler.ashx?Action=SendA",
                    method: "POST",
                    data: reportReason,
                    success: function (txtMsg) {
                        console.log(txtMsg);
                        if (txtMsg == "OK") {
                            alert("謝謝您，已收到您的檢舉。");
                            history.go(0);
                        }
                        else {
                            alert("檢舉失敗，請聯絡管理員。");
                        }

                    },
                    error: function (msg) {
                        console.log(msg);
                        alert("通訊失敗，請聯絡管理員。");
                    }
                });

            });

            $("#btnSendReport").click(function () {
                var container = $("#ReportCommentModal");

                if ($('#SelectReason option:selected').val() == "1") {
                    alert('請選擇檢舉理由');
                    return;
                }

                var parentDiv = $(this).closest("div");
                var hf = parentDiv.find("input.hfID");
                var reportReason = {
                    "ID": $("#hfID").val(),
                    "ReportType": "Comment",
                    "Reason": $('#SelectReason option:selected').val(),
                    "Content": $("textarea[name=txtContent]", container).val()
                };

                $.ajax({
                    url: "/API/ReportCommentHandler.ashx?Action=SendC",
                    method: "POST",
                    data: reportReason,
                    //dataType: "JSON",
                    success: function (txtMsg) {
                        console.log(txtMsg);
                        if (txtMsg == "OK") {
                            alert("謝謝您，已收到您的檢舉。");
                            history.go(0);
                        }
                        else {
                            alert("檢舉失敗，請聯絡管理員。");
                        }
                        
                    },
                    error: function (msg) {
                        console.log(msg);
                        alert("通訊失敗，請聯絡管理員。");
                    }
                });

            });

        })
    </script>

</asp:Content>
