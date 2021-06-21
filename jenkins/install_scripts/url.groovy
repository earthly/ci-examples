import jenkins.model.Jenkins
import jenkins.model.JenkinsLocationConfiguration

def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()
jenkinsLocationConfiguration.setUrl('http://localhost:8080')
jenkinsLocationConfiguration.save()