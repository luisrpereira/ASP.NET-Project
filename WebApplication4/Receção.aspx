<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Receção.aspx.cs" Async="true" Inherits="WebApplication4.WebForm1" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Receção IPCA Health</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <style type="text/css">
        input[type=text] {
            margin-right: 5px;
            position: relative;
            top: -2px
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.min.js" type="text/javascript"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="Stylesheet" type="text/css" />
    <script type="text/javascript">
        $(function () {
            $("[id*=txtDate]").datepicker({
                showOn: 'button',
                buttonImageOnly: true,
                buttonImage: 'calendar.png'
            });
        });
    </script>
    <style>
        body {
            width: 100%;
            margin: 5px;
            min-height: 100vh;
            position: relative;
            padding-bottom: 60px;
        }

        .table-condensed tr th {
            border: 0px solid #3385ff;
            color: white;
            background-color: #3385ff;
        }

        .table-condensed, .table-condensed tr td {
            border: 0px solid #000;
        }

        tr:nth-child(even) {
            background: #f8f7ff
        }

        tr:nth-child(odd) {
            background: #fff;
        }

        .auto-style1 {
            margin-left: 1rem;
            width: 90%;
            height: 400px;
            overflow: scroll;
        }

        footer {
            text-align: center;
            width: 100%;
            padding: 10px;
            position: absolute;
            bottom: 0;
        }
    </style>
</head>
<body>
    <form id="form2" runat="server">
        <div style="text-align: center" class="jumbotron bg-primary text-white">
            <h1 style="font-family: rockwell">Receção - Iniciar Consulta</h1>
        </div>
        <br />
        <div>
            <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True" class="ml-3">
                <asp:ListItem Text="Filtrar por data:" Value="0" />
                <asp:ListItem Text="Filtrar por número de utente:" Value="1" />
            </asp:DropDownList>
            <asp:TextBox ID="txtDate" runat="server" ReadOnly="true" Style="border-radius: 4px; left: 0px; width: 229px;" class="text-center"></asp:TextBox>
            <asp:TextBox ID="TextBox2" runat="server" ReadOnly="false" Style="border-radius: 4px; left: 0px; width: 229px;" class="text-center" Visible="false"></asp:TextBox>
        </div>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
            ControlToValidate="TextBox2" runat="server"
            ErrorMessage="Número de utente inválido"
            ValidationExpression="\d+">
        </asp:RegularExpressionValidator>
        <br />
        <div>
            <asp:Button ID="btnSubmit" runat="server" Text="Filtrar" class="btn btn-outline-primary rounded ml-3" Style="margin: 3px;" OnClick="btnSubmit_Click" />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" class="btn btn-outline-primary rounded" Style="margin: 3px" Text="Unselect/Ver todas" Visible="false" />
        </div>
        <br />
        <div class="row">
            <div class="auto-style1">
                <asp:GridView runat="server" ID="datagrid1" class="table table-condensed table-hover ml-3" Width="100%" OnRowDataBound="OnRowDataBound" OnSelectedIndexChanged="datagrid1_SelectedIndexChanged" CellPadding="3" GridLines="None" HorizontalAlign="Left" AutoGenerateColumns="False" ForeColor="#333333">
                    <Columns>
                        <asp:BoundField DataField="Id Consulta" HeaderText="Id Consulta" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Episódio" HeaderText="Episódio" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Data" HeaderText="Data" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Hora" HeaderText="Hora" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Especialidade" HeaderText="Especialidade" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="Nome Utente" HeaderText="Nome Utente" ItemStyle-Width="150">
                            <ItemStyle Width="150px"></ItemStyle>
                        </asp:BoundField>
                    </Columns>
                    <AlternatingRowStyle BackColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" ForeColor="White" Font-Bold="True" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
            </div>
        </div>
        <br />
        <asp:Label ID="Label1" runat="server" Text="Sem consulta selecionada" class="ml-3"></asp:Label>
        <br />
        <br />
        <div class="row justify-content-center">
            <div>
                <asp:Label ID="listaenfermeiros" runat="server" Text="Lista Enfermeiros"></asp:Label>
                <br />
                <asp:ListBox ID="ListBox1" Visible="true" class="form-control" Width="350px" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ListBox1_SelectedIndexChanged" Rows="5"></asp:ListBox>
            </div>
            <div class="offset-1">
                <asp:Label ID="listamedicos" runat="server" Text="Lista Médicos"></asp:Label>
                <br />
                <asp:ListBox ID="ListBox2" Visible="true" class="form-control" Width="350px" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ListBox2_SelectedIndexChanged" Rows="5"></asp:ListBox>
            </div>
        </div>
        <br />
        <br />
        <div class="card ml-3" style="width: 40%">
            <ul class="list-group list-group-flush">
                <li class="list-group-item">Utente:
                    <asp:Label ID="utente" runat="server" class="font-weight-bold"></asp:Label></li>
                <li class="list-group-item">Enfermeiro:
                    <asp:Label ID="enfermeiro" runat="server" class="font-weight-bold"></asp:Label></li>
                <li class="list-group-item">Médico:
                    <asp:Label ID="medico" runat="server" class="font-weight-bold"></asp:Label></li>
            </ul>
        </div>
        <br />
        <br />
        <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
        <br />
        <asp:Button ID="Button3" Visible="true" runat="server" Text="Voltar para Homepage" OnClick="Button3_Click" class="ml-3 btn btn-primary rounded" />
        <asp:Button ID="Button2" Visible="false" runat="server" Text="Avançar" OnClick="Button2_Click" class="ml-3 btn btn-primary rounded" />
        <br />
        <br />
        <br />
        <footer class="text-white bg-primary">
            <p>Copyright &copy; <%:DateTime.Now.Year %> MC&ML Dynamic Solutions</p>
        </footer>
    </form>
</body>
</html>
