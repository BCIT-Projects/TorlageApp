using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TorlageProjectApp.Startup))]
namespace TorlageProjectApp
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
