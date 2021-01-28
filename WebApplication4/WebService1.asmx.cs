using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SQLite;
using System.Data.SqlClient;
using System.Net.Http;
using System.Xml;
using System.Data;

namespace WebApplication4
{
    /// <summary>
    /// Descrição resumida de WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Para permitir que esse serviço da web seja chamado a partir do script, usando ASP.NET AJAconsulta, remova os comentários da linha a seguir. 
    [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {
        private static SQLiteConnection sqliteConnection;

        private static SQLiteConnection DbConnection()
        {
            sqliteConnection = new SQLiteConnection(@"Data Source=C:\Users\Luís\Desktop\WebApplication4\WebApplication4\isc.db");
            sqliteConnection.Open();
            return sqliteConnection;
        }


        public int Nrows()
        {
            using (var cmd = DbConnection().CreateCommand())
            {
                cmd.CommandText = "SELECT COUNT(*) FROM Consulta";
                return (Int32.Parse(cmd.ExecuteScalar().ToString()));

            }

        }

        public bool ConsultaNotinDB(string id)
        {
            using (var cmd = DbConnection().CreateCommand())
            {

                cmd.CommandText = ("SELECT COUNT(*) FROM Consulta WHERE Id_Esp = @id");
                cmd.Parameters.AddWithValue("@id", id);
                int UserEconsultaist = Int32.Parse(cmd.ExecuteScalar().ToString());

                if (UserEconsultaist > 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }

        public bool UtenteNotinDB(string processo)
        {
            using (var cmd = DbConnection().CreateCommand())
            {

                cmd.CommandText = ("SELECT COUNT(*) FROM Utente WHERE Processo = @processo");
                cmd.Parameters.AddWithValue("@processo", processo);
                int UserEconsultaist = Int32.Parse(cmd.ExecuteScalar().ToString());

                if (UserEconsultaist > 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }

        [WebMethod(Description = "Verificar se Médico está na database")]
        public bool MedicoNotinDB(string processo)
        {
            using (var cmd = DbConnection().CreateCommand())
            {

                cmd.CommandText = ("SELECT COUNT(*) FROM Medico WHERE NOrdem = @NOrdem");
                cmd.Parameters.AddWithValue("@NOrdem", processo);
                int UserEconsultaist = Int32.Parse(cmd.ExecuteScalar().ToString());

                if (UserEconsultaist > 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }
        [WebMethod(Description = "Verificar se Enfermeiro está na database")]
        public bool EnfermeiroNotinDB(string processo)
        {
            using (var cmd = DbConnection().CreateCommand())
            {

                cmd.CommandText = ("SELECT COUNT(*) FROM Enfermeiro WHERE NMec = @NMec");
                cmd.Parameters.AddWithValue("@NMec", processo);
                int UserEconsultaist = Int32.Parse(cmd.ExecuteScalar().ToString());

                if (UserEconsultaist > 0)
                {
                    return false;
                }
                else
                {
                    return true;
                }
            }
        }



        [WebMethod(Description = "Utentes e Consultas From SOAP to Database")]
        public void ReadToDB()
        {
            try
            {
                using (var cmd = DbConnection().CreateCommand())
                {
                    Healthipcasoap.HealthIPCAsoap obj = new Healthipcasoap.HealthIPCAsoap();

                    Healthipcasoap.Consulta[] consulta = obj.DaConsultasTodas();

                    Healthipcasoap.Utente[] utente = obj.DaUtentesTodos();


                    for (int i = 0; i < consulta.Length; i++)

                    {
                        if (ConsultaNotinDB(consulta[i].Id.ToString()) == true)
                        {


                            



                            cmd.CommandText = "INSERT INTO Consulta (Id_Esp,Ep,Mod,Data,Hora,Esp,Processo,Estado) VALUES (@Id_Esp,@Ep,@Mod,@Data,@Hora,@Esp,@Processo,@Estado)";
                            
                            cmd.Parameters.AddWithValue("@Id_Esp", consulta[i].Id);
                            cmd.Parameters.AddWithValue("@Ep", consulta[i].Episodio);
                            cmd.Parameters.AddWithValue("@Mod", consulta[i].Modulo);
                            cmd.Parameters.AddWithValue("@Data", consulta[i].Data);
                            cmd.Parameters.AddWithValue("@Hora", consulta[i].Hora);
                            cmd.Parameters.AddWithValue("@Esp", consulta[i].Especialidade);
                            cmd.Parameters.AddWithValue("@Processo", consulta[i].Processo);
                            cmd.Parameters.AddWithValue("@Estado", "Agendada");
                            cmd.ExecuteNonQuery();
                        }
                    }

                    for (int i = 0; i < utente.Length; i++)

                    {
                        if (UtenteNotinDB(utente[i].Processo.ToString()) == true)
                        {






                            cmd.CommandText = "INSERT INTO Utente (Processo,Nome,DataNasc,Sexo) VALUES (@Processo,@Nome,@DataNasc,@Sexo)";
                            cmd.Parameters.AddWithValue("@Processo", utente[i].Processo);
                            cmd.Parameters.AddWithValue("@Nome", utente[i].Nome);
                            cmd.Parameters.AddWithValue("@DataNasc", utente[i].DataNascimento);
                            cmd.Parameters.AddWithValue("@Sexo", utente[i].Sexo);

                            cmd.ExecuteNonQuery();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
          
        [WebMethod]
        public DataSet ConsultasTerminadas()
        {
            DataSet ds = new DataSet();
            
            
            try
            {
                using (var cmd = DbConnection())
                {
                    string sql = "Select * From Consulta where Estado='End'";
                    SQLiteDataAdapter da = new SQLiteDataAdapter(sql, cmd);
                    da.Fill(ds, "Consultas");
                    
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

        [WebMethod]
        public DataSet TodasConsultas()
        {
            DataSet ds = new DataSet();


            try
            {
                using (var cmd = DbConnection())
                {
                    string sql = "Select * From Consulta where Estado='End'";
                    SQLiteDataAdapter da = new SQLiteDataAdapter(sql, cmd);
                    da.Fill(ds, "Consultas");

                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return ds;
        }

    }
}