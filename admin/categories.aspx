<%@ Page Title="" Language="C#" MasterPageFile="~/adminpages.Master" AutoEventWireup="true" CodeBehind="categories.aspx.cs" Inherits="Shekayat.admin.categories" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white scrollarea" style="width: 83%;">



        <a href="#" class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
            <span class="fs-5 fw-semibold">دپارتمان ها</span>
        </a>

        <div class="d-flex flex-row">
            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                <h2>ایجاد دپارتمان جدید</h2>
                <div class="d-flex flex-row align-items-center m-1">
                    <label for="ContentPlaceHolder1_newCategory" class="form-label m-1">نام دپارتمان جدید</label>
                    <asp:TextBox ID="newCategory" runat="server" CssClass="form-control  w-50"></asp:TextBox>
                    <asp:Button ID="btnCreateNewCategory" runat="server" Text="ثبت" CssClass="btn-primary m-1 p-1 w-25" OnClick="btnCreateNewCategory_Click" />
                </div>
            </div>
            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                <label for="ContentPlaceHolder1_search" class="form-label">جستجو</label>
                <asp:TextBox ID="search" CssClass="form-control" runat="server" AutoPostBack="True"></asp:TextBox>

            </div>

        </div>


        <div class="list-group list-group-flush border-bottom  p-2">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="LightGoldenrodYellow" BorderColor="Tan" BorderWidth="1px" CellPadding="2" DataKeyNames="department_id" ForeColor="Black" GridLines="None" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="department_id" HeaderText="شناسه" InsertVisible="False" ReadOnly="True" SortExpression="department_id" />
                    <asp:BoundField DataField="name" HeaderText="نام دپارتمان" SortExpression="name" />
                </Columns>
                <FooterStyle BackColor="Tan" />
                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                <SortedAscendingCellStyle BackColor="#FAFAE7" />
                <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                <SortedDescendingCellStyle BackColor="#E1DB9C" />
                <SortedDescendingHeaderStyle BackColor="#C2A47B" />
            </asp:GridView>
            <asp:SqlDataSource ID="departmentsSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [departments]"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [threads] WHERE ([department_id] = @department_id)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="department_id" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="searchSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [departments] WHERE ([name] LIKE '%' + @name + '%')">
                <SelectParameters>
                    <asp:ControlParameter ControlID="search" Name="name" PropertyName="Text" Type="String" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>



        <div class="align-items-stretch p-2" id="editCategoriesContainer">
            <div class="d-flex flex-row w-50 align-items-center">
                <asp:Label ID="Label1" runat="server" AssociatedControlID="DropDownList1" CssClass="bold-smal-text w-100" Text="عملیات با دپارتمان انتخاب شده"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" CssClass="form-select" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    <asp:ListItem Value="-1">...</asp:ListItem>
                    <asp:ListItem Value="1">حذف دپارتمان</asp:ListItem>
                    <asp:ListItem Value="2">ویرایش دپارتمان</asp:ListItem>
                </asp:DropDownList>
                <asp:Label ID="Label3" runat="server" AssociatedControlID="thiscategoryThreadCount" CssClass="bold-smal-text w-100 m-3 text-left-aligned" Text="تعداد شکایات این دپارتمان:"></asp:Label>
                <asp:Label Text="" CssClass="bold-smal-text text-info" ID="thiscategoryThreadCount" runat="server" />
                <span class="bold-smal-text m-2">شکایت </span>
            </div>
        </div>

        <div class="d-flex flex-row align-items-stretch p-2 edit-dep bg-warning" style="display: none!important;">
            <asp:Label ID="Label2" runat="server" AssociatedControlID="TextBox1" CssClass="form-label" Text="ویرایش نام دپارتمان"></asp:Label>

            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="ثبت" CssClass="btn-primary" OnClick="Button1_Click" />
            <asp:HiddenField ID="HiddenField1" runat="server" />

        </div>

        <hr />



        <asp:Panel ID="pnlSubjects" runat="server" CssClass="rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1 scrollarea panel-subject">
            <h4>موضوعات شکایت مربوط به این دپارتمان</h4>
            <div class="d-flex flex-row align-items-center m-1">
                <asp:GridView ID="grdvSubjects" runat="server" AutoGenerateColumns="False" CellPadding="3" DataKeyNames="subject_id" DataSourceID="sqldsDepartmentsSubjects" GridLines="None" OnRowDeleting="grdvSubjects_RowDeleting" OnRowUpdating="grdvSubjects_RowUpdating1" BackColor="White" BorderColor="White" BorderStyle="Ridge" BorderWidth="2px" CellSpacing="1">
                    <Columns>
                        <asp:CommandField CancelText="لغو" DeleteText="حدف" EditText="ویرایش" ShowDeleteButton="True" ShowEditButton="True" UpdateText="بروزرسانی" />
                        <asp:BoundField DataField="subject_id" HeaderText="شناسه موضوع" InsertVisible="False" ReadOnly="True" SortExpression="subject_id" />
                        <asp:BoundField DataField="subject_text" HeaderText="موضوع شکایت" SortExpression="subject_text" />
                        <asp:CheckBoxField DataField="is_active" HeaderText="فعال" SortExpression="is_active" />
                    </Columns>
                    <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#E7E7FF" />
                    <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                    <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                    <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                    <SortedAscendingHeaderStyle BackColor="#594B9C" />
                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                    <SortedDescendingHeaderStyle BackColor="#33276A" />
                </asp:GridView>
                <asp:SqlDataSource ID="sqldsDepartmentsSubjects" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" DeleteCommand="DELETE FROM [departments_subjects] WHERE [subject_id] = @original_subject_id" InsertCommand="INSERT INTO [departments_subjects] ([subject_text], [is_active]) VALUES (@subject_text, @is_active)" OldValuesParameterFormatString="original_{0}" SelectCommand="SELECT [subject_id], [subject_text], [is_active] FROM [departments_subjects] WHERE ([department_id] = @department_id)" UpdateCommand="UPDATE [departments_subjects] SET [subject_text] = @subject_text, [is_active] = @is_active WHERE [subject_id] = @original_subject_id">
                    <DeleteParameters>
                        <asp:Parameter Name="original_subject_id" Type="Int32" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="subject_text" Type="String" />
                        <asp:Parameter Name="is_active" Type="Boolean" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="department_id" PropertyName="SelectedValue" Type="Int32" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="subject_text" Type="String" />
                        <asp:Parameter Name="is_active" Type="Boolean" />
                        <asp:Parameter Name="original_subject_id" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </div>
            <hr />






            <div class="d-flex flex-row align-items-center m-1 w-50">
                <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-1 bg-light m-1 w-25">
                    <h5>ایجاد موضوع جدید</h5>
                    <div class="d-flex flex-row align-items-center m-1">
                        <label for="ContentPlaceHolder1_newCategory" class="form-label m-1">نام موضوع جدید</label>
                        <asp:TextBox ID="txtNewSubject" runat="server" CssClass="form-control  w-50"></asp:TextBox>
                        <asp:Button ID="btnNewSubject" runat="server" Text="ثبت" CssClass="btn-primary m-1 p-1 w-25" OnClick="btnNewSubject_Click" />
                    </div>
                </div>
            </div>

        </asp:Panel>





    </div>

    <script>
        $(document).ready(function () {


            var selects = $('table tr td a');
            for (var i = 0; i < selects.length; i++) {
                if ($(selects[i]).html() == 'Select') {
                    $(selects[i]).html('انتخاب');
                }
            }


            changeCurrentPage('categories-lnk');


            if (error_permision != "-1") {
                showErrorPermission(error_permision);
            }

            if (error_create_new_dep != "-1") {
                showErrorCreateDep(error_create_new_dep);
            }

            if (success_create_new_dep != "-1") {
                showSuccessCreateNewDep();
            }

            if (success_delete_dep != "-1") {
                showSuccessDeleteDep();
            }

            if (dep_delete != "-1") {
                deleteDepAsk();
            }

            if (errore_edit_dep != "-1") {
                showErrorCreateDep("-1");
            }

            if (success_edit_dep != "-1") {
                showSuccessEditDep();
            }


            if (show_edit_container == "-1") {
                $('#editCategoriesContainer').css('display', 'none');

            } else {
                $('#editCategoriesContainer').css('display', 'block');
            }




            $('#myModalOk').click(function () {
                $('#myModal').modal('hide');



                //alert($(this).val());
                var obj = {
                    'adminid': adminid,
                    'depid': dep_delete
                }
                $.ajax({
                    url: "../handlers/deleteDepartment.ashx",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: obj,
                    responseType: "json",
                }).done(function (response) {
                    if (response == "1") {
                        //successDeleteThread();
                        refreshDeleted();
                    } else {
                        failureDeleteThread();
                    }

                }).fail(function (jqXHR, textStatus) {
                    failureDeleteAdmin();
                });









            });

        });



        error_permision = "-1";
        function errorPermission(txt) {
            error_permision = txt;
        }
        function showErrorPermission(error_permision) {
            $('.toast-header').addClass('bg-danger');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('اشکال سطح دسترسی');
            $('#toastbody').html('شما دسترسی لازم برای ' + error_permision + ' را ندارید.');
            $('.toast').toast('show');
        }
        error_create_new_dep = "-1";
        function errorCreateNewDep(txt) {
            error_create_new_dep = txt;
        }
        function showErrorCreateDep(error_permision) {
            $('.toast-header').addClass('bg-danger');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('نام دپارتمان تکراری');
            $('#toastbody').html('نام دپارتمان جدیدی که وارد کرده اید قبلا استفاده شده است. لطفا نام دیگری انتخاب کنید.');
            $('.toast').toast('show');
        }

        success_create_new_dep = "-1";
        function successCreateNewDep() {
            success_create_new_dep = "1";
        }
        function showSuccessCreateNewDep() {
            $('.toast-header').addClass('bg-success');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('ثبت موفق');
            $('#toastbody').html('دپارتمان جدید با موفقیت ثبت شد.');
            $('.toast').toast('show');
        }

        function showSuccessCreateNewSubject() {
            $('.toast-header').addClass('bg-success');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('ثبت موفق');
            $('#toastbody').html('موضوع جدید با موفقیت ثبت شد.');
            $('.toast').toast('show');
        }

        success_delete_dep = "-1";
        function successDeleteDep() {
            success_delete_dep = "0";
        }


        var dep_delete = "-1";
        function goDeleteDep(ind) {
            dep_delete = ind;
        }
        function deleteDepAsk() {

            $('#myModalTitle').html('حذف دپارتمان');
            $('#myModalBody').html('تمامی شکایات مربوط به این دپارتمان از این دپارتمان خارج خواهند شد و کلیه موضوعات مربوط به این دپارتمان نیز حذف خواهند شد. مطمئن هستید که میخواهید این دپارتمان را حذف کنید؟');
            $('#myModalClose').html('خیر');
            $('#myModalOk').html('بله. حذف شود');

            $('#myModal').modal('show');
        }

        function showSuccessDeleteDep() {
            $('.toast-header').addClass('bg-success');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('حذف موفق');
            $('#toastbody').html('دپارتمان با موفقیت حذف شد.');
            $('.toast').toast('show');
        }

        errore_edit_dep = "-1";
        function errorEditDep() {
            errore_edit_dep = "0";
        }

        success_edit_dep = "-1";
        function successEditDep() {
            success_edit_dep = "0";
        }
        function showSuccessEditDep() {
            $('.toast-header').addClass('bg-success');
            $('#toasttitle').addClass('text-white');
            $("#toasttitle").html('ویرایش موفق');
            $('#toastbody').html('دپارتمان با موفقیت ویرایش شد.');
            $('.toast').toast('show');
        }


        function refreshDeleted() {
            window.location.reload();
        }

        function enableEdit(ind, txt) {
            var cols = document.getElementsByClassName('edit-dep');
            for (i = 0; i < cols.length; i++) {
                cols[i].style.display = 'block';
            }
            document.getElementById("ContentPlaceHolder1_HiddenField1").value = ind;
            document.getElementById("ContentPlaceHolder1_TextBox1").value = txt;

            $('#ContentPlaceHolder1_pnlSubjects').css('display', 'none');
        }



        show_edit_container = "-1";

        function showEditDeps() {
            //document.getElementById("editCategoriesContainer").style.display = "block!important";
            show_edit_container = "1";
            //alert('y');
        }

        function hideEditDeps() {
            //document.getElementById("editCategoriesContainer").style.display = "none!important";
            show_edit_container = "-1";
        }
    </script>

</asp:Content>
