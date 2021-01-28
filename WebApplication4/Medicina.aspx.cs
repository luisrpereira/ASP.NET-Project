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
    public partial class WebForm3 : System.Web.UI.Page
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

                if (dtbl.Rows.Count == 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('O Médico selecionado não tem consultas em espera');window.location='HomePage.aspx';", true);

                }
                else
                {

                    datagrid1.DataSource = dtbl;
                    datagrid1.DataBind();
                }
            }
        }
        public string datetodb(string data)
        {
            string mes = data.Split('/')[1];
            string dia = data.Split('/')[0];
            string ano = data.Split('/')[2];

            return ano + "-" + mes + "-" + dia;
        }

        private void RelDropDown(string utente)
        {
            using (var cmd = DbConnection())
            {
                SQLiteDataAdapter adpt = new SQLiteDataAdapter("Select Data,Hora From Consulta where Processo='" + utente + "' and Estado='End'", cmd);

                DataSet myDataSet = new DataSet();

                adpt.Fill(myDataSet, "Consulta");

                DataTable myDataTable1 = myDataSet.Tables[0];
                

                DataRow tempRow = null;



                foreach (DataRow tempRow_Variable in myDataTable1.Rows)

                {

                    tempRow = tempRow_Variable;

                    DropDownList1.Items.Add(tempRow["Data"].ToString().Split(' ')[0]+" "+ tempRow["Hora"].ToString().Split(' ')[1]);
                }
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = "Lista de consultas do Médico: " + Session["Med"].ToString();

            if (!this.IsPostBack) CriarTabela("SELECT Id_Esp,EP,Data,Hora,Esp,Nome FROM Consulta inner join Utente on Consulta.Processo = Utente.Processo where Estado='Med' AND Med='" + Session["Med"].ToString().Split('(')[0] + "' ORDER BY data,hora ASC ");
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

                    nome.Text = row.Cells[5].Text.ToString();
                    using (var cmd = DbConnection().CreateCommand())
                    {
                        cmd.CommandText = "select DataNasc from Consulta inner join Utente on consulta.Processo=utente.Processo where Consulta.Id_Esp= '" + row.Cells[0].Text.ToString() + "'";
                        datanascimento.Text = cmd.ExecuteScalar().ToString().Split(' ')[0];
                        cmd.CommandText = "select Consulta.Processo from Consulta inner join Utente on consulta.Processo=utente.Processo where Consulta.Id_Esp= '" + row.Cells[0].Text.ToString() + "'";
                        nprocesso.Text = cmd.ExecuteScalar().ToString();
                        cmd.CommandText = "select Sexo from Consulta inner join Utente on consulta.Processo=utente.Processo where Consulta.Id_Esp= '" + row.Cells[0].Text.ToString() + "'";
                        genero.Text = cmd.ExecuteScalar().ToString();
                        cmd.CommandText = "select RelEnf from Consulta inner join Utente on consulta.Processo=utente.Processo where Consulta.Id_Esp= '" + row.Cells[0].Text.ToString() + "'";

                        TextBox1.Text = cmd.ExecuteScalar().ToString();
                        cmd.CommandText = "select consulta.processo from Consulta inner join Utente on consulta.Processo=utente.Processo where Consulta.Id_Esp= '" + row.Cells[0].Text.ToString() + "'";

                        RelDropDown(cmd.ExecuteScalar().ToString());
                        if (DropDownList1.Items.Count == 1) TextBox2.Text = "Sem consultas anteriores";
                    }
                }
                else
                {
                    row.BackColor = ColorTranslator.FromHtml("#FFFFFF");
                    row.ToolTip = "Click to select this row.";
                }
            }

        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {

        }

        protected void confirmar_Click(object sender, EventArgs e)
        {
            string[] med = new string[16];
            for (int i = 1; i < 15; i++)
            {
                string x = "p" + i.ToString();
                if (Request.Form[x] == null)
                {
                    med[i] = "";
                }
                else med[i] = Request.Form[x].ToString();
            }
            
                string medicoes = "Recentemente hospitalizado : " + med[1] + "\nOperado recentemente : " + med[2] + "\nPerdas de consciência, epilepsia : " +
                    med[3] + "\nDores de ouvidos, sinusite, rinite : " + med[4] + "\nQueixas pulmonares, asma, pneumotórax, tuberculose : " + med[5] +
                    "\nQueixas ao nível da digestão, azia, úlcera : " + med[6] + "\nQueixas ao nível do sistema renal? : " + med[7]+
                    "\nDores nos ossos, coluna, articulações : " + med[8] + "\nManchas na pele : " + med[9] + "\nAlergias : "
                    + med[10] + "\nNíveis de tensão arterial descontrolados : " +med[11]+ "\nConsome narcóticos ou estimulantes : "
                    + med[12] + "\nPossui hábitos alcoólicos : " + med[13] + "\nPossui hábitos tabágicos : " + med[14] + "\nRelatório Médico: " + notasmedico.Text;
            
            using (var cmd = DbConnection().CreateCommand())
            {
                foreach (GridViewRow row in datagrid1.Rows)
                {
                    if (row.RowIndex == datagrid1.SelectedIndex)
                    {
                        cmd.CommandText = "UPDATE Consulta SET Estado=@es, RelMed=@relmed WHERE Id_Esp = '" + row.Cells[0].Text.ToString() + "'";

                        cmd.Parameters.AddWithValue("@es", "End");
                        cmd.Parameters.AddWithValue("@relmed", medicoes);


                        cmd.ExecuteNonQuery();
                    }
                }
            }
            ClientScript.RegisterStartupScript(this.GetType(), "Alert", "alert('Obrigado! Esta consulta está concluida');window.location='HomePage.aspx';", true);

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList1.Items[0].Selected == false)
            {
                using (var cmd = DbConnection().CreateCommand())
                {
                    DateTime hora = DateTime.Parse(DropDownList1.SelectedValue.ToString().Split(' ')[1], System.Globalization.CultureInfo.CurrentCulture);
                    string hora1 = hora.ToString("HH:mm");
                    cmd.CommandText = "Select RelMed from Consulta where processo=" + nprocesso.Text + " and data='" + datetodb(DropDownList1.SelectedValue.ToString().Split(' ')[0]) + "' and hora='"  + hora1 + "'";
                    TextBox2.Text =  cmd.ExecuteScalar().ToString();
                        
                    
                }
            }
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("HomePage.aspx", false);
        }
    }
}