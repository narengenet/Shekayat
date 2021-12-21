<%@ Page Title="" Language="C#" MasterPageFile="~/adminpages.Master" AutoEventWireup="true" CodeBehind="editadmin.aspx.cs" Inherits="Shekayat.admin.editadmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="d-flex flex-column align-items-stretch flex-shrink-0 bg-white scrollarea" style="width: 83%;">



        <a href="#" class="d-flex align-items-center flex-shrink-0 p-3 link-dark text-decoration-none border-bottom">
            <span class="fs-5 fw-semibold">ویرایش مدیر</span>
        </a>

        <div class="d-flex flex-row needs-validation">
            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                <asp:Label ID="lblName" runat="server" Text="نام" AssociatedControlID="name" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="name" runat="server" class="form-control"></asp:TextBox>
                <div class="invalid-feedback">
                    لطفا نام خود را بنویسید.
                </div>
            </div>
            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                <asp:Label ID="Label1" runat="server" Text="نام خانوادگی" AssociatedControlID="family" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="family" runat="server" class="form-control"></asp:TextBox>
                <div class="invalid-feedback">
                    لطفا نام خانوادگی خود را بنویسید.
                </div>
            </div>
            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                <asp:Label ID="Label2" runat="server" Text="تلفن همراه" AssociatedControlID="mobile" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="mobile" runat="server" class="form-control"></asp:TextBox>
                <div class="invalid-feedback">
                    شماره تلفن همراه وارد شده مجاز نمیباشد.
                </div>
            </div>
            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                <asp:Label ID="Label3" runat="server" Text="فعال" AssociatedControlID="isactive" CssClass="form-check-label"></asp:Label>
                <asp:CheckBox ID="isactive" CssClass="form-check-input" runat="server" />
            </div>

        </div>

        <div class="d-flex flex-row">
            <div class="d-flex flex-column flex-grow-1 rounded border border-1 border-secondary shadow-lg p-5 bg-light m-1">
                نقش ها
                <h1 class="mb-1"></h1>
                <asp:Repeater ID="Repeater2" runat="server" DataSourceID="SqlDataSource2">
                    <ItemTemplate>
                        <div class="d-flex flex-row align-items-center role">
                            <%--<input type="checkbox" class="m-1" id="role_<%# Eval("role_id") %>" onclick='toggleRow(<%# Eval("role_id") %>)' data-id='<%# Eval("role_id") %>' />--%>
                            <asp:CheckBox ID="CheckBox1" runat="server" Checked="False" Text='<%# Eval("name") %>' class='<%# Eval("role_id") %>' />
                            <%--<label class="form-check-label" for="role_<%# Eval("role_id") %>"><%# Eval("name") %></label>--%>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [roles]"></asp:SqlDataSource>
            </div>

        </div>

        <div class="d-flex w-100 align-items-center justify-content-end">

            <asp:Button runat="server" Text="ثبت اطلاعات" ID="btnSave" CssClass="btn-success p-2 m-1" OnClick="btnSave_Click" />
            <asp:Button runat="server" Text="بازگشت" ID="Button1" CssClass="btn-secondary p-2 m-1" OnClick="Button1_Click" />
        </div>

    </div>

    <div class="b-example-divider"></div>


    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:shekayatConnectionString %>" SelectCommand="SELECT * FROM [admins] WHERE ([adminid] = @adminid)">
        <SelectParameters>
            <asp:QueryStringParameter Name="adminid" QueryStringField="id" Type="Int64" />
        </SelectParameters>
    </asp:SqlDataSource>



    <script>
        var therows;
        function FillRoles(rows) {
            console.log(rows);
            therows = rows;
            for (var i = 0; i < therows.length; i++) {
                //$("#role_" + therows[i]["role_id"]).attr('checked', true);

                $(".role span." + therows[i]["role_id"] + " input[type=checkbox]").attr("checked", "true")
                //var roles = $('.role');
                //for (var j = 0; j < roles.length - 1; j++) {
                //    if ($($('.role label')[j]).html() == therows[i]["name"]) {
                //        $($(".role input[type=checkbox")[j]).attr('checked', true);
                //    }

                //}

            }
        }


        function toggleRow(item) {
            var value = $('#role_' + item).is(":checked");
            $('#ContentPlaceHolder1_Repeater2_HiddenField1_0').prop('checked')
            $(this).closest('input[type="hidden"');
            //$('#role_3').prop('checked', false)
            $('.find-me[data-id="' + item + '"]').prop('checked', value);
        }
    </script>

</asp:Content>
