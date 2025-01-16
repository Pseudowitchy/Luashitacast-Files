spellReqs = T{};

spellReqs.BLM = { -- [1] = Level, [2] = MP Cost 
    Stone = {
        [1] = { [1] = 1,  [2] = 9 },
        [2] = { [1] = 26, [2] = 43 },
        [3] = { [1] = 51, [2] = 92 },
        [4] = { [1] = 68, [2] = 2000 },
    },

    Water = {
        [1] = { [1] = 5,  [2] = 9 },
        [2] = { [1] = 30, [2] = 51 },
        [3] = { [1] = 55, [2] = 98 },
        [4] = { [1] = 70, [2] = 2000 },
    },

    Aero = {
        [1] = { [1] = 9,  [2] = 9 },
        [2] = { [1] = 34, [2] = 59 },
        [3] = { [1] = 59, [2] = 105 },
        [4] = { [1] = 72, [2] = 2000 },
    },

    Fire = {
        [1] = { [1] = 13, [2] = 9 },
        [2] = { [1] = 38, [2] = 68 },
        [3] = { [1] = 62, [2] = 113 },
        [4] = { [1] = 73, [2] = 2000 },
    },

    Blizzard = {
        [1] = { [1] = 17, [2] = 9 },
        [2] = { [1] = 42, [2] = 77 },
        [3] = { [1] = 64, [2] = 120 },
        [4] = { [1] = 74, [2] = 2000 },
    },

    Thunder = {
        [1] = { [1] = 21, [2] = 9 },
        [2] = { [1] = 46, [2] = 86 },
        [3] = { [1] = 66, [2] = 128 },
        [4] = { [1] = 75, [2] = 2000 },
    },
}

return spellReqs;