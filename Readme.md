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
~~~

Then in the code editor, use this function:

~~~javascript
function(game, team1, team2) {
  var normalize, stat, weighted;
  team1.score = 0;
  team2.score = 0;
  normalize = function(num, stat) {
    var max, min, _ref;
    _ref = minMax[stat], min = _ref[0], max = _ref[1];
    return (num - min) / (max - min);
  };
  weighted = function(team, stat) {
    var normal;
    normal = normalize(team[stat], stat);
    return normal * weights[stat];
  };
  for (stat in weights) {
    if (!team1[stat]) {
      console.log("" + stat + " is not a valid statistic");
      continue;
    }
    team1.score += weighted(team1, stat);
    team2.score += weighted(team2, stat);
  }
  if (team1.score >= team2.score) {
    return team1.winsGame();
  } else {
    return team2.winsGame();
  }
}
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