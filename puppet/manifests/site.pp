
node default { 
  notify { "${::hostname} fell through to default node classification.": }
}
