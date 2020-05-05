using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ServerMD.Models
{
    public class Solider
    {
        public string Nick { get; set; }
        public PosVextor3 Pos { get; set; }
        public PosVextor3 Velocity { get; set; }
    }
}
