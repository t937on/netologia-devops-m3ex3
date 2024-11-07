locals {
  rc_1 = [for i in range(1, 100) : format("rc%02d", i)]

  rc_2 = [
    # for i in range(1, 97) :
    for i in range(1, 100) :
    format("rc%02d", i) if !(i % 10 == 0 || i % 10 == 7 || i % 10 == 8 || i % 10 == 9) || i == 19
  ]
}

