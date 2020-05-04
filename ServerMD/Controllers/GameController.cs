using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using ServerMD.Models;

namespace ServerMD.Controllers
{
    [Route("api/[controller]")]
    [Produces("application/json")]
    public class GameController : ControllerBase
    {
        public IActionResult Index()
        {
            var collider = new
            {
                pos= new MyPosVextor3 { X= -11.8f, Y=-8.2f, Z=0.0f },
                velocity = new MyPosVextor3 { X = 14.7f, Y=17.5f, Z = 0.0f }
            };

            return Ok(collider);
        }
    }
}