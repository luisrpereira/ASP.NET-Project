<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Enfermagem.aspx.cs" Inherits="WebApplication4.WebForm2" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Enfermagem IPCA HEALTH</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
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
            min-height:100vh;
            position:relative;
            padding-bottom:60px;
        }

        .table-condensed tr th {
            border: 0px solid #6e7bd9;
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
        footer
        {
            text-align:center;
            width:100%;
            padding:10px;
            position:absolute;
            bottom:0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="jumbotron bg-primary text-white" style="text-align: center">
            <h1 style="font-family: rockwell">Enfermagem</h1>
        </div>
        <div style="text-align:center">
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        </div>
        <br />
        <div class="row mx-3">
            <div style="width: 100%; height: 400px; overflow: scroll">
                <asp:GridView runat="server" ID="datagrid1" CssClass="table table-condensed table-hover" Width="100%" OnRowDataBound="OnRowDataBound" OnSelectedIndexChanged="datagrid1_SelectedIndexChanged" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" HorizontalAlign="Left" AutoGenerateColumns="false" ForeColor="#333333">
                    <Columns>
                        <asp:BoundField DataField="Id Consulta" HeaderText="Id Consulta" ItemStyle-Width="150" />
                        <asp:BoundField DataField="Episódio" HeaderText="Episódio" ItemStyle-Width="150" />
                        <asp:BoundField DataField="Data" HeaderText="Data" ItemStyle-Width="150" />
                        <asp:BoundField DataField="Hora" HeaderText="Hora" ItemStyle-Width="150" />
                        <asp:BoundField DataField="Especialidade" HeaderText="Especialidade" ItemStyle-Width="150" />
                        <asp:BoundField DataField="Nome Utente" HeaderText="Nome Utente" ItemStyle-Width="150" />
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
        <asp:LinkButton ID="lnkDummy" runat="server"></asp:LinkButton>
        <br />
        <br />
        <div class="row mx-3">
            <div class="jumbotron col-md-6">
                <h4>Dados do Utente</h4>
                <br />
                <div class="form-row">
                    <div class="col-md-7">
                        <label for="nome">Nome</label>
                        <asp:Label ID="nome" runat="server" class="form-control-plaintext border border-primary rounded bg-white text-center" Text="Utente não selecionado"></asp:Label>
                    </div>
                    <div class="form-group col-md-4">
                        <label for="datanascimento">Data de Nascimento</label>
                        <asp:Label ID="datanascimento" runat="server" class="form-control-plaintext border border-primary rounded bg-white text-center" Text="Utente não selecionado"></asp:Label>
                    </div>
                </div>
                <br />
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label for="nprocesso">Nº Processo</label>
                        <asp:Label ID="nprocesso" runat="server" class="form-control-plaintext border border-primary rounded bg-white text-center" Text="Utente não selecionado"></asp:Label>
                    </div>
                    <div class="col-md-5">
                        <label for="genero">Género</label>
                        <asp:Label ID="genero" runat="server" class="form-control-plaintext border border-primary rounded bg-white text-center" Text="Utente não selecionado"></asp:Label>
                    </div>
                </div>
            </div>
            <br />
            <div class="jumbotron col-md-5 offset-1">
                <h4>Consultas Anteriores</h4>
                <br />
                <div class="form-group col-md-9">
                    <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="true" Width="212px" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="true">
                        <asp:ListItem Value="0" Text="Relatórios..."></asp:ListItem>
                    </asp:DropDownList>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ControlToValidate="DropDownList1"
                        ErrorMessage="Choose one" Font-Size="X-Large" InitialValue="0" ValidationGroup="whatever">*

                    </asp:RequiredFieldValidator>
                </div>
                <br />
                <div>
                    <asp:TextBox ID="TextBox1" runat="server" Height="230px" Width="514px" OnTextChanged="TextBox1_TextChanged" TextMode="MultiLine" ReadOnly="True"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="jumbotron mx-3">
            <h4>Medições</h4>
            <br />
            <div class="form-row mx-5">
                <div class="form-group col-sm-3">
                    <label for="tensao">Tensão Arterial Sistólica (mmHg)</label>
                    <input type="text" class="form-control border border-primary text-center" id="tensaosistolica" runat="server" />
                </div>
                <div class="form-group col-sm-3 offset-1">
                    <label for="tensao">Tensão Arterial Diastólica (mmHg)</label>
                    <input type="text" class="form-control border border-primary text-center" id="tensaodiastolica" runat="server" />
                </div>
                <div class="form-group col-sm-3 offset-1">
                    <label for="pulsacao">Pulsação (BPM)</label>
                    <input type="text" class="form-control border border-primary text-center" id="pulsacao" runat="server" />
                </div>
            </div>
            <div class="form-row mx-5">
                <div class="form-group col-sm-3">
                    <label for="peso">Peso (Kg)</label>
                    <input type="text" class="form-control border border-primary text-center" id="peso" runat="server" />
                </div>
                <div class="form-group col-sm-3 offset-1">
                    <label for="altura">Altura (m)</label>
                    <input type="text" class="form-control border border-primary text-center" id="altura" runat="server" />
                </div>
            </div>
            <br />
        </div>
        <div class="jumbotron mx-3">
            <h4>Relatório</h4>
            <br />
            <div>
                <asp:TextBox ID="notas" runat="server" class="border border-primary rounded bg-white w-75 overflow-auto navbar navbar-text" Height="150px" Rows="4" TextMode="MultiLine"></asp:TextBox>
            </div>
        </div>
        <div class="ml-3">
            <asp:Button ID="Button3" Visible="true" runat="server" Text="Voltar para Homepage" OnClick="Button3_Click" class="ml-3 btn btn-primary rounded" />
            <asp:Button ID="confirmar" runat="server" Text="Enviar para Médico" class="btn btn-primary" OnClick="confirmar_Click" />
        </div>
        <br />
        <br />
        <br />
        <footer class="text-white bg-primary">
             <p>Copyright &copy; <%:DateTime.Now.Year %> MC&ML Dynamic Solutions</p>
        </footer>
    </form>
</body>
</html>

