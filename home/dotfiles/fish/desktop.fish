function r
  nh os switch $argv
end
function u
  nh os switch --update $argv
end
function c
  nh clean all --keep 5
end