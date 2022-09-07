CM.make "closest_to_origin_testing.cm";

val _ = ( ClosestToOriginTesting.test_closest_to_origin()
        ; OS.Process.exit(OS.Process.success)
        )
