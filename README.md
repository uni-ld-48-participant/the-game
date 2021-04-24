stomper:
  count: 1
  actions:
    - wasd to move on free space in direction
    - wasd to dig tile in direction
    - 1-9 use ability
    - space - pickup/drop item on same tile
  collisions:
    - tile

woomper:
  count: 6
  behaviour:
    - dont like cold ( with delta? )
  weakness:
    - temperature
  actions:
    - move left/right to closest mushroom
    - comsume mushroom in same time - 5% per sec
    - move left/right to closest campfire if no mushroom in sigth
  collisions:
    - tile
    - woomper ( cannot stop in same place )
    - boulder

items:
    camp_fire:
      - stored in backpack
      - + temp
      - timeout/permanent
    mushroom:
      - attracts woompers
    boulder:
      - collision with woomper

tiles:
  empty:
    conductivity: 1

  dirt:
    hp: 100
    conductivity: 3

  rock:
    hp: 0
    conductivity: 3

  metal:
    hp: 500
    conductivity: 10

  coal:
    hp: 500
    effect_after_drill: +1 campfire

  ice:
    hp: 1000
    weackness: campfire
    effect: -temp

goal: survive

  
    
