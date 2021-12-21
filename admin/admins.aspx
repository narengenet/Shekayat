<%@ Page Title="" Language="C#" MasterPageFile="~/adminpages.Master" AutoEventWireup="true" CodeBehind="admins.aspx.cs" Inherits="Shekayat.admin.admins" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white" style="width: 83%;">

        <a href="#" class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
            <span class="fs-5 fw-semibold">مدیران سامانه</span>
        </a>


        <div class="d-flex flex-row align-items-stretch p-2">
            <div class="d-flex flex-row w-50 align-items-center">
                <a class="btn-primary p-2 rounded d-flex" href="<%= ResolveUrl("~/admin/editadmin.aspx?action=newadmin") %>">ایجاد مدیر جدید</a>
            </div>
            <div class="d-flex flex-row w-20 align-items-center">
                <label class="form-label" for="search-admin">جستجو</label>
                <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control m-1"></asp:TextBox>
                &nbsp;
            </div>
        </div>






        <div class="list-group list-group-flush border-bottom scrollarea">

            <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                    <div class="list-group-item list-group-item-action py-3 lh-tight bg-warning">
                        <div class="d-flex w-100 align-items-center justify-content-between">
                            <strong class="mb-1">شناسه: نام و فامیل</strong>
                            <small>شماره موبایل</small>
                            <div class="d-flex align-items-center">
                                عملیات ویرایش و حذف
                            </div>
                        </div>
                    </div>
                </HeaderTemplate>

                <ItemTemplate>

                    <div class="list-group-item list-group-item-action py-3 lh-tight <%#Eval("isactive").ToString()=="True" ? "":"bg-light"%> admin-id-<%# Eval("adminid") %> " data-id="<%# Eval("adminid") %>">
                        <div class="d-flex w-100 align-items-center justify-content-between">
                            <span class="mb-1 <%#Eval("isactive").ToString()=="True" ? "fw-bold":"text-warning"%>"><%# Eval("adminid") %>: <%# Eval("name") %> <%# Eval("family") %></span>
                            <small class="<%#Eval("isactive").ToString()=="True" ? "fw-bold":"text-warning"%>"><%# Eval("mobile") %></small>
                            <div class="d-flex align-items-center">
                                <a href="<%= ResolveUrl("~/admin/editadmin.aspx") %>?id=<%# Eval("adminid") %>" class="m-1 btn-info p-2 rounded d-flex align-items-center flex-row">ویرایش</a>
                                <a onclick="deleteAdmin(<%# Eval("adminid") %>)" class="m-1 btn-danger p-2 rounded d-flex align-items-center flex-row">حذف</a>
                            </div>
                        </div>
                    </div>


                </ItemTemplate>
            </asp:Repeater>


            <asp:SqlDataSource ID="adminsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [admins] WHERE (([mobile] LIKE '%' + @mobile + '%') OR ([name] LIKE '%' + @name + '%') OR ([family] LIKE '%' + @family + '%'))">
                <SelectParameters>
                    <asp:ControlParameter ControlID="TextBox1" Name="mobile" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox1" Name="name" PropertyName="Text" Type="String" />
                    <asp:ControlParameter ControlID="TextBox1" Name="family" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="allAdminsDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT adminid, name, family, mobile, creationdate, lastusage, isactive FROM admins"></asp:SqlDataSource>


        </div>
    </div>

    <div class="b-example-divider"></div>




    <script>
        $(document).ready(function () {
            changeCurrentPage('admins-lnk');

            if (getUrlVars().from == 'adminedit' && getUrlVars().result == 'success') {
                AdminEdit(getUrlVars().result, getUrlVars().id);
            }
            if (getUrlVars().from == 'newadmin' && getUrlVars().result == 'success') {
                NewAdmin(getUrlVars().result, getUrlVars().id);
            }



            $('#myModalOk').click(function () {
                $('#myModal').modal('hide');



                    //alert($(this).val());
                    var obj = {
                        'adminid': adminid,
                        'targetadmin': adminid_delete
                    }
                    $.ajax({
                        url: "../handlers/deleteAdmin.ashx",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: obj,
                        responseType: "json",
                    }).done(function (response) {
                        if (response == "1") {
                            successDeleteAdmin();
                        } else {
                            failureDeleteAdmin();
                        }

                    }).fail(function (jqXHR, textStatus) {
                        failureDeleteAdmin();
                    });








                
            });
        });


        

        function failureDeleteAdmin() {
            $('.toast-header').addClass('bg-danger');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('حذف ناموفق');
            $('#toastbody').html('مدیر مورد نظر شما حذف نشد. لطفا کمی بعد محددا تلاش کنید.');
            $('.toast').toast('show');
        }

        function successDeleteAdmin() {
            $('.toast-header').addClass('bg-success');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('حذف موفق');
            $('#toastbody').html('مدیر مورد نظر حذف شد.');
            $('.toast').toast('show');

            fadeBackground($('.admin-id-' + adminid_delete), 'red');
            setTimeout(function () {
                $('.admin-id-' + adminid_delete).remove();
            }, 1000);
        }


        function AdminEdit(result, id) {
            if (result == "success") {
                $('.toast-header').addClass('bg-success');
                $('#toasttitle').addClass('text-white');
                $("#toasttitle").html('بروزرسانی موفق');
                $('#toastbody').html('اطلاعات مدیر سامانه با موفقیت بروز رسانی شد. شناسه مدیر:' + id);
                $('.toast').toast('show');

                //$(".admin-id-" + id).addClass("active");
                fadeBackground($(".admin-id-" + id), 'aquamarine');
            } else {
                $('.toast-header').addClass('bg-danger');
                $('#toasttitle').addClass('text-white');
                $("#toasttitle").html('بروزرسانی ناموفق');
                $('#toastbody').html('بروزرسانی اطلاعات مدیر سامانه دوچار مشکل شد. شناسه مدیر:' + id);
                $('.toast').toast('show');

                //$(".admin-id-" + id).addClass("active");
                fadeBackground($(".admin-id-" + id), 'chocolate');
            }


        }


        function NewAdmin(result, id) {
            if (result == "success") {
                $('.toast-header').addClass('bg-success');
                $('#toasttitle').addClass('text-white');
                $("#toasttitle").html('ثبت مدیر جدید');
                $('#toastbody').html('مدیر جدید با موفقیت ایجاد شد. شناسه مدیر جدید:' + id);
                $('.toast').toast('show');

                //$(".admin-id-" + id).addClass("active");
                fadeBackground($(".admin-id-" + id), 'aquamarine');
            } else {
                $('.toast-header').addClass('bg-danger');
                $('#toasttitle').addClass('text-white');
                $("#toasttitle").html('ثبت ناموفق');
                $('#toastbody').html('ایجاد مدیر جدید با مشکل مواجه شد.');
                $('.toast').toast('show');

                //$(".admin-id-" + id).addClass("active");
                //fadeBackground($(".admin-id-" + id), 'chocolate');
            }


        }

        var adminid_delete = -1;
        function deleteAdmin(adminid) {

            $('#myModalTitle').html('حذف مدیر');
            $('#myModalBody').html('مطمئن هستید که میخواهید این مدیر را حذف کنید؟');
            $('#myModalClose').html('خیر');
            $('#myModalOk').html('بله. حذف شود');
            adminid_delete = adminid;
            $('#myModal').modal('show');
        }


    </script>
</asp:Content>
