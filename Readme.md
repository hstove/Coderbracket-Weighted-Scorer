# [CodersBracket](https://www.codersbracket.com) Weighted Scoring

This is some code for filling out a bracket based on
a 'score based' methodology. [CodersBracket](https://www.codersbracket.com)
provides most of what we need for this.

This works by assigning weights to statistics that
you think are important. For each statistic, the value
is first normalized between 0 and 1. Then, that score is
multiplied by the weight you give it. A team's total
score is the sum of the scores for every statistic.

## How To

Create an account on [CodersBracket](https://www.codersbracket.com)
and start a new bracket.

Open the developer console, and paste in this code.
We need to run this code in the console to gather some 'state'.
Feel free to change, add, and remove the statistics used
in the 'weights' variable. You don't need to change any
other code. But you can :scream:

~~~javascript
var max, min, minMax, stat, statValues, team, values, weights, _i, _len;

weights = {
  def_reb: 2,
  off_reb: 2,
  free_throw_pct: 3,
  blocks_per_game: 2,
  three_point_pct: 4,
  win_pct: 5
};

statValues = {};

for (_i = 0, _len = teams.length; _i < _len; _i++) {
  team = teams[_i];
  for (stat in weights) {
    statValues[stat] || (statValues[stat] = []);
    statValues[stat].push(team[stat]);
  }
}

minMax = {};

for (stat in statValues) {
  values = statValues[stat];
  max = Math.max.apply(null, values);
  min = Math.min.apply(null, values);
  minMax[stat] = [min, max];
}

editor.setValue("function(game, team1, team2) {\n  var normalize, stat, weighted;\n  team1.score = 0;\n  team2.score = 0;\n  normalize = function(num, stat) {\n    var max, min, _ref;\n    _ref = minMax[stat], min = _ref[0], max = _ref[1];\n    return (num - min) / (max - min);\n  };\n  weighted = function(team, stat) {\n    var normal;\n    normal = normalize(team[stat], stat);\n    return normal * weights[stat];\n  };\n  for (stat in weights) {\n    if (!team1[stat]) {\n      console.log(\"\" + stat + \" is not a valid statistic\");\n      continue;\n    }\n    team1.score += weighted(team1, stat);\n    team2.score += weighted(team2, stat);\n  }\n  if (team1.score >= team2.score) {\n    return team1.winsGame();\n  } else {\n    return team2.winsGame();\n  }\n}");
~~~

Hit `generate` and watch your bracket get made!! You can
tweak your weights in the console and regenerate your
bracket to see how it effects your results.

### Contributing

The original code is written in coffeescript. Please do
not submit pull requests with manually generated javascript.

To compile javascript as you code, run:

~~~
bundle install
guard
~~~