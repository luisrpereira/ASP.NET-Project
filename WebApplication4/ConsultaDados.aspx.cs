using Newtonsoft.Json.Linq;
using System;
using System.Data;
using System.Data.SQLite;
using System.Linq;
using System.Net.Http;
using System.Drawing;
using System.Web.UI.WebControls;

namespace WebApplication4
{
    public partial class WebForm5 : System.Web.UI.Page
    {
        private static SQLiteConnection sqliteConnection;

        private static SQLiteConnection DbConnection()
        {
            sqliteConnection = new SQLiteConnection(@"Data Source=C:\Users\Luís\Desktop\WebApplication4\WebApplication4\isc.db");
            sqliteConnection.Open();
            return sqliteConnection;
        }
        public void CriarTabela(string query)
        {
            using (var cmd = DbConnection())
            {
                SQLiteDataAdapter sqlDa = new SQLiteDataAdapter(query, cmd);
                DataTable dtbl = new DataTable();
                sqlDa.Fill(dtbl);


                dtbl.Columns["Id_Esp"].ColumnName = "Id Consulta";
                dtbl.Columns["Ep"].ColumnName = "Episódio";


                dtbl.Columns["Esp"].ColumnName = "Especialidade";

                dtbl.Columns["Nome"].ColumnName = "Nome Utente";

                datagrid1.DataSource = dtbl;
                datagrid1.DataBind();

            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack) CriarTabela("SELECT Id_Esp,EP,Data,Hora,Esp,Nome FROM Consulta inner join Utente on Consulta.Processo = Utente.Processo where Estado=\"End\" ORDER BY data,hora ASC ");

        }
        protected void OnRowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(datagrid1, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Click to select this row.";
                e.Row.Cells[2].Text = Convert.ToDateTime(e.Row.Cells[2].Text).ToString("dd, MMM yyyy");
                e.Row.Cells[3].Text = Convert.ToDateTime(e.Row.Cells[3].Text).ToString("HH:mm");




            }

        }


        protected void datagrid1_SelectedIndexChanged(object sender, EventArgs e)
        {

            foreach (GridViewRow row in datagrid1.Rows)
            {
                if (row.RowIndex == datagrid1.SelectedIndex)
                {
                    row.BackColor = ColorTranslator.FromHtml("#A1DCF2");
                    row.ToolTip = string.Empty;
                   
                    Button1.Visible = true;

                    using (var cmd = DbConnection().CreateCommand())
                    {
                        cmd.CommandText="Select RelEnf from consulta where Id_Esp='"+row.Cells[0].Text+"'";
                        TextBox1.Text = cmd.ExecuteScalar().ToString();
                        cmd.CommandText = "Select RelMed from consulta where Id_Esp='" + row.Cells[0].Text + "'";
                        TextBox2.Text = cmd.ExecuteScalar().ToString();

                        cmd.CommandText = "Select processo from consulta where Id_Esp='" + row.Cells[0].Text + "'";

                        utente.Text = "("+cmd.ExecuteScalar().ToString()+") "+row.Cells[5].Text;
                        cmd.CommandText = "Select Enf from consulta where Id_Esp='" + row.Cells[0].Text + "'";
                        string enfn = cmd.ExecuteScalar().ToString();
                        cmd.CommandText = "Select nome from Enfermeiro where Nmec='" + enfn + "'";
                        string enfnome=cmd.ExecuteScalar().ToString();

                        enfermeiro.Text = "("+enfn+") "+enfnome;

                        cmd.CommandText = "Select Med from consulta where Id_Esp='" + row.Cells[0].Text + "'";
                        string medn = cmd.ExecuteScalar().ToString();
                        cmd.CommandText = "Select nome from Medico where NOrdem='" + medn + "'";

                        medico.Text = "("+medn+") "+cmd.ExecuteScalar().ToString();

                    }


                }
                else
                {
                    row.BackColor = ColorTranslator.FromHtml("#FFFFFF");
                    row.ToolTip = "Click to select this row.";
                }
            }

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in datagrid1.Rows)
            {
                if (row.RowIndex == datagrid1.SelectedIndex)
                {
                    datagrid1.SelectedIndex = -1;
                    //Label1.Text = "Sem consulta selecionada";
                    TextBox1.Text = "";
                    TextBox2.Text = "";
                    //TextBox3.Text = "";
                    utente.Text = "";
                    enfermeiro.Text = "";
                    medico.Text = "";

                }
            }
                string dt = Request.Form[txtDate.UniqueID];
                if (DropDownList1.SelectedItem.Value == "0")
                {
                    if (dt != "")
                    {
                        Button1.Visible = true;
                        string mes = dt.Split('/')[0];
                        string dia = dt.Split('/')[1];
                        string ano = dt.Split('/')[2];
                        CriarTabela("SELECT Id_Esp,EP,Data,Hora,Esp,Nome FROM Consulta inner join Utente on Consulta.Processo = Utente.Processo where Data= '" + ano + "-" + mes + "-" + dia + "' AND Estado=\"End\" order by data,hora ASC ");


                    }
                }
                else
                {
                    Button1.Visible = true;
                    CriarTabela("SELECT Id_Esp,EP,Data,Hora,Esp,Nome FROM Consulta inner join Utente on Consulta.Processo = Utente.Processo where Consulta.processo='" + TextBox3.Text + "' AND Estado=\"End\" order by data,hora ASC ");

                }
            
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            CriarTabela("SELECT Id_Esp,EP,Data,Hora,Esp,Nome FROM Consulta inner join Utente on Consulta.Processo = Utente.Processo where Estado=\"End\" ORDER BY date(data) ASC ");
            foreach (GridViewRow row in datagrid1.Rows)
            {
                if (row.RowIndex == datagrid1.SelectedIndex)
                {
                    datagrid1.SelectedIndex = -1;
                    //Label1.Text = "Sem consulta selecionada";
                    TextBox1.Text = "";
                    TextBox2.Text = "";
                    TextBox3.Text = "";
                    utente.Text = "";
                    enfermeiro.Text = "";
                    medico.Text = "";
                }
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx", false);
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextBox1.Text = "";
            TextBox2.Text = "";
            TextBox3.Text = "";
            utente.Text = "";
            enfermeiro.Text = "";
            medico.Text = "";

            if (DropDownList1.SelectedItem.Value == "1")
            {
                txtDate.Visible = false;
                TextBox3.Visible = true;

            }
            else
            {

                txtDate.Visible = true;
                txtDate.ReadOnly = true;
                TextBox3.Visible = false;
            }
        }

        /* protected void Button5_Click(object sender, EventArgs e)
         {
             foreach (GridViewRow row in datagrid1.Rows)
             {
                 if (row.RowIndex == datagrid1.SelectedIndex)
                 {
                     datagrid1.SelectedIndex = -1;
                     Label1.Text = "Sem consulta selecionada";
                     TextBox1.Text = "";
                     TextBox2.Text = "";
                     TextBox3.Text = "";
                     utente.Text = "";
                     enfermeiro.Text = "";
                     medico.Text = "";

                 }
             }
             string dt = Request.Form[txtDate.UniqueID];


             Button1.Visible = true;

             CriarTabela("SELECT Id_Esp,EP,Data,Hora,Esp,Nome FROM Consulta inner join Utente on Consulta.Processo = Utente.Processo where Consulta.processo='" + TextBox3.Text + "' AND Estado=\"End\" ");



         }*/

    }
    
}