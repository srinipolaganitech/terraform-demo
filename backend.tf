terraform {
  backend "terraform" {
    organization = "cloudaifocus"
    workspaces {
      name = "ws-terraform-demo"
    
  }
}
}
