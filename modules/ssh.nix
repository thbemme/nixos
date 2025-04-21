{ vars, ... }:

{
  networking.firewall.allowedTCPPorts = [ 22 ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };
  users.users.${vars.user}.openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDvlcGnSPhmFaUrE7TEYeSYWNkeDpu/vpdHa4hEJIXeAoGWiSMln54PkA1Fg8YI9dvfk8y56izybP6sp7fnyPgjLEo0sSlsCgHKALwYhUVkSoNLwmqjG25KgC/qjpzszvx9p8OtqPvuKLj6cRibCJIHN4+otMKGw+PQy5R1nPqP6an1esxezL+mehwlnIx8Gda0Gg8McAfslgGr3M/SVJ3RuWoPqC4socOM8OB463N3mR7iMRUG7/g0N/YYsvLFczHyEyCB6eFFyomHsORnvwywVVIK7hRTa8ppt/ypqWTL2ya4fhfvgM/jUXgpJK0VcwT8JRKyRlE5QSo53IKc0H0kjMjMhj8o7RNPg6GdOl/fb6/GqvVigZv20EVyXdRtvrqU4EyB1OmDWwYor1WqxrbLJg3GDXxH7Iyqr7NwOXBZ/YgLzBIXg4wV8iiwTsRtTTYfBGS4FQb2lyYzZU8G90Z9a9sqaslwXgRqmX5XQ3AeYDQOTb6p+5W9+r4EoJX9Wck= ${vars.user}@${vars.hostname}" ];
}
