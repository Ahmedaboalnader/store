terraform { 
  cloud { 
    
    organization = "ahmedaboalnder" 

    workspaces { 
      name = "my-infra" 
    } 
  } 
}