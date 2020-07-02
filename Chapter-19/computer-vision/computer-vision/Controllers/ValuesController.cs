using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.CognitiveServices.Vision.ComputerVision;
using Microsoft.Azure.CognitiveServices.Vision.ComputerVision.Models;


namespace computer_vision.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        // GET api/values
        [HttpGet]
        public ActionResult<IEnumerable<string>> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/values/5
        [HttpGet("{id}")]
        public ActionResult<string> Get(int id)
        {
            return "value";
        }

        // POST api/values
        [HttpPost]
        public string Post([FromBody] string value)
        {
            string visionapiurl = "https://eastus.api.cognitive.microsoft.com/vision/v2.0/analyze?visualFeaure=tags,description,objects&language=en";
            string apikey = "e55d36ac228f4d718d365f1fcddc0851";
            ComputerVisionClient client;
            List<VisualFeatureTypes> visionType = new List<VisualFeatureTypes>();
            client = new ComputerVisionClient(new ApiKeyServiceClientCredentials(apikey))
                {
                    Endpoint = visionapiurl
                };
            visionType.Add(VisualFeatureTypes.Description);
            visionType.Add(VisualFeatureTypes.Tags);
            visionType.Add(VisualFeatureTypes.Objects);

            string tags = "";
            string descrip = "";
            string objprop = "";

            using (HttpClient hc = new HttpClient()) {
                var responseMessage = hc.GetAsync(value).GetAwaiter().GetResult();
                Stream streamData = responseMessage.Content.ReadAsStreamAsync().GetAwaiter().GetResult();
                var result = client.AnalyzeImageInStreamAsync(streamData,visionType).GetAwaiter().GetResult();
                foreach (var tag in result.Tags)
                {
                    tags += tag.Name + " ";
                }
                foreach (var caption in result.Description.Captions)

                {
                    descrip += caption.Text + " ";
                }
                foreach (var obj in result.Objects)
                {
                    objprop += obj.ObjectProperty + " ";
                }
            }
            return tags;

        }

        // PUT api/values/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/values/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}
