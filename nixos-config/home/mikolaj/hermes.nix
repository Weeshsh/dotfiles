{ inputs, ... }:

{
  imports = [
    inputs.hermes-agent.homeManagerModules.default
  ];

  programs.hermes-agent.enable = true;

  home.sessionVariables = {
    FIRECRAWL_API_URL = "http://127.0.0.1:3002";
  };
}