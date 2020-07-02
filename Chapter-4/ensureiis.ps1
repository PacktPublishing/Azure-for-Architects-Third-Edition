configuration ensureiis {
import-dscresource -modulename psdesiredstateconfiguration
    
node localhost {        
        WindowsFeature iis {
            Name = "web-server"
            Ensure = "Present"
             
        }
    }
}