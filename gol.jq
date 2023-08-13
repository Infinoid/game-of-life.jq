# filter out the out-of-bounds coords from an array
def inbounds(len): [.[] | select(.[0] >= 0) | select(.[1] >= 0) | select(.[0] < len) | select(.[1] < len)];
# produce a list of neighbor coordinates
def neighborlist(ypos;xpos): . as $state | ([.neighboriter[] as $x | .neighboriter[] as $y | [$y+ypos,$x+xpos]] - [[ypos,xpos]]) | inbounds($state.len);
# produce a sum of neighbor values
def neighborcount(ypos;xpos): . as $state | neighborlist(ypos;xpos) | reduce .[] as $pos (0; . + $state.oldstate[$pos[0]][$pos[1]]);

# temporary state structure
{
    "oldstate": .,                    # old board state
    "len": .[0]|length,               # size of the board (one side)
    "fulliter": [range(.[0]|length)], # iterator for board cells
    "neighboriter": [range(-1;2)],    # iterator for neighbor stencil
}
# new board state
| . + {
    "newstate": [
        .fulliter[] as $y | [
            .fulliter[] as $x |
            neighborcount($y;$x) as $count |
            if .oldstate[$y][$x] == 1 then
                # existing cells stay alive if they have 2 or 3 neighbors
                if $count == 2 or $count == 3 then
                    1
                else
                    0
                end
            else
                # empty cells become alive if they have exactly 3 neighbors
                if $count == 3 then
                    1
                else
                    0
                end
            end
        ]
    ]
}
# only output the new state
| .newstate
