function r
  nh os switch --ask $argv
end
function u
  nh os switch --update --ask $argv
end
function c
  nh clean all --keep 5
end