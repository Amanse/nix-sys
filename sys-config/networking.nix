{config, ...}:

{
	networking.hostName="nixxy";

	networking.firewall={
	  enable=true;
	  allowedUDPPortRanges = [
		  {
			  from=1714;
			  to=1764;
		  }
	  ];
	  allowedTCPPortRanges = [
		  {
			  from=1714;
			  to=1764;
		  }
	  ];
	};

	time.timeZone="Asia/Kolkata";
	services.openssh.enable=true;

}
