using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;

namespace ocp_app.Controllers
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
        public async Task<string> Post([FromBody] string value)
        {
            string myurl = " https://eastus.api.cognitive.microsoft.com/vision/v2.0/ocr?language=en&detectOrientation=true";
            string token = "…………………………";
            using (HttpClient httpClient = new HttpClient())
            {
                var responseMessage = await httpClient.GetAsync(value);

                using (var httpClient1 = new HttpClient())
                {
                    httpClient1.BaseAddress = new Uri(myurl);
                    httpClient1.DefaultRequestHeaders.Add("Ocp-ApimSubscription-Key", token);
                    HttpContent content = responseMessage.Content;
                    content.Headers.ContentType = new MediaTypeWithQualityHeaderValue("application/octet-stream");
                    var response = await httpClient1.PostAsync(myurl, content);
                    var responseContent = await response.Content.ReadAsByteArrayAsync();
                    string ret = Encoding.ASCII.GetString(responseContent, 0, responseContent.Length);
                    dynamic image = JsonConvert.DeserializeObject<object>(ret);
                    string temp = "";
                    foreach (var regs in image.regions)
                    {
                        foreach (var lns in regs.lines)
                        {
                            foreach (var wds in lns.words)
                            {
                                temp += wds.text + " ";
                            }
                        }
                    }
                    return temp;
                }
            }
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
