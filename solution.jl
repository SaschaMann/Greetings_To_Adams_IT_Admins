using OffsetArrays
using Test

function solve1(input="input"; days=80)
    fish = parse.(Int, split(open(f -> read(f, String), input), ","))

    for _ in 1:days
        for (i, f) in enumerate(fish)
            if f == 0
                push!(fish, 9)
                fish[i] = 7
            end
        end

        fish .-= 1
    end

    length(fish)
end

function solve2_initial(input="input"; days=256)
    _fish = parse.(Int, split(open(f -> read(f, String), input), ","))
    fish = Dict(i => 0 for i in 0:9)
    for f in _fish
        fish[f] += 1
    end

    for _ in 1:days
        fish[9] += fish[0]
        fish[7] += fish[0]

        for i in 0:8
            fish[i] = fish[i + 1]
        end

        fish[9] = 0
    end

    sum(values(fish))
end

function solve2(input="input"; days=256)
    _fish = parse.(Int, split(open(f -> read(f, String), input), ","))
    fish = OffsetArray(zeros(Int, 10), 0:9)
    for f in _fish
        fish[f] += 1
    end

    for _ in 1:days
        fish[9] += fish[0]
        fish[7] += fish[0]

        for i in 0:8
            fish[i] = fish[i + 1]
        end

        fish[9] = 0
    end

    sum(fish)
end

function test()
    @testset "Day 6" begin
        @test solve2("test_input", days=80) == 5934
        @test solve2("test_input") == 26984457539
        @test solve2("input", days=80) == 375482
        @test solve2("input") == 1689540415957
    end

    nothing
end
