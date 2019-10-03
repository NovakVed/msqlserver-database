using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Hotel
{
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        private void Form2_Load(object sender, EventArgs e)
        {
            // TODO: This line of code loads data into the 'hotelBazaDataSet3.Racun' table. You can move, or remove it, as needed.
            this.racunTableAdapter.Fill(this.hotelBazaDataSet3.Racun);
            // TODO: This line of code loads data into the 'hotelBazaDataSet.Popusti' table. You can move, or remove it, as needed.
            this.popustiTableAdapter.Fill(this.hotelBazaDataSet.Popusti);
            // TODO: This line of code loads data into the 'hotelBazaDataSet1.Hotel' table. You can move, or remove it, as needed.
            this.hotelTableAdapter.Fill(this.hotelBazaDataSet1.Hotel);

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void button6_Click(object sender, EventArgs e)
        {

        }

        private void label6_Click(object sender, EventArgs e)
        {

        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
    }
}
